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
alias big="du -a -BM | sort -n -r | head -n 10"

alias docker-rm-dangling='docker rmi -f $(docker images -f "dangling=true" -q)'
alias ungron="gron --ungron"

alias fkill="ps aux | tail -n +2 | fzf-tmux -p | awk '{print $2}' | xargs -I {} kill -9 {}"
