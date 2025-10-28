# Pacman
alias install='yay -S'
alias install-nc='yay -S --noconfirm'
alias uninstall='yay -Rns' #'sudo pacman -Rns'
alias update='sudo pacman -Syu && yay -Suya'
alias update-nc='sudo pacman -Syu --noconfirm && yay -Suya --noconfirm'
alias autoremove='if [[ ! -n $(pacman -Qdt) ]]; then echo "No packages to remove"; else sudo pacman -Rns $(pacman -Qdtq); fi'
alias clean-cache='sudo pacman -Scc'

# Utilities
alias copy='wl-copy'
alias paste='wl-paste'
alias mux='tmuxinator'
alias tmuxa='tmux attach || tmux new-session'
alias pubkeys="find ~/.ssh/ | grep .pub | fzf --preview 'bat {}' | xargs -I{} cat {} | wl-copy"

# directories
alias cd='z'
alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

# list files
alias ls='eza --git --icons=always --color=always --group-directories-first'
alias ll='ls -lh'
alias la='ls -ah'
alias l='ll'
alias lh='ll -ah'

alias cat='bat'

alias proc='ps -aux | grep'
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias vim='nvim'

alias docker-rm-dangling='docker rmi -f $(docker images -f "dangling=true" -q)'
alias big="du -a -BM | sort -n -r | head -n 10"
alias ungron="gron --ungron"

alias fkill="ps aux | fzf | awk '{print $2}' | xargs -I {} kill -9 {}"

# Services
alias k="kubectl"
alias mk="minikube"
alias kns="kubens"
alias kctx="kubectx"

#logs from all pods in namespace selected with kubectx
alias klogs="kubectl get pods | tail -n +2 | fzf | awk {'print \$1'} | xargs -I{} kubectl logs -f {}"
