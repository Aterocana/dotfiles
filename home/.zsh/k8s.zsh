alias k="kubecolor"
alias mk="minikube"
alias kns="kubens"
alias kctx="kubectx"
alias lq="liqoctl"
alias klogs="kubectl get pods | tail -n +2 | fzf-tmux -p | awk {'print \$1'} | xargs -I{} kubectl logs --tail 100 -f {}"
alias dlogs='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" | tail -n +2 | fzf-tmux -p | awk {"print \$1"} | xargs -I{} docker logs --tail 100 -f {}'

# knr lists every pod that is not fully healthy: not Running, or Running with
# containers that aren't all ready. The obvious --field-selector status.phase!=Running
# misses CrashLoopBackOff, because a crashlooping pod's phase is still Running --
# the backoff lives in status.containerStatuses[].state.waiting.reason, which the
# API server can't field-select on. So filter on the printed columns instead, and
# strip kubecolor's escape sequences on a copy of the line to keep the colors.
function knr() {
  kubecolor --force-colors get po -A "$@" |
    awk '{ c = $0; gsub(/\033\[[0-9;]*m/, "", c); split(c, f, " "); split(f[3], ready, "/")
           if (NR == 1 || f[4] != "Running" || ready[1] != ready[2]) print }'
}

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
  local files

  files=$(find ~/.kube -type f -name "*.yaml" | fzf-tmux -p -m)
  [ -z "$files" ] && return

  export KUBECONFIG="$(print -r -- "$files" | paste -sd: -)"
}

function kimgID() {
	kubectl get pod | tail -n +2 | fzf-tmux -p | awk {'print $1'} | xargs -I{} kubectl get po {} -o json | jq '.status.containerStatuses[].imageID'
}

# Make "kubecolor" borrow the same completion logic as "kubectl"
compdef kubecolor=kubectl
