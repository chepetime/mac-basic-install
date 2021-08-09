alias ls='ls -G'                              # colorize `ls` output
alias zshreload='source ~/.zshrc'             # reload ZSH
alias shtop='sudo htop'                       # run `htop` with root rights
alias grep='grep --color=auto'                # colorize `grep` output
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias less='less -R'
alias g='git'

alias rm='rm -i'                              # confirm removal
alias cp='cp -i'                              # confirm copy
alias mv='mv -i'                              # confirm move
alias cal='gcal --starting-day=1'             # print simple calendar for current month
alias weather='curl v2.wttr.in'               # print weather for current location (https://github.com/chubin/wttr.in)

alias corona='curl https://corona-stats.online?source=2'
alias coronamx='curl https://corona-stats.online/mexico?source=2'

alias repo='git remote -v | head -n 1 | awk -F "@" '\''{print $2}'\'' | awk -F " " '\''{print $1}'\'' | sed '\''s/:/\//g'\'' | sed '\''s/.git//g'\'' | awk '\''{print "http://"$1}'\'' | xargs open'
alias remote='git remote -v | head -n 1 | awk -F "origin" '\''{print $2}'\'' | awk -F ".git " '\''{print $1}'\'' | xargs open'