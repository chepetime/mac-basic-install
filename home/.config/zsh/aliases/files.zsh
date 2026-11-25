# Quick file edits
alias zshconfig='${EDITOR:-code} ~/.zshrc'
alias aliasconfig='${EDITOR:-code} ~/.config/zsh/aliases'
alias hosts='sudo ${EDITOR:-code} /etc/hosts'

# Finder visibility
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
