# Install everything:  brew bundle --file=Brewfile
# Check what is missing: brew bundle check --file=Brewfile

# ── Taps ────────────────────────────────────────────────────
tap "f/textream"
tap "russmckendrick/tap"

# ── Terminal ────────────────────────────────────────────────
cask "ghostty"                    # GPU terminal
cask "herdr-app"                  # Desktop app for terminals and coding agents
cask "cmux"                       # Ghostty-based terminal with vertical tabs for agents
brew "starship"                   # Shell prompt
brew "zsh-autosuggestions"        # Suggest commands from history
brew "zsh-fast-syntax-highlighting" # Color commands as you type
cask "font-geist-mono-nerd-font"  # Terminal font with Nerd Font icons

# ── Runtimes and package managers ───────────────────────────
brew "mise"                       # Node, pnpm, and other runtimes (replaces nvm)
brew "uv"                         # Python
brew "rust"

# ── Modern CLI ──────────────────────────────────────────────
brew "fd"                         # find
brew "ripgrep"                    # grep
brew "fzf"                        # Fuzzy finder
brew "git-delta"                  # Git diff pager
brew "jq"
brew "tree"
brew "coreutils"
brew "terminal-notifier"

# ── System ──────────────────────────────────────────────────
brew "mole"                       # Mac cleanup

# ── Git and GitHub ──────────────────────────────────────────
brew "gh"
brew "act"                        # Run GitHub Actions locally
brew "actionlint"                 # Lint workflow files
brew "shellcheck"                 # Lint shell scripts

# ── Security ────────────────────────────────────────────────
brew "gitleaks"                   # Secret scanner
brew "zizmor"                     # GitHub Actions security audit
brew "nono"                       # Sandbox for agents

# ── Cloud, containers, databases ────────────────────────────
cask "orbstack"                   # Docker and Linux VMs
brew "helm"
brew "awscli"
brew "postgresql@16", link: true  # keg-only; linked so psql is on PATH

# ── Media and documents ─────────────────────────────────────
brew "ffmpeg"
brew "poppler"                    # PDF tools

# ── AI ──────────────────────────────────────────────────────
cask "claude"                     # Claude desktop
cask "claude-code"                # Claude Code CLI
cask "codex"
brew "pi-coding-agent"
cask "wispr-flow"                 # Voice dictation
cask "russmckendrick/tap/tokenuse-desktop"
cask "f/textream/textream"

# ── Apps ────────────────────────────────────────────────────
cask "1password"                  # Password manager (sign in first)
cask "google-chrome"              # Browser
cask "slack"                      # Team chat
cask "zoom"                       # Video calls
cask "fathom"                     # Meeting recorder and notes
cask "tailscale-app"              # Private network (WireGuard)
cask "raycast"                    # Launcher (replaces Spotlight/Alfred)
cask "visual-studio-code"
cask "figma"
cask "miro"
cask "notion"
cask "notion-calendar"
cask "spotify"
cask "numi"                       # Calculator

# ── Mac App Store (needs App Store sign-in; mas = CLI for it) ─
brew "mas"
mas "BetterSnapTool", id: 417375580   # Window snapping
mas "Paste", id: 967805235            # Clipboard history
mas "Xcode", id: 497799835            # Apple SDKs and simulators
mas "Keynote", id: 361285480          # Presentations
mas "Pages", id: 361309726            # Documents
mas "Numbers", id: 361304891          # Spreadsheets

# ── VS Code extensions ──────────────────────────────────────
vscode "anthropic.claude-code"                # Claude Code for VS Code
vscode "openai.chatgpt"                       # Codex, OpenAI's coding agent
vscode "openai.codex-audio"                   # Codex dictation (microphone)
vscode "biomejs.biome"                        # Biome: format and lint JS/TS
vscode "bradlc.vscode-tailwindcss"            # Tailwind CSS IntelliSense
vscode "formulahendry.auto-rename-tag"        # Rename paired HTML/XML tags
vscode "github.vscode-github-actions"         # GitHub Actions workflows and runs
vscode "graphql.vscode-graphql"               # GraphQL language support
vscode "graphql.vscode-graphql-syntax"        # GraphQL syntax highlighting
vscode "mquandalle.graphql"                   # GraphQL syntax highlighting (legacy)
vscode "prisma.prisma"                        # Prisma schema support
vscode "redhat.vscode-yaml"                   # YAML language support
vscode "ms-vscode.vscode-typescript-next"     # TypeScript nightly
vscode "ms-azuretools.vscode-containers"      # Container tools
vscode "ms-vscode-remote.remote-containers"   # Dev Containers
vscode "cweijan.vscode-postgresql-client2"    # PostgreSQL client
vscode "cweijan.dbclient-jdbc"                # JDBC adapter for the database client
vscode "ms-vscode.sublime-keybindings"        # Sublime Text keymap
vscode "vscode-icons-team.vscode-icons"       # File icons

# ── macOS utilities ─────────────────────────────────────────
cask "dockdoor"                   # Window previews in the Dock
cask "logi-options+"
cask "purge"                     # Clear caches and junk files
