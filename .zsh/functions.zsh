eval "$(zoxide init zsh)"
autoload -U zmv
autoload -U modify-current-argument #necessaria per expand-snippet

function path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
           print }"
}

function insert_sudo () {
	zle beginning-of-line; zle -U "sudo "
}

# ALT+S ANTEPONE "sudo" A SINISTRA NEL COMANDO
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# CTRL+J ESPANDE I PERCORSI INDICATI IN SNIPPETS
typeset -A snippets

snippets=(
  doc ~/Documents/
  d ~/Downloads/
  p ~/Documents/Programming/
  go ~/Documents/Programming/go/
  rust ~/Documents/Programming/rust
  vim ~/.config/nvim/
)

expand-snippet() {
  modify-current-argument '${snippets[${ARG}]}'
}
zle -N expand-snippet

bindkey "\ej" expand-snippet
bindkey -M emacs '^[[3;5~' kill-word

# Sesh sessions
function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\ef' sesh-sessions
bindkey -M vicmd '\ef' sesh-sessions
bindkey -M viins '\ef' sesh-sessions
