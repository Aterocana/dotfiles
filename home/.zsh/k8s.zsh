alias k="kubectl"
alias mk="minikube"
alias kns="kubens"
alias kctx="kubectx"
alias lq="liqoctl"
alias klogs="kubectl get pods | tail -n +2 | fzf-tmux -p | awk {'print \$1'} | xargs -I{} kubectl logs --tail 100 -f {}"
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

# kdel <entity_type> gets all entity with provided type in current namespace, present them in a fzf popup and delete the resource you selected.
function kdel() {
  if [[ $# -ne 1 ]]; then
    echo "usage: kdel <k8s entity type>"
    echo "example: kdel pod"
    return 1
  fi
  kubectl get $1 | tail -n +2 | fzf-tmux -p | awk {'print $1'} | xargs -I{} kubectl delete $1 {}
}

# kcfg gets all .yaml files under ~/.kube and its subfolder, present them in a fzf popup and creates a symlink in ~/.kube/config to the selected file.
function kcfg() {
  find ~/.kube -type f -name "*.yaml" | fzf-tmux -p | xargs -I{} ln -sf {} ~/.kube/config
}
