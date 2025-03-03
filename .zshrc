# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
DISABLE_MAGIC_FUNCTIONS="true" # pasting doesn't cause every single char to be pasted like it was typed zsh doesn't load so called "magic" plugins.
# DISABLE_LS_COLORS="true" # disable colors in ls.
# DISABLE_AUTO_TITLE="true" # disable auto-setting terminal title.
ENABLE_CORRECTION="true" # enable command auto-correction.
COMPLETION_WAITING_DOTS="true" # display red dots whilst waiting for completion.
HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
	git 
	extract 
	web-search 
	golang
	docker
)

export PATH=$HOME/bin:/usr/local/bin:$(ruby -e 'print Gem.user_dir')/bin:$PATH
source $ZSH/oh-my-zsh.sh
# export LANG=en_US.UTF-8
#export ARCHFLAGS="-arch x86_64"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi
# export SSH_KEY_PATH="~/.ssh/dsa_id"

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
     PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

# If not running interactively, do not do anything
# [[ $- != *i* ]] && return
# [[ -z "$TMUX" ]] && exec tmux

source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/functions.zsh
source $HOME/.zsh/theme.zsh
source $HOME/.zsh/env.zsh
source $HOME/.zsh/kubectl_completions.zsh
source $HOME/.zsh/secrets.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/tmuxinator.zsh
