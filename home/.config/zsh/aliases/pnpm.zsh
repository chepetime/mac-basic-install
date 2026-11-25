# pnpm

# Update npm and pnpm only (no Node version change)
setpnpm() {
  echo "Updating npm to latest..."
  npm install -g npm@latest

  echo "\nEnabling latest pnpm via corepack..."
  corepack enable
  corepack use pnpm@latest

  echo "\nDone! Versions:"
  echo "  Node:  $(node -v)"
  echo "  npm:   $(npm -v)"
  echo "  pnpm:  $(pnpm -v)"
}

alias build='pnpm build'
alias start='pnpm start'
