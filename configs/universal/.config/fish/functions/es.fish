function es
    if test (count $argv) -ge 1
        switch $argv[1]
            case start
                _es_start
            case restart
                _es_stop
                _es_force_start
            case stop
                _es_stop
            case git
                _es_start
                emacsclient -t \
                    -e '(progn (magit-status) (delete-other-windows))'
            case gui
                _es_start
                if test (count $argv) -ge 2 ; and test $argv[2] = git
                    emacsclient -c \
                        -e '(progn (magit-status) (delete-other-windows))'
                else
                    emacsclient -c
                end
        end
    else
        _es_start
        emacsclient -t
    end
end

function _es_force_start
    echo 'emacs daemon is starting ...'
    emacs --daemon --chdir "$HOME" > /dev/null 2>&1
end

function _es_start
    set -l started (emacsclient -a false -e '(server-running-p)' 2>&1)
    set -l ecstatus $status

    if test $ecstatus -ne 0 ; or test $started != 't'
        _es_force_start
    end
end

function _es_stop
    emacsclient -e '(kill-emacs)' > /dev/null 2>&1
    set -l ecstatus $status

    if test $ecstatus -ne 0
        echo 'emacs daemon is already stopped!'
    end
end
