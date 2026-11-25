# Docker
alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dpsa='docker ps -a'
alias di='docker images'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcr='docker compose restart'
alias dlogs='docker compose logs -f'
alias dprune='docker system prune -af --volumes'

# Interactive shell into container (usage: dex <container> [shell])
dex() { docker exec -it "$1" "${2:-sh}"; }
