export EDITOR="nvim"
export BAT_THEME="gruvbox-dark"

# GO
export PATH=$PATH:/usr/lib/go/bin:$HOME/go/bin
export GOBIN=$HOME/go/bin

# My scripts
export PATH=$PATH:$HOME/.local/bin

export PATH=$HOME/bin:/usr/local/bin:$(ruby -e 'print Gem.user_dir')/bin:$PATH
export _JAVA_AWT_WM_NONREPARENTING=1
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --bind ctrl-j:down,ctrl-k:up --height 40%'

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
