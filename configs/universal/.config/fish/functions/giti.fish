function giti
    if command -q git
        set git_ignore_dir_path (git rev-parse --show-toplevel 2>/dev/null)
        if test $status -eq 0
            set git_ignore_file_path "$git_ignore_dir_path/.gitignore"
            cd "$git_ignore_dir_path"
            if command -q sudo
                sudo rm -rf (git ls-files --others --ignored --exclude-from="$git_ignore_file_path" --directory)
            else if command -q doas
                doas rm -rf (git ls-files --others --ignored --exclude-from="$git_ignore_file_path" --directory)
            else
                rm -rf (git ls-files --others --ignored --exclude-from="$git_ignore_file_path" --directory)
            end
        end
    end
end
