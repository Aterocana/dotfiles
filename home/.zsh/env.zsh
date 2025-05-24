export BAT_THEME="gruvbox-dark"
# GO
export PATH=$PATH:/usr/lib/go/bin:$HOME/go/bin
export GOBIN=$HOME/go/bin

# My scripts
export PATH=$PATH:$HOME/.local/scripts

export PATH=$HOME/bin:/usr/local/bin:$(ruby -e 'print Gem.user_dir')/bin:$PATH
export _JAVA_AWT_WM_NONREPARENTING=1
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
