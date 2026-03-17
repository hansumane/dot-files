#!/usr/bin/env python3
from os import linesep
from sys import argv, exit as sys_exit
import json


def usage():
    print(f"Usage: scan-includes.py /path/to/compile_commands.json [filter1 [filter2 [... [filter N]]]]{linesep}"
          f"       - str:filterN = \"file\" startswith filter if filter[0] == '/' or{linesep}"
          f"       - str:filterN = filter in \"file\" if filter[0] != '/'{linesep}"
          f"Example:{linesep}"
          f"  scan-includes.py ./build/compile_commands.json '/home/kid/virtual/projects/wireshark/epan/dissectors'{linesep}"
          f"  scan-includes.py ./build/compile_commands.json 'drivers/net/ethernet/intel/igb'{linesep}")
    sys_exit(1)


def main(args: list[str]):
    compile_commands_path = args[0]
    filters = args[1:]
    with open(compile_commands_path, "r") as f:
        data: list[dict[str, str]] = json.load(f)

    others: set[str] | list[str] = set()
    includes: set[str] | list[str] = set()
    auto_includes: set[str] | list[str] = set()
    functs: set[str] | list[str] = set()
    ms: set[str] | list[str] = set()
    warns: set[str] | list[str] = set()
    defines: set[str] | list[str] = set()

    for e in data:
        process = len(filters) == 0
        for filter in filters:
            if filter.startswith("/"):
                filter_satisfy = e["file"].startswith(filter)
            else:
                filter_satisfy = filter in e["file"]
            process = process or filter_satisfy
        if not process:
            continue

        if "arguments" in e:
            arguments = e["arguments"]
        elif "command" in e:
            arguments = e["command"].strip().split()
        else:
            raise ValueError("No arguments or command in compile_commands entry")

        next_isystem = False
        next_include = False

        for arg in arguments:

            if arg == "-isystem":
                next_isystem = True
            elif arg == "-include":
                next_include = True
            elif next_isystem:
                includes.add("-I" + arg + "  # system")
                next_isystem = False
            elif next_include:
                auto_includes.add("-include " + arg)
                next_include = False

            elif not arg.startswith("-") or arg in ("-c", "-o"):
                pass

            elif arg.startswith("-I"):
                includes.add(arg)

            elif arg.startswith("-DKBUILD_BASENAME"):
                defines.add("-DKBUILD_BASENAME=\"MODULE_BASENAME\"")
            elif arg.startswith("-DKBUILD_MODFILE"):
                defines.add("-DKBUILD_MODFILE=\"path/to/MODULE_FILE\"")
            elif arg.startswith("-DKBUILD_MODNAME"):
                defines.add("-DKBUILD_MODNAME=\"MODULE_NAME\"")
            elif arg.startswith("-D__KBUILD_MODNAME"):
                defines.add("-D__KBUILD_MODNAME=kmod_MODULE_NAME")
            elif arg.startswith("-D"):
                defines.add(arg)

            elif arg.startswith("-f"):
                functs.add(arg)
            elif arg.startswith("-m"):
                ms.add(arg)

            elif arg.startswith("-Wa,") or arg.startswith("-Wp,"):
                pass
            elif arg.startswith("-W"):
                warns.add(arg)

            else:
                others.add(arg)

    def warns_sort_key(warn: str) -> int:
        if warn.startswith("-Wno"):
            return 2
        elif warn.startswith("-Werror"):
            return 1
        else:
            return 0

    others = sorted(list(others))
    includes = sorted(list(includes))
    auto_includes = sorted(list(auto_includes))
    defines = sorted(list(defines))
    functs = sorted(list(functs))
    ms = sorted(list(ms))
    warns = sorted(list(warns))
    warns = sorted(list(warns), key=warns_sort_key)

    print(*others, "", sep=linesep)
    print(*includes, "", sep=linesep)
    print(*auto_includes, "", sep=linesep)
    print(*defines, "", sep=linesep)
    print(*functs, "", sep=linesep)
    print(*ms, "", sep=linesep)
    print(*warns, sep=linesep)


if __name__ == "__main__":
    try:
        main(argv[1:])
    except Exception as e:
        print(f'ERROR: {e}')
        usage()
