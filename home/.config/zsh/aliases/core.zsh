# Core Utilities
alias ls='ls -G'                              # colorize ls output
alias ll='ls -lah'                            # detailed list
alias la='ls -A'                              # show hidden files
alias l='ls -CF'                              # column format
alias grep='grep --color=auto'                # colorize grep output
alias zshreload='source ~/.zshrc'             # reload ZSH config
alias reload='zshreload'                      # alias for zshreload
alias c='clear'                               # quick clear
alias h='history'                             # quick history
alias path='echo $PATH | tr ":" "\n"'         # pretty print PATH

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ~='cd ~'
alias -- -='cd -'                             # go to previous dir
