# Pacman
alias install='yay -S'
alias install-nc='yay -S --noconfirm'
alias uninstall='yay -Rns' #'sudo pacman -Rns'
alias update='sudo pacman -Syu && yay -Suya'
alias update-nc='sudo pacman -Syu --noconfirm && yay -Suya --noconfirm'
alias autoremove='if [[ ! -n $(pacman -Qdt) ]]; then echo "No packages to remove"; else sudo pacman -Rns $(pacman -Qdtq); fi'
alias clean-cache='sudo pacman -Scc'

# Utilities
alias mux='tmuxinator'
alias pubkeys="find ~/.ssh/ | grep .pub | fzf --preview 'bat {}' | xargs -I{} cat {} | wl-copy"
alias unzip='extract'
alias cd='z'
alias ls='eza --git --icons=always --color=always --group-directories-first'
#alias ls='ls --color=always --group-directories-first'
alias ll='ls -lh'
alias la='ls -ah'
alias l='ll'
alias lh='ll -ah'
alias cat='bat'
alias proc='ps -aux | grep'
#alias tree="eza -T"
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias vim='nvim'
alias docker-rm-dangling='docker rmi -f $(docker images -f "dangling=true" -q)'
alias big="du -a -BM | sort -n -r | head -n 10"
alias k="kubectl"
alias mk="minikube"

# Services
alias vpn='sudo openfortivpn -c /home/mauri/Documents/VPN/forticlient < /home/mauri/Documents/VPN/pwd'
