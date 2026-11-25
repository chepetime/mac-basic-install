# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gb='git branch'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log --oneline -15'
alias glog='git log --graph --oneline --decorate --all'
alias clone='git clone'
alias commit='git commit -m'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias grb='git rebase'
alias grbi='git rebase --interactive'
alias gcp='git cherry-pick'
alias gwip='git add -A && git commit -m "WIP"'
alias gsw='git switch'
alias grs='git restore'
alias gwt='git worktree list'
alias gwta='git worktree add'
alias gcane='git commit --amend --no-edit'

# GitHub CLI (gh)
alias ghpr='gh pr list'
alias ghprc='gh pr create'
alias ghprv='gh pr view --web'
alias ghprd='gh pr diff'
alias ghprco='gh pr checkout'
alias ghi='gh issue list'
alias ghic='gh issue create'
alias ghiv='gh issue view --web'
alias ghrun='gh run list'
alias ghrunw='gh run watch'

# GitHub helpers
# zsh expands aliases at parse time, so if `repo` or `pr` is an alias when this
# file is sourced, `name() {` is a parse error that aborts the REST of the file
# (silently taking pr/pr-new/remote/ghrate with it). Re-sourcing via `reload`
# never clears the alias table, so guard both names.
unalias repo 2>/dev/null
unalias pr 2>/dev/null

repo() {
  local url
  url="$(git remote get-url origin 2>/dev/null | sed 's/git@/https:\/\//' | sed 's/com:/com\//')"
  [ -z "$url" ] && url='https://github.com'
  echo "Open repo: $url"
  open "$url"
}
pr() {
  local branch upstream url sha ref
  branch="$(git branch --show-current 2>/dev/null)"

  # Worktrees often carry a renamed local branch (review/foo tracking foo), so
  # prefer the remote head it actually tracks over the local name.
  upstream="$(git rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)"
  [ -n "$upstream" ] && upstream="${upstream#*/}"

  for ref in "$upstream" "$branch"; do
    [ -z "$ref" ] && continue
    url="$(gh pr view "$ref" --json url -q .url 2>/dev/null)"
    [ -n "$url" ] && break
  done

  # Last resort (detached HEAD, or no upstream set): match a PR by the commit
  # HEAD points at.
  if [ -z "$url" ]; then
    sha="$(git rev-parse HEAD 2>/dev/null)"
    if [ -n "$sha" ]; then
      url="$(gh pr list --state all --limit 100 --json url,headRefOid \
        -q "map(select(.headRefOid==\"$sha\"))[0].url" 2>/dev/null)"
      [ "$url" = "null" ] && url=""
    fi
  fi

  if [ -z "$url" ]; then
    echo "No PR found for this branch"
    return 1
  fi
  echo "Open PR for this branch: $url"
  open "$url"
}
alias pr-new="branch=\$(git rev-parse --abbrev-ref HEAD); repo=\$(git remote get-url origin | sed 's#git@#https://#' | sed 's#com:#com/#' | sed 's#\.git\$##'); open \"\$repo/compare/\$branch?expand=1\""
alias remote='open "$(git remote -v | awk "/^origin.*fetch/{print \$2}" | head -n1 | sed "s#git@#https://#" | sed "s#com:#com/#")"'
alias ghrate='curl -s https://api.github.com/rate_limit | jq'
