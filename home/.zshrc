# zsh config. Location: ~/.zshrc (symlink to this file).
# Modules live in ~/.config/zsh. Homebrew env comes from ~/.zprofile.
# Private and machine-only settings go in ~/.zshrc.local (never committed).

typeset -U path fpath  # no duplicate PATH/fpath entries

ZDOTCONFIG="$HOME/.config/zsh"
BREW="${HOMEBREW_PREFIX:-/opt/homebrew}"

# ─────────────────────────────────────────────────────────────
# Environment
# ─────────────────────────────────────────────────────────────
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
[[ -d $ZSH_CACHE_DIR ]] || mkdir -p "$ZSH_CACHE_DIR"
export EDITOR="code --wait"
export VISUAL="code --wait"

# Source a tool's init script from a cache file. Rebuild the cache when the
# binary (or an extra dependency file) is newer than the cache.
#   _cached_init <name> <binary> [dep-file] -- <command...>
_cached_init() {
  local name=$1 bin=$2 dep=; shift 2
  [[ $1 != -- ]] && { dep=$1; shift; }
  shift
  local f=$ZSH_CACHE_DIR/init-$name.zsh
  if [[ ! -s $f || $bin -nt $f || ( -n $dep && $dep -nt $f ) ]]; then
    "$@" >| $f 2>/dev/null
    zcompile -R $f 2>/dev/null
  fi
  source $f
}

# ─────────────────────────────────────────────────────────────
# Completion
# ─────────────────────────────────────────────────────────────
source $ZDOTCONFIG/completion.zsh

autoload -Uz compinit
# Full check only when the dump is missing or older than 24 h
_zcd_stale=(~/.zcompdump(N.mh+24))
if [[ ! -f ~/.zcompdump || -n $_zcd_stale ]]; then
  compinit -i
else
  compinit -C -i
fi
unset _zcd_stale

# ─────────────────────────────────────────────────────────────
# History, key bindings, aliases
# ─────────────────────────────────────────────────────────────
source $ZDOTCONFIG/history.zsh
source $ZDOTCONFIG/key-bindings.zsh
for _f in $ZDOTCONFIG/aliases/*.zsh(N); do source $_f; done; unset _f

# Autosuggestions (brew install zsh-autosuggestions)
[[ -f $BREW/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
  source $BREW/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ─────────────────────────────────────────────────────────────
# Shell options
# ─────────────────────────────────────────────────────────────
setopt auto_cd              # type a directory name to cd into it
setopt correct              # suggest corrections for mistyped commands
setopt interactive_comments # allow comments in interactive shell
setopt no_beep              # silence terminal bell

# ─────────────────────────────────────────────────────────────
# Modern CLI tools (each one activates only if installed)
# ─────────────────────────────────────────────────────────────

# mise — Node, pnpm, and other runtimes
(( $+commands[mise] )) && _cached_init mise $commands[mise] -- mise activate zsh

# fzf — fuzzy finder (Ctrl+R, Ctrl+T, Alt+C)
if (( $+commands[fzf] )); then
  _cached_init fzf $commands[fzf] -- fzf --zsh
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline"
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
  fi
fi

# ─────────────────────────────────────────────────────────────
# Prompt — Starship (needs a Nerd Font in the terminal)
# ─────────────────────────────────────────────────────────────
(( $+commands[starship] )) &&
  _cached_init starship $commands[starship] ~/.config/starship.toml -- starship init zsh --print-full-init
unfunction _cached_init

# ─────────────────────────────────────────────────────────────
# PATH
# ─────────────────────────────────────────────────────────────
export PATH="$PATH:$HOME/.local/bin"
export PNPM_HOME="$HOME/Library/pnpm"
[[ ":$PATH:" == *":$PNPM_HOME:"* ]] || export PATH="$PNPM_HOME:$PATH"

# ─────────────────────────────────────────────────────────────
# Machine-only settings: work config, tokens, private aliases
# ─────────────────────────────────────────────────────────────
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Syntax highlighting loads last: it wraps only the widgets that exist now
# (brew install zsh-fast-syntax-highlighting)
[[ -f $BREW/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]] &&
  source $BREW/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

unset ZDOTCONFIG BREW
