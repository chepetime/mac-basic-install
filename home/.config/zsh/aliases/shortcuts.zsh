# Quick Shortcuts
alias e='${EDITOR:-code}'                      # quick edit
alias o='open'                                 # quick open
alias o.='open .'                              # open current dir in Finder
alias please='sudo $(fc -ln -1)'               # re-run last cmd with sudo
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias week='date +%V'                          # week number
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
alias timestamp='date +%s'                     # unix timestamp
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"'

# Clipboard
alias copy='pbcopy'
alias copypath='pwd | pbcopy'
copyfile() { pbcopy < "$1"; }
alias pubkey='cat ~/.ssh/id_ed25519.pub | pbcopy && echo "Public key copied"'

# Make directory and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Extract any archive
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Create a .tar.gz archive
tarball() { tar -czvf "${1%/}.tar.gz" "$1"; }

# Serve current directory on port (default 8000)
serve() { python3 -m http.server "${1:-8000}"; }

# URL encode/decode
urlencode() { python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))" "$1"; }
urldecode() { python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))" "$1"; }

# JSON pretty print (pipe json to this)
alias json='python3 -m json.tool'

# Base64 encode/decode
alias b64e='base64'
alias b64d='base64 --decode'

alias pretty-package='find . -name package.json -type f -path "*/node_modules/*" -prune -o -name package.json -print0 | xargs -0 -I {} npx prettier-package-json --write "{}"'
alias ghostty-config='${EDITOR:-code} ~/.config/ghostty/config'