# Open the repo or the PR for this branch in the browser

# GitHub helpers
# zsh expands aliases at parse time, so if `repo` or `pr` is an alias when this
# file is sourced, `name() {` is a parse error that aborts the REST of the file
# (silently taking pr with it). Re-sourcing via `reload`
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
