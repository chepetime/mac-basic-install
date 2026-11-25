# Mac setup

How I set up a new Mac for web development and coding agents. Almost everything installs with [Homebrew](https://brew.sh).

> The 2017–2020 version of this guide is in the git history before commit `096737f`.

## Quick start

```sh
git clone https://github.com/chepetime/mac-basic-install.git ~/Projects/mac-basic-install
cd ~/Projects/mac-basic-install
./install.sh
```

`install.sh` is safe to run more than once. It does the steps below for you.

## Step by step

### 1. Update macOS

Open **System Settings → General → Software Update** and install all updates.

### 2. Install the Command Line Developer Tools

```sh
xcode-select --install
```

### 3. Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 4. Install all apps and tools

```sh
brew bundle --file=Brewfile
```

To install only one tool, use the command in the [tool list](#tools). To see what is missing, run `brew bundle check --file=Brewfile`.

### 5. Link the config files

```sh
mkdir -p ~/.config/ghostty
ln -sfn "$PWD/home/.zprofile"              ~/.zprofile
ln -sfn "$PWD/home/.zshrc"                 ~/.zshrc
ln -sfn "$PWD/home/.config/zsh"            ~/.config/zsh
ln -sfn "$PWD/home/.config/starship.toml"  ~/.config/starship.toml
ln -sfn "$PWD/home/.config/ghostty/config" ~/.config/ghostty/config
```

Ghostty also reads `~/Library/Application Support/com.mitchellh.ghostty/config`. If that file exists, remove it or keep it empty, so it does not override this config.

### 6. Install Node

[mise](https://mise.jdx.dev) manages Node, pnpm, and other runtimes. Do not install Node with Homebrew or nvm.

```sh
mise use --global node@lts
mise use --global pnpm@latest
```

### 7. Sign in

- `gh auth login` — GitHub CLI.
- `claude` and `codex` — sign in on first run.
- Open Raycast and set it as the Spotlight replacement (`⌘ Space`).

### 8. Machine-only settings

Put anything private (work aliases, tokens, work paths) in `~/.zshrc.local`. `.zshrc` loads it near the end. It is never committed. See [PUBLISHING.md](PUBLISHING.md).

Some aliases read settings from it:

```sh
# ~/.zshrc.local
export WEATHER_CITY="Lisbon"              # weather, wttr (empty = location from IP)
export HOME_CURRENCY="EUR"                # currency, watchrate, ratehistory (default USD)
export NONO_CLAUDE_PROFILE="my-profile"   # nclaude, scc (sandboxed Claude Code)
```

## Shell

- **Terminal:** [Ghostty](https://ghostty.org), with [Herdr](https://herdr.dev) to run terminals and coding agents side by side.
- **Font:** [Geist Mono Nerd Font](https://www.nerdfonts.com). The Nerd Font glyphs are necessary for the Starship icons.
- **Prompt:** [Starship](https://starship.rs), with the Nerd Font symbols preset in [`home/.config/starship.toml`](home/.config/starship.toml).
- **Shell:** zsh, no framework. [`home/.zshrc`](home/.zshrc) loads the modules in [`home/.config/zsh`](home/.config/zsh) and caches tool init scripts for a fast start.

| File | What it does |
| --- | --- |
| `.zprofile` | Homebrew environment (static, no subprocess) and OrbStack |
| `completion.zsh`, `history.zsh`, `key-bindings.zsh` | Completion menu, shared 50k history, emacs keys with prefix history search |
| `aliases/core.zsh` | `ll`, `..`, `path`, `reload` |
| `aliases/git.zsh` | Git and `gh` shortcuts; `repo`, `pr`, `pr-new` open the repo or PR in the browser |
| `aliases/brew.zsh` | `brewm`: update and upgrade everything, clean up, notify |
| `aliases/claude.zsh` | Claude Code and Codex launchers, nono sandbox variants, pipe helpers |
| `aliases/pi.zsh` | Pi coding agent shortcuts |
| `aliases/pnpm.zsh` | `p`, `dev`, `build`, `lint` |
| `aliases/docker.zsh` | `d`, `dc`, `dcu`, `dex` |
| `aliases/system.zsh` | `ports`, `killport`, `fkill`, `flushdns`, `battery` |
| `aliases/network.zsh` | `myip`, `localip`, `netinfo`, `speedtest` |
| `aliases/files.zsh`, `aliases/shortcuts.zsh` | `mkcd`, `extract`, `serve`, `uuid`, clipboard helpers |
| `aliases/fun.zsh` | Weather, currency, timers, `pomodoro`, and other toys |
| `aliases/coffee.zsh` | Step-by-step AeroPress timer |

## Tools

Install one tool: `brew install <name>` for formulae, `brew install --cask <name>` for casks. The [Brewfile](Brewfile) has all of them.

### Terminal

| Tool | Install | What for |
| --- | --- | --- |
| Ghostty | `brew install --cask ghostty` | Terminal |
| Herdr (app) | `brew install --cask herdr-app` | Desktop app for terminals and coding agents |
| Herdr (CLI) | `brew install herdr` | Agent multiplexer in the terminal |
| Starship | `brew install starship` | Shell prompt |
| zsh-autosuggestions | `brew install zsh-autosuggestions` | Suggest commands from history |
| zsh-fast-syntax-highlighting | `brew install zsh-fast-syntax-highlighting` | Color commands as you type |
| Geist Mono Nerd Font | `brew install --cask font-geist-mono-nerd-font` | Terminal font with icons |

### Runtimes

| Tool | Install | What for |
| --- | --- | --- |
| mise | `brew install mise` | Node, pnpm, and other runtimes |
| uv | `brew install uv` | Python and Python packages |
| Rust | `brew install rust` | Rust toolchain |
| Zig | `brew install zig` | Zig toolchain |
| sccache | `brew install sccache` | Compiler cache |

### Command line

| Tool | Install | Replaces |
| --- | --- | --- |
| eza | `brew install eza` | `ls` |
| bat | `brew install bat` | `cat` |
| fd | `brew install fd` | `find` |
| ripgrep | `brew install ripgrep` | `grep` |
| fzf | `brew install fzf` | Fuzzy finder |
| zoxide | `brew install zoxide` | `cd` |
| git-delta | `brew install git-delta` | Git diff pager |
| direnv | `brew install direnv` | Per-directory env vars |
| jq | `brew install jq` | JSON processor |
| gum | `brew install gum` | Prompts in shell scripts |
| tree, ncdu, coreutils, fswatch, terminal-notifier | `brew install <name>` | Small utilities |

### System

| Tool | Install | What for |
| --- | --- | --- |
| btop | `brew install btop` | Process monitor |
| macmon | `brew install macmon` | Apple Silicon power and temperature |
| fastfetch | `brew install fastfetch` | System info |
| Mole | `brew install mole` | Deep clean and optimize the Mac |

### Git, GitHub, and security

| Tool | Install | What for |
| --- | --- | --- |
| GitHub CLI | `brew install gh` | PRs, issues, Actions |
| act | `brew install act` | Run GitHub Actions locally |
| actionlint | `brew install actionlint` | Lint workflow files |
| gitleaks | `brew install gitleaks` | Find secrets in git |
| zizmor | `brew install zizmor` | Audit GitHub Actions security |
| osv-scanner | `brew install osv-scanner` | Find vulnerable dependencies |
| nono | `brew install nono` | Sandbox for coding agents |

### Containers, cloud, databases

| Tool | Install | What for |
| --- | --- | --- |
| OrbStack | `brew install --cask orbstack` | Docker and Linux VMs |
| Helm | `brew install helm` | Kubernetes charts |
| AWS CLI | `brew install awscli` | AWS |
| PostgreSQL 16 | `brew install postgresql@16` | Local database and `psql` |

### Media

| Tool | Install | What for |
| --- | --- | --- |
| FFmpeg | `brew install ffmpeg` | Audio and video |
| Poppler | `brew install poppler` | PDF tools |

### AI

| Tool | Install | What for |
| --- | --- | --- |
| Claude | `brew install --cask claude` | Claude desktop app |
| Claude Code | `brew install --cask claude-code` | Coding agent CLI |
| Codex | `brew install --cask codex` | Coding agent |
| ChatGPT | `brew install --cask chatgpt` | Desktop app |
| Pi | `brew install pi-coding-agent` | Agent toolkit |
| Ollama | `brew install ollama` | Local models |
| Wispr Flow | `brew install --cask wispr-flow` | Voice dictation |
| tokenuse | `brew install russmckendrick/tap/tokenuse` | Token usage tracker (CLI) |
| tokenuse desktop | `brew install --cask russmckendrick/tap/tokenuse-desktop` | Token usage tracker (app) |
| AgentsView | `brew install --cask agentsview` | Browse agent sessions |
| Textream | `brew install --cask f/textream/textream` | Teleprompter |

### Apps

| Tool | Install | What for |
| --- | --- | --- |
| Raycast | `brew install --cask raycast` | Launcher |
| VS Code | `brew install --cask visual-studio-code` | Editor |
| Figma | `brew install --cask figma` | Design |
| Miro | `brew install --cask miro` | Whiteboard |
| Notion, Notion Calendar, Notion Mail | `brew install --cask notion notion-calendar notion-mail` | Notes, calendar, mail |
| Spotify | `brew install --cask spotify` | Music |
| Numi | `brew install --cask numi` | Calculator |

### macOS utilities

| Tool | Install | What for |
| --- | --- | --- |
| DockDoor | `brew install --cask dockdoor` | Window previews in the Dock |
| MonitorControl | `brew install --cask monitorcontrol` | External display brightness |
| Logi Options+ | `brew install --cask logi-options+` | Logitech devices |
| Purge | `brew install --cask purge` | Clear caches and junk files |

## Contributing

This repo is public. Read [PUBLISHING.md](PUBLISHING.md) before you change anything. Agents: read [AGENTS.md](AGENTS.md).
