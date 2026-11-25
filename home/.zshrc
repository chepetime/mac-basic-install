# Basic zsh setup: Homebrew, completion, history, mise, Starship.
# Location: ~/.zshrc (symlink to this file)

# Homebrew (Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Completion
autoload -Uz compinit && compinit

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS

# Runtimes (Node, pnpm, ...)
command -v mise >/dev/null && eval "$(mise activate zsh)"

# Prompt — needs a Nerd Font (GeistMono Nerd Font) in the terminal
command -v starship >/dev/null && eval "$(starship init zsh)"

# Machine-only settings: work config, tokens, private aliases. Never committed.
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
