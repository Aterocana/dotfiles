WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
for file in ~/.zsh/*.zsh; do
	source "$file"
done

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [ ! -f "$SSH_AUTH_SOCK" ]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

source <(kubectl completion zsh)
source <(helm completion zsh)
source <(fzf --zsh)

type hctl >/dev/null 2>&1 && source <(hctl completion zsh)
source ~/.secrets.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh
source /usr/share/zsh/plugins/tmuxinator.zsh
