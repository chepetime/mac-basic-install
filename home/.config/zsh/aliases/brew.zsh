# Homebrew
brewm() {
  local SECONDS=0 doctor=false
  local -a failed=()
  while (( $# )); do
    case "$1" in
      --doctor|-d) doctor=true; shift ;;
      *) echo "Usage: brewm [--doctor]"; return 1 ;;
    esac
  done

  _brewm_step() {
    local name="$1"; shift
    "$@" || failed+=("$name")
  }

  _brewm_pi_update() {
    # pi installs its packages with npm; a pnpm install in ~/.pi/agent/npm
    # breaks every extension.
    pi update --extensions || return 1
    local outdated
    outdated=$(cd ~/.pi/agent/npm && npm outdated 2>&1)
    [[ -n "$outdated" ]] && echo "\nUpdates still available:\n$outdated"
    return 0
  }

  echo "Updating Homebrew..."
  brew update || return 1

  echo "\nUpgrading formulae..."
  _brewm_step "brew upgrade --formula" brew upgrade --formula

  echo "\nUpgrading casks (greedy)..."
  _brewm_step "brew upgrade --cask" brew upgrade --cask --greedy

  echo "\nUpdating Claude Code..."
  _brewm_step "claude update" claude update

  echo "\nUpdating pi extensions..."
  _brewm_step "pi extensions" _brewm_pi_update

  echo "\nCleaning up..."
  _brewm_step "brew cleanup" brew cleanup --prune=7
  _brewm_step "brew autoremove" brew autoremove

  if $doctor; then
    echo "\nRunning diagnostics..."
    _brewm_step "brew doctor" brew doctor
  fi

  unfunction _brewm_step _brewm_pi_update

  local mins=$((SECONDS / 60)) secs=$((SECONDS % 60))
  if (( ${#failed} )); then
    echo "\nDone in ${mins}m ${secs}s with failures: ${(j:, :)failed}"
    osascript -e "display notification \"Failed: ${(j:, :)failed}\" with title \"brewm\"" 2>/dev/null
    return 1
  fi
  echo "\nDone in ${mins}m ${secs}s."
  osascript -e "display notification \"Homebrew maintenance done (${mins}m ${secs}s)\" with title \"brewm\"" 2>/dev/null
}

alias brewl='brew list'
alias brews='brew search'
alias brewi='brew info'
