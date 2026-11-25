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

# pnpm
alias p='pnpm'
alias pa='pnpm add'
alias prm='pnpm remove'
alias pd='pnpm dev'
alias pb='pnpm build'

# Dev shortcuts
alias dev='pnpm dev'
alias build='pnpm build'
alias lint='pnpm lint'
alias pt='pnpm test'
alias start='pnpm start'
