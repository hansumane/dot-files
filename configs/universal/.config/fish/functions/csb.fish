function csb
    find . -type f -iname '*.c'   -exec realpath --relative-to="$PWD" {} '+' | uniq >  cscope.files
    find . -type f -iname '*.cpp' -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files
    find . -type f -iname '*.cxx' -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files
    find . -type f -iname '*.s'   -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files
    find . -type f -iname '*.asm' -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files
    find . -type f -iname '*.h'   -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files
    find . -type f -iname '*.hpp' -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files
    find . -type f -iname '*.hxx' -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files

    find . -type f -name 'cscope.out*' -delete
    cscope -b -q $argv -f cscope.out
end
