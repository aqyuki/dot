function __fzf_sandbox_directory --description "find sandbox with fzf"
    set src (lsd --oneline --almost-all $SANDBOX_ROOT | fzf --preview "lsd --oneline --almost-all --color always --icon always --git $SANDBOX_ROOT/{}")
    if test -n "$src"
        cd $SANDBOX_ROOT/$src
    end
    commandline -f repaint
end
