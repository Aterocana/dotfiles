alias githash="git log --oneline --all | fzf -m --no-sort --preview='git show {1}' | awk '{print \$1}'"
alias gitmost="git log --format=format: --name-only --since=\"1 year ago\" | sort | uniq -c | sort -nr | head -20" # the most changed files over last year.
alias gitwho="git shortlog -sn --no-merges" # the most prolific commit author.
alias gitbug="git log -i -E --grep=\"fix|bug|broken\" --name-only --format='' | sort | uniq -c | sort -nr | head -20" # search for the most files with commits containing fix, bug or broken.
alias gitpace="git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c" # commits per month.

# remove a worktree based on worktrees in current project
function gitwr() {
  local wts wt worktree_path remove_output remove_status gitwr_status

  wts=$(git worktree list | fzf-tmux -p -m) || return
  gitwr_status=0

  for wt in ${(f)wts}; do
    worktree_path="${wt%%[[:space:]]*}"
    [[ -n "$worktree_path" ]] || continue

    remove_output=$(git worktree remove "$worktree_path" 2>&1)
    remove_status=$?

    if (( remove_status == 0 )); then
      [[ -n "$remove_output" ]] && print -r -- "$remove_output"
      continue
    fi

    if [[ "$remove_output" == *"fatal: working trees containing submodules cannot be moved or removed"* ]]; then
      git worktree remove --force "$worktree_path" || gitwr_status=$?
    else
      print -u2 -r -- "$remove_output"
      gitwr_status=$remove_status
    fi
  done

  return $gitwr_status
}

# cd into a selected worktree
function gitwcd() {
  local selected worktree_path

  git rev-parse --is-inside-work-tree > /dev/null 2>&1 || return

  selected=$(
    git worktree list --porcelain |
      awk '
        function print_worktree() {
          if (worktree == "") {
            return
          }

          if (branch == "") {
            branch = "(detached) " head
          }

          print branch "\t" worktree
        }

        /^worktree / {
          print_worktree()
          worktree = substr($0, 10)
          head = ""
          branch = ""
          next
        }

        /^HEAD / {
          head = substr($0, 6, 7)
          next
        }

        /^branch / {
          branch = substr($0, 8)
          sub(/^refs\/heads\//, "", branch)
          next
        }

        END {
          print_worktree()
        }
      ' |
      fzf-tmux +m --border-label ' worktrees ' --border --prompt 'worktree> ' --delimiter=$'\t' --with-nth=1,2
  ) || return

  worktree_path="${selected#*$'\t'}"

  [[ -n "$worktree_path" ]] && builtin cd "$worktree_path"
}

# copy local AI agent context into a target dir
function git_copy_worktree_context() {
  local source_dir target_dir item

  source_dir="$1"
  target_dir="$2"

  [[ -d "$source_dir" && -d "$target_dir" ]] || return 1

  for item in .claude CLAUDE.md AGENTS.md .codex; do
    [[ -e "$source_dir/$item" ]] && cp -a "$source_dir/$item" "$target_dir/"
  done
}

# create a worktree from an open GitHub PR branch
function gitpr() {
  local prs selected branch source_dir repo branch_dir target_dir

  prs=$(
    gh pr list --state open --json number,title,headRefName \
      --template '{{range .}}{{printf "%s\t#%v\t%s\n" .headRefName .number .title}}{{end}}'
  ) || return

  [[ -n "$prs" ]] || {
    echo "No open PRs found." >&2
    return 1
  }

  selected=$(printf '%s\n' "$prs" | fzf-tmux -p --border-label ' pull requests ' --border --prompt 'pr> ' --delimiter=$'\t' --with-nth=2,1,3) || return
  branch="${selected%%$'\t'*}"

  source_dir=$(git rev-parse --show-toplevel) || return
  repo=$(basename "$source_dir")
  branch_dir=$(printf '%s' "$branch" | tr / _)
  target_dir="$HOME/Documents/Programming/worktrees/$repo/$branch_dir"

  [[ -n "$branch" ]] && git wa "$branch" && git_copy_worktree_context "$source_dir" "$target_dir"
}
