# Pacman
alias install='yay -S'
alias install-nc='yay -S --noconfirm'
alias uninstall='yay -Rns' #'sudo pacman -Rns'
alias update='sudo pacman -Syu && yay -Suya && sudo snap refresh'
alias update-nc='sudo pacman -Syu --noconfirm && yay -Suya --noconfirm && sudo snap refresh'
alias autoremove='if [[ ! -n $(pacman -Qdt) ]]; then echo "No packages to remove"; else sudo pacman -Rns $(pacman -Qdtq); fi'
alias clean-cache='sudo pacman -Scc'

# Utilities
alias unzip='extract'
alias ls='ls --color=always --group-directories-first'
alias ll='ls -lh'
alias lh='ll -ah'
alias cat='bat'
alias proc='ps -aux | grep'
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias vim='nvim'
alias docker-rm-dangling='docker rmi -f $(docker images -f "dangling=true" -q)'
alias big="du -a -BM | sort -n -r | head -n 10"

# Services
alias vpn='sudo openfortivpn -c /home/mauri/Documents/VPN/forticlient < /home/mauri/Documents/VPN/pwd'
