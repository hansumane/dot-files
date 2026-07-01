function edC
    if not test -f ./compile_flags.txt
        echo '-std=gnu17'                                         >> ./compile_flags.txt
        echo                                                      >> ./compile_flags.txt
        echo '-Wall'                                              >> ./compile_flags.txt
        echo '-Wextra'                                            >> ./compile_flags.txt
        echo '-Wformat'                                           >> ./compile_flags.txt
        echo '-Wpedantic'                                         >> ./compile_flags.txt
        echo '-pedantic'                                          >> ./compile_flags.txt
        echo                                                      >> ./compile_flags.txt
        echo '-Winline'                                           >> ./compile_flags.txt
        echo '-Werror=inline'                                     >> ./compile_flags.txt
        echo                                                      >> ./compile_flags.txt
        echo '-Wno-c23-extensions'                                >> ./compile_flags.txt
        echo '# allow empty initializers'                         >> ./compile_flags.txt
        echo                                                      >> ./compile_flags.txt
        echo '-Wno-varargs'                                       >> ./compile_flags.txt
        echo '-Wno-variadic-macros'                               >> ./compile_flags.txt
        echo '-Wno-gnu-zero-variadic-macro-arguments'             >> ./compile_flags.txt
        echo '# define func(args...) ##args'                      >> ./compile_flags.txt
        echo                                                      >> ./compile_flags.txt
        echo '-Wno-language-extension-token'                      >> ./compile_flags.txt
        echo '-Wno-gnu-statement-expression-from-macro-expansion' >> ./compile_flags.txt
        echo '# list_* functions'                                 >> ./compile_flags.txt
        echo                                                      >> ./compile_flags.txt
        echo '-Wno-gnu-empty-struct'                              >> ./compile_flags.txt
        echo '-Wno-gnu-pointer-arith'                             >> ./compile_flags.txt
        echo '-Wno-gnu-binary-literal'                            >> ./compile_flags.txt
        echo '-Wno-gnu-flexible-array-initializer'                >> ./compile_flags.txt
        echo '-Wno-gnu-conditional-omitted-operand'               >> ./compile_flags.txt
        echo '# self-explanatory'                                 >> ./compile_flags.txt
    end

    nvim ./compile_flags.txt
end
