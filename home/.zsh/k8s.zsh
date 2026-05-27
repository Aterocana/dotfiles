alias k="kubecolor"
alias mk="minikube"
alias kns="kubens"
alias kctx="kubectx"
alias lq="liqoctl"
alias klogs="kubectl get pods | tail -n +2 | fzf-tmux -p | awk {'print \$1'} | xargs -I{} kubectl logs --tail 100 -f {}"
alias dlogs='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" | tail -n +2 | fzf-tmux -p | awk {"print \$1"} | xargs -I{} docker logs --tail 100 -f {}'
alias knr="k get po -A --field-selector status.phase!=Running"

# kdesc <entity_type> gets all entity with provided type in current namespace, present them in a fzf popup and describe the resource you selected.
function kdesc () {
  if [[ $# -ne 1 ]]; then
    echo "usage: kdesc <k8s entity type>"
    echo "example: kdesc pod"
    return 1
  fi
  kubectl get $1 | tail -n +2 | fzf-tmux -p | awk {'print $1'} | xargs -I{} kubectl describe $1 {}
}

# kdel <entity_type> gets all entity with provided type in current namespace, present them in a fzf popup and delete the resource you selected.
function kdel() {
  if [[ $# -ne 1 ]]; then
    echo "usage: kdel <k8s entity type>"
    echo "example: kdel pod"
    return 1
  fi
  kubectl get $1 | tail -n +2 | fzf-tmux -p | awk {'print $1'} | xargs -I{} kubectl delete $1 {}
}

# kc finds all kubeconfig files in ~/.kube, lets you select one or more of them with fzf and then merges the selected kubeconfig files into a single temporary kubeconfig file and sets the KUBECONFIG environment variable to point to that file. This allows you to easily switch between multiple Kubernetes contexts defined in different kubeconfig files.
function kc() {
  local files tmp
  files=$(find ~/.kube -type f -name "*.yaml" | fzf-tmux -p -m)

  [ -z "$files" ] && return

  tmp=$(mktemp).kubeconfig

  KUBECONFIG=$(echo "$files" | paste -sd:) \
    kubectl config view --flatten > "$tmp"

  export KUBECONFIG="$tmp"
}

# Make "kubecolor" borrow the same completion logic as "kubectl"
compdef kubecolor=kubectl
