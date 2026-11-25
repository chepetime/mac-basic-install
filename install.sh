#!/usr/bin/env bash
# Set up a new Mac from this repo. Safe to run more than once.
#
# New Mac (nothing installed):
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/chepetime/mac-basic-install/main/install.sh)"
# From a clone:
#   ./install.sh [--no-defaults]
set -euo pipefail

REPO_URL="https://github.com/chepetime/mac-basic-install.git"
REPO_DIR="${MAC_SETUP_DIR:-$HOME/Projects/mac-basic-install}"
RUN_DEFAULTS=1
[[ "${1:-}" == "--no-defaults" ]] && RUN_DEFAULTS=0

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
warn() { printf '\033[1;33mwarning:\033[0m %s\n' "$*" >&2; }

# 1. Command Line Developer Tools (git, compilers)
step "Command Line Developer Tools"
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install || true
  echo "Finish the installer window. This script waits for it."
  until xcode-select -p >/dev/null 2>&1; do sleep 10; done
fi

# 2. Homebrew
step "Homebrew"
if [[ ! -x /opt/homebrew/bin/brew ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. This repo (clone it when the script runs from curl)
step "Repo"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"
if [[ -n "$SCRIPT_DIR" && -f "$SCRIPT_DIR/Brewfile" ]]; then
  REPO="$SCRIPT_DIR"
else
  if [[ ! -d "$REPO_DIR/.git" ]]; then
    mkdir -p "$(dirname "$REPO_DIR")"
    git clone "$REPO_URL" "$REPO_DIR"
  fi
  REPO="$REPO_DIR"
fi
echo "Using $REPO"

# 4. Apps and tools. A failed item (often App Store apps before sign-in)
#    does not stop the setup; run `brew bundle` again later.
step "Brewfile"
if ! brew bundle --file="$REPO/Brewfile"; then
  warn "some Brewfile items failed. Sign in to the App Store, then run: brew bundle --file=$REPO/Brewfile"
fi

# 5. Config files (an existing real file is moved to *.backup)
step "Config files"
link() {
  local src="$REPO/home/$1" dst="$HOME/$1"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "$dst.backup.$(date +%Y%m%d%H%M%S)"
    echo "backed up $dst"
  fi
  ln -sfn "$src" "$dst"
  echo "linked $dst"
}
link .zprofile
link .zshrc
link .config/zsh
link .config/starship.toml
link .config/ghostty/config
link .config/git/config
link .config/git/ignore

# 6. Node and pnpm via mise
step "Runtimes"
mise use --global node@lts pnpm@latest

# 7. macOS settings
if (( RUN_DEFAULTS )); then
  step "macOS settings"
  bash "$REPO/macos/defaults.sh"
fi

# 8. Secret scan hook for this repo
git -C "$REPO" config core.hooksPath .githooks

step "Done"
cat <<'EOF'
Next (manual):
  1. Sign in: 1Password, App Store, then `gh auth login && gh auth setup-git`
  2. Set git identity:  git config --global user.name "…"; git config --global user.email "…"
  3. Open Ghostty. Run `brew bundle check --file=Brewfile` to see anything missing.
EOF
