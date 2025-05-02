if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_CACHE_HOME $HOME/.cache
set -Ux XDG_DATA_HOME $HOME/.local/share
set -Ux XDG_STATE_HOME $HOME/.local/state

set -Ux XDG_BIN_HOME $HOME/.local/bin
fish_add_path $XDG_BIN_HOME

# setup go command
fish_add_path /usr/local/go/bin
fish_add_path (go env GOBIN)

# add alias
abbr -a lg lazygit

# activate mise
mise activate fish | source
mise completion fish | source

# aqua settings
set -Ux AQUA_ROOT_DIR $XDG_DATA_HOME/aquaproj-aqua
set -Ux AQUA_GLOBAL_CONFIG "$XDG_CONFIG_HOME/aqua/aqua.yaml"
fish_add_path $AQUA_ROOT_DIR/bin
aqua completion fish | source

# GHQ settings
set -Ux GHQ_ROOT $HOME/projects

# Woprkspace settings
set -Ux SANDBOX_ROOT $HOME/sandbox

# activate fzf integration
fzf --fish | source
set -Ux FZF_DEFAULT_OPTS '--height 50% --layout reverse --border rounded'
bind \cg __fzf_project_directory
bind \cf __fzf_sandbox_directory

# load prompt
starship init fish | source
