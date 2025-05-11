WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
for file in ~/.zsh/*.zsh; do
	source "$file"
done

source <(kubectl completion zsh)
source <(helm completion zsh)
type hctl >/dev/null 2>&1 && source <(hctl completion zsh)
source ~/.secrets.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/tmuxinator.zsh
