# GO
export PATH=$PATH:/usr/lib/go/bin:$HOME/go/bin
export GOBIN=$HOME/go/bin

# My scripts
export PATH=$PATH:$HOME/.local/scripts

export _JAVA_AWT_WM_NONREPARENTING=1
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
