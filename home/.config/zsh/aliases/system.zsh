# System Info & Monitoring
alias init='fastfetch'
alias check='btop'
alias battery='pmset -g batt'
alias cpu='top -l 1 | head -n 10'
alias mem='top -l 1 -s 0 | grep PhysMem'
alias disk='df -h'
alias dirsize='du -h -d 1 . | sort -h'
alias ports='lsof -i -P -n | grep LISTEN'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

# Process management
alias psg='ps aux | grep -v grep | grep -i'   # search processes
killport() { kill -9 $(lsof -t -i:"$1"); }     # kill process on port

# Fuzzy process killer (fzf)
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  if [ -n "$pid" ]; then
    echo "$pid" | xargs kill -${1:-9}
  fi
}

# Database
alias pgstart='pg_ctl -D "$(brew --prefix)/var/postgres" start'
alias pgstop='pg_ctl -D "$(brew --prefix)/var/postgres" stop'
alias pgstatus='pg_ctl -D "$(brew --prefix)/var/postgres" status'
