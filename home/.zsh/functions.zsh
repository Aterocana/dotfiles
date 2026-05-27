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

function fcd() {
  local dir
  dir=$(find . -type d -not -path '*/\.*' 2> /dev/null | fzf +m --border-label ' folders ' --border) && cd "$dir"
}

function wcd() {
  local selected worktree

  git rev-parse --is-inside-work-tree > /dev/null 2>&1 || return

  selected=$(
    git worktree list --porcelain |
      awk '
        function print_worktree() {
          if (worktree == "") {
            return
          }

          if (branch == "") {
            branch = "(detached) " head
          }

          print branch "\t" worktree
        }

        /^worktree / {
          print_worktree()
          worktree = substr($0, 10)
          head = ""
          branch = ""
          next
        }

        /^HEAD / {
          head = substr($0, 6, 7)
          next
        }

        /^branch / {
          branch = substr($0, 8)
          sub(/^refs\/heads\//, "", branch)
          next
        }

        END {
          print_worktree()
        }
      ' |
      fzf-tmux +m --border-label ' worktrees ' --border --prompt 'worktree> ' --delimiter=$'\t' --with-nth=1
  ) || return

  worktree="${selected#*$'\t'}"

  # using builtin cd to bypass z alias (I do not want to score the dir in zoxide)
  [[ -n "$worktree" ]] && builtin cd "$worktree"
}

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char

# ALT+S ANTEPONE "sudo" A SINISTRA NEL COMANDO
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# Open buffer line in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

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

function expand-snippet() {
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

function mkcd () {
  mkdir -p "$1"
  cd "$1"
}

function b64_enc () {
  echo $1 | base64
}

function b64_dec () {
  echo $1 | base64 --decode
}
