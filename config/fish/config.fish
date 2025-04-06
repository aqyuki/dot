if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g XDG_CONFIG_HOME $HOME/.config
set -g XDG_CACHE_HOME $HOME/.cache
set -g XDG_DATA_HOME $HOME/.local/share
set -g XDG_STATE_HOME $HOME/.local/state

# setup go command
fish_add_path /usr/local/go/bin
fish_add_path (go env GOBIN)

# add alias
abbr -a lg lazygit

# activate mise
mise activate fish | source

# load prompt
starship init fish | source
