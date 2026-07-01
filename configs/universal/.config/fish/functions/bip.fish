function bip
    if test (count $argv) -eq 1 ; and test $argv[1] = a
        echo -e "\n==== ip a ====\n"
        sudo ip -c=always a
        for line in (sudo ip netns ls)
            set -l ns (string split -m 1 ' ' -- $line)[1]
            if test -n "$ns"
                echo -e "\n==== ip a (netns '$ns') ====\n"
                sudo ip netns exec $ns ip -c=always a
            end
        end
    else
        sudo ip -c=always $argv
    end
end
