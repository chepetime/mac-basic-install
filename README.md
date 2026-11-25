# Mac setup

How I set up a new Mac for web development and coding agents. Almost everything installs with [Homebrew](https://brew.sh).

> The 2017–2020 version of this guide is in the git history before commit `096737f`.

## Quick start

On a new Mac, open Terminal and run:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/chepetime/mac-basic-install/main/install.sh)"
```

The script installs the Command Line Developer Tools and Homebrew, clones this repo to `~/Projects/mac-basic-install` (change it with `MAC_SETUP_DIR`), installs everything in the [Brewfile](Brewfile), links the config files, installs Node, and applies the [macOS settings](macos/defaults.sh). It is safe to run more than once. Add `--no-defaults` to skip the macOS settings.

Before you start, update macOS: **System Settings → General → Software Update**.

### After the script

1. **Sign in.** First 1Password. Then the App Store, then GitHub:
   ```sh
   gh auth login
   gh auth setup-git
   ```
2. **Install App Store apps.** These fail if you are not signed in to the App Store. Run the Brewfile again after sign-in:
   ```sh
   brew bundle --file=~/Projects/mac-basic-install/Brewfile
   ```
3. **Set your git identity.** It goes in `~/.gitconfig`, which is not in this repo:
   ```sh
   git config --global user.name "Your Name"
   git config --global user.email "you@example.com"
   ```
4. **Raycast.** Set it as the Spotlight replacement (`⌘ Space`). Import your settings from a `.rayconfig` export. Keep that file out of this repo.
5. **Agents.** Run `claude` and `codex` once to sign in.
6. **Check.** `brew bundle check --file=~/Projects/mac-basic-install/Brewfile` lists anything that is missing.

## What the script does, step by step

To do it by hand, run these from the repo folder.

```sh
xcode-select --install                                   # 1. Command Line Developer Tools
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"  # 2. Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file=Brewfile                              # 3. Apps, tools, App Store apps, VS Code extensions

mkdir -p ~/.config/ghostty ~/.config/git                 # 4. Config files
ln -sfn "$PWD/home/.zprofile"              ~/.zprofile
ln -sfn "$PWD/home/.zshrc"                 ~/.zshrc
ln -sfn "$PWD/home/.config/zsh"            ~/.config/zsh
ln -sfn "$PWD/home/.config/starship.toml"  ~/.config/starship.toml
ln -sfn "$PWD/home/.config/ghostty/config" ~/.config/ghostty/config
ln -sfn "$PWD/home/.config/git/config"     ~/.config/git/config
ln -sfn "$PWD/home/.config/git/ignore"     ~/.config/git/ignore

mise use --global node@lts pnpm@latest                   # 5. Node and pnpm
bash macos/defaults.sh                                   # 6. macOS settings
```

Ghostty also reads `~/Library/Application Support/com.mitchellh.ghostty/config`. If that file exists, remove it so it does not override this config.

## One install method per tool

Homebrew installs and updates everything. Do not mix it with other installers:

- **Node and pnpm:** use mise. Do not install them with Homebrew or nvm.
- **Claude Code, mise, Herdr:** use the Homebrew packages. Do not use their own `curl` installers. `brewm` upgrades them with `brew upgrade --greedy`.
- **App Store apps:** `mas` installs them from the Brewfile. `brewm` upgrades them.

To move a Mac that used the native installers to Homebrew:

```sh
rm ~/.local/bin/claude && rm -rf ~/.local/share/claude/versions   # sessions and settings in ~/.claude stay
rm ~/.local/bin/mise                                              # tools in ~/.local/share/mise stay
rm ~/.local/bin/herdr-app ~/.local/bin/herdr-core && rm -rf ~/Applications/Herdr.app ~/.local/share/herdr-core
brew bundle --file=Brewfile
```

## Git

[`home/.config/git/config`](home/.config/git/config) holds the shared settings: `main` as the default branch, `push.autoSetupRemote`, HTTPS for GitHub through `gh` (no SSH keys), and delta as the pager. [`home/.config/git/ignore`](home/.config/git/ignore) is the global ignore list.

Git also reads `~/.gitconfig`. Keep it machine-only: your name and email, `includeIf` blocks for work folders, and the credential helper from `gh auth setup-git`.

## macOS settings

[`macos/defaults.sh`](macos/defaults.sh) sets the Dock (auto-hide, no recent apps), Finder (path bar, status bar, list view, search the current folder), tap to click, no natural scrolling, and the screenshot folder `~/Documents/Screenshots`. It does not use `sudo`.

## Machine-only settings

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
| Herdr | `brew install --cask herdr-app` | Desktop app for terminals and coding agents |
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
| ShellCheck | `brew install shellcheck` | Lint shell scripts |
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

### Mac App Store

Install `mas` first (`brew install mas`) and sign in to the App Store. Then `mas install <id>`.

| App | ID | What for |
| --- | --- | --- |
| BetterSnapTool | `417375580` | Window snapping |
| Paste | `967805235` | Clipboard history |
| Folder Peek | `1615988943` | Folders in the menu bar |
| Speedtest | `1153157709` | Network speed |
| Xcode | `497799835` | Apple SDKs and simulators |
| Keynote | `409183694` | Slides |
| Keynote, Pages, Numbers Creator Studio | `361285480`, `361309726`, `361304891` | Apple office apps |

### VS Code extensions

The Brewfile installs 19 extensions with `vscode "…"` lines: Claude Code, ChatGPT/Codex, Biome, Tailwind CSS, GraphQL, Prisma, YAML, Dev Containers, a PostgreSQL client, and others. One extension: `code --install-extension <id>`.

### macOS utilities

| Tool | Install | What for |
| --- | --- | --- |
| DockDoor | `brew install --cask dockdoor` | Window previews in the Dock |
| MonitorControl | `brew install --cask monitorcontrol` | External display brightness |
| Logi Options+ | `brew install --cask logi-options+` | Logitech devices |
| Purge | `brew install --cask purge` | Clear caches and junk files |

## Contributing

This repo is public. Read [PUBLISHING.md](PUBLISHING.md) before you change anything. Agents: read [AGENTS.md](AGENTS.md).
