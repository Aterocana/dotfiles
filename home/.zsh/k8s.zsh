alias k="kubectl"
alias mk="minikube"
alias kns="kubens"
alias kctx="kubectx"
alias klogs="kubectl get pods | tail -n +2 | fzf-tmux -p | awk {'print \$1'} | xargs -I{} kubectl logs -f {}"
alias dlogs='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" | tail -n +2 | fzf-tmux -p | awk {"print \$1"} | xargs -I{} docker logs --tail 100 -f {}'

# kdesc <entity_type> gets all entity with provided type in current namespace, present them in a fzf popup and describe the resource you selected.
function kdesc () {
	if [[ $# -ne 1 ]]; then
		echo "usage: kdesc <k8s entity type>"
		echo "example: kdesc pod"
		return 1
	fi
	kubectl get $1 | tail -n +2 | fzf-tmux -p | awk {'print $1'} | xargs -I{} kubectl describe $1 {}
}
