#!/usr/bin/env bash
# Set up a new Mac from this repo. Safe to run more than once.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"

# 1. Command Line Developer Tools
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo "Finish the Command Line Tools installer, then run this script again."
  exit 1
fi

# 2. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. Apps and tools
brew bundle --file="$REPO/Brewfile"

# 4. Config files (existing files are moved to *.backup)
link() {
  local src="$REPO/home/$1" dst="$HOME/$1"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then mv "$dst" "$dst.backup"; fi
  ln -sfn "$src" "$dst"
  echo "linked $dst"
}
link .zprofile
link .zshrc
link .config/zsh
link .config/starship.toml
link .config/ghostty/config

# 5. Node via mise
mise use --global node@lts

# 6. Secret scan hook for this repo
git -C "$REPO" config core.hooksPath .githooks

echo "Done. Open Ghostty to load the new shell."
