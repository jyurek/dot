# Setup fzf
# ---------
if [[ ! "$PATH" == *`brew --prefix`/opt/fzf/bin* ]]; then
  export PATH="$PATH:`brew --prefix`/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "`brew --prefix`/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "`brew --prefix`/opt/fzf/shell/key-bindings.bash"

export FZF_COMPLETION_TRIGGER='\\'
export FZF_COMPLETION_OPTS='+c -x'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
