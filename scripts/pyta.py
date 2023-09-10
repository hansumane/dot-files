#!/usr/bin/env python3

from os import chmod
from sys import argv, exit as sysexit


def main():

    """ pyta, pyta.py - python script to tangle from org-files """

    outf = None
    metfiles = {}

    if len(argv) != 2:
        print(f"Usage: {argv[0]} <filename.org>", flush=True)
        sysexit(1)

    with open(argv[1], "r") as inpf:
        for line in inpf.readlines():
            if line.startswith("#+begin_src") and outf is None:
                line = line.split()
                if ":tangle" not in line:
                    continue
                outfn = line[line.index(":tangle") + 1]
                mode = (int("0" + line[line.index(":tangle-mode") + 1], 8)
                        if ":tangle-mode" in line else 0o644)
                if outfn in metfiles:
                    outf = open(outfn, "a")
                    print(file=outf)
                else:
                    outf = open(outfn, "w")
                metfiles[outfn] = mode
            elif line.startswith("#+end_src") and outf is not None:
                outf.close()
                outf = None
            elif outf is not None:
                outf.write(line)

    for outfn, mode in metfiles.items():
        chmod(outfn, mode)


if __name__ == "__main__":
    main()
