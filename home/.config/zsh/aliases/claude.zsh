# Claude Code launchers: lean wrapper, nono sandbox (nclaude, scc).

# --- lean defaults (cut first-turn context cost) ---
# The Artifact tool is off by default. Opt in per session:
#   claude --art         keep the Artifact tool
# Flags go last: --disallowedTools is variadic and would eat a prompt.
_cc_args() {
  reply=()
  local art=0 a
  case "$1" in
    mcp|plugin|plugins|update|doctor|install|config|auth|agents|setup-token|migrate-installer)
      reply=("$@"); return ;;
  esac
  for a in "$@"; do
    case "$a" in
      --art) art=1 ;;
      *) reply+=("$a") ;;
    esac
  done
  (( art )) || reply+=(--disallowedTools Artifact)
}

claude() { _cc_args "$@"; command claude "${reply[@]}"; }

# --- raw claude (no sandbox) ---
alias ccn='claude'
alias ccc='claude -c'
alias ccr='claude --resume'

# --- sandboxed claude (nono) ---
# Needs a nono profile. Set the name in ~/.zshrc.local:
#   export NONO_CLAUDE_PROFILE=my-claude-profile
# Usage:
#   nclaude              -> nono claude (new chat)
#   nclaude -c           -> continue
#   nclaude --resume     -> resume picker
#   nclaude -p "..."     -> one-shot prompt
nclaude() {
  _cc_args "$@"
  nono run --profile "${NONO_CLAUDE_PROFILE:-claude-safe}" --allow-cwd --allow-launch-services -- \
    claude "${reply[@]}"
}

# scc — sandboxed claude with session shortcuts:
#   scc                  new chat
#   scc --here           continue most recent session in CWD (same as `claude -c`)
#   scc --global         resume most recent session anywhere on this machine
#   scc <any claude flag>  forwarded as-is (e.g. `scc --resume <id>`, `scc -p "..."`)
scc() {
  case "$1" in
    --here)
      shift
      nclaude -c "$@"
      ;;
    --global)
      shift
      local newest sid cwd
      newest=$(find ~/.claude/projects -name '*.jsonl' -type f \
        -exec stat -f '%m %N' {} + 2>/dev/null | sort -rn | head -1 | cut -d' ' -f2-)
      if [[ -z "$newest" ]]; then
        print -u2 "scc --global: no sessions found in ~/.claude/projects"
        return 1
      fi
      sid="${newest:t:r}"
      # claude --resume scopes to the session's original cwd; grab it from the JSONL.
      cwd=$(jq -rs 'map(select(.cwd != null))[0].cwd // empty' "$newest" 2>/dev/null)
      if [[ -z "$cwd" || ! -d "$cwd" ]]; then
        print -u2 "scc --global: couldn't recover original cwd for $sid (file: $newest)"
        return 1
      fi
      print "scc --global: resuming $sid (cwd: $cwd)"
      ( cd "$cwd" && nclaude --resume "$sid" "$@" )
      ;;
    *)
      nclaude "$@"
      ;;
  esac
}

alias sccc='scc --here'
alias review='claude -p "review this code, list issues"'
