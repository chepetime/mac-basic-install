# Mac setup

[![Secret scan](https://github.com/chepetime/mac-basic-install/actions/workflows/gitleaks.yml/badge.svg)](https://github.com/chepetime/mac-basic-install/actions/workflows/gitleaks.yml)
[![Lint](https://github.com/chepetime/mac-basic-install/actions/workflows/lint.yml/badge.svg)](https://github.com/chepetime/mac-basic-install/actions/workflows/lint.yml)

How I set up a new Mac for web development and coding agents. One script installs everything with [Homebrew](https://brew.sh), links a small set of config files, and applies my macOS settings. Every tool below links to its homepage and to the package that installs it.

> I started this guide in 2017. The 2017–2020 version is in the git history before commit [`096737f`](https://github.com/chepetime/mac-basic-install/commit/096737f).

## Contents

- [Requirements](#requirements)
- [Quick start](#quick-start)
- [What the script does](#what-the-script-does)
- [Repo layout](#repo-layout)
- [One install method per tool](#one-install-method-per-tool)
- [Shell](#shell)
- [Git](#git)
- [macOS settings](#macos-settings)
- [Machine-only settings](#machine-only-settings)
- [Keep it up to date](#keep-it-up-to-date)
- [Undo](#undo)
- [Tools](#tools)
- [Contributing](#contributing)

## Requirements

- A Mac with Apple Silicon. The script expects Homebrew in `/opt/homebrew`.
- macOS 26 (Tahoe). I wrote and use this setup on macOS 26.7.
- An admin account. The Homebrew installer and some casks ask for your password.
- For App Store apps: an Apple Account signed in to the App Store.

## Quick start

1. Update macOS: **System Settings → General → Software Update**.
2. Open Terminal and run:

   ```sh
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/chepetime/mac-basic-install/main/install.sh)"
   ```

   The script is safe to run more than once. Add `--no-defaults` to skip the macOS settings. To clone to another folder, set `MAC_SETUP_DIR` (default `~/Projects/mac-basic-install`).

3. After the script:
   1. **Sign in.** First [1Password](https://1password.com). Then the App Store. Then GitHub with the [GitHub CLI](https://cli.github.com):
      ```sh
      gh auth login
      gh auth setup-git
      ```
   2. **Install App Store apps.** They fail when you are not signed in to the App Store. Run the Brewfile again after sign-in:
      ```sh
      brew bundle --file=~/Projects/mac-basic-install/Brewfile
      ```
   3. **Set your git identity.** It goes in `~/.gitconfig`, which is not in this repo:
      ```sh
      git config --global user.name "Your Name"
      git config --global user.email "you@example.com"
      ```
   4. **[Raycast](https://www.raycast.com).** Set it as the Spotlight replacement (`⌘ Space`). Move your settings with the Raycast commands **Export Settings & Data** and **Import Settings & Data**. Keep that file out of this repo.
   5. **Agents.** Run `claude` and `codex` once to sign in.
   6. **Check.** `brew bundle check --file=~/Projects/mac-basic-install/Brewfile` lists anything that is missing.

## What the script does

[`install.sh`](install.sh) runs these steps. To do them by hand, run the commands from the repo folder.

| # | Step | Command |
| --- | --- | --- |
| 1 | [Command Line Developer Tools](https://developer.apple.com/xcode/resources/) (git, compilers). The script waits for the installer window. | `xcode-select --install` |
| 2 | [Homebrew](https://brew.sh) | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` |
| 3 | Clone this repo (only when the script runs from `curl`) | `git clone https://github.com/chepetime/mac-basic-install.git ~/Projects/mac-basic-install` |
| 4 | Apps, CLI tools, App Store apps, and VS Code extensions with [Homebrew Bundle](https://docs.brew.sh/Brew-Bundle-and-Brewfile). A failed item does not stop the script. | `brew bundle --file=Brewfile` |
| 5 | Link the config files (see below). An existing file moves to `*.backup.<timestamp>`. | `ln -sfn …` |
| 6 | Node LTS and pnpm with [mise](https://mise.jdx.dev) | `mise use --global node@lts pnpm@latest` |
| 7 | macOS settings | `bash macos/defaults.sh` |
| 8 | Enable the secret-scan hook in this repo | `git config core.hooksPath .githooks` |

Linked files:

```sh
ln -sfn "$PWD/home/.zprofile"              ~/.zprofile
ln -sfn "$PWD/home/.zshrc"                 ~/.zshrc
ln -sfn "$PWD/home/.config/zsh"            ~/.config/zsh
ln -sfn "$PWD/home/.config/starship.toml"  ~/.config/starship.toml
ln -sfn "$PWD/home/.config/ghostty/config" ~/.config/ghostty/config
ln -sfn "$PWD/home/.config/git/config"     ~/.config/git/config
ln -sfn "$PWD/home/.config/git/ignore"     ~/.config/git/ignore
```

Ghostty also reads `~/Library/Application Support/com.mitchellh.ghostty/config` ([docs](https://ghostty.org/docs/config)). If that file exists, remove it so it does not override this config.

## Repo layout

```
.
├── Brewfile                 # every app, CLI tool, App Store app, and VS Code extension
├── install.sh               # bootstrap script
├── macos/defaults.sh        # macOS settings
├── home/                    # files that mirror ~ (symlinked by install.sh)
│   ├── .zprofile
│   ├── .zshrc
│   └── .config/
│       ├── zsh/             # completion, history, key bindings, aliases/
│       ├── git/             # shared git config and global ignore
│       ├── ghostty/config
│       └── starship.toml
├── scripts/gen-tools.py     # builds the Tools section of this README from the Brewfile
├── .githooks/pre-commit     # gitleaks on staged changes
├── .github/workflows/       # CI: secret scan and lint
├── PUBLISHING.md            # what may and may not go in this public repo
└── AGENTS.md                # rules for coding agents (CLAUDE.md imports it)
```

## One install method per tool

Homebrew installs and updates everything. Do not mix it with other installers:

- **Node and pnpm:** use [mise](https://mise.jdx.dev). Do not install them with Homebrew or [nvm](https://github.com/nvm-sh/nvm).
- **Claude Code, mise, Herdr:** use the Homebrew packages. Do not use their own `curl` installers. `brewm` upgrades them with `brew upgrade --greedy`.
- **App Store apps:** [mas](https://github.com/mas-cli/mas) installs them from the Brewfile. `brewm` upgrades them.

To move a Mac that used the native installers to Homebrew:

```sh
rm ~/.local/bin/claude && rm -rf ~/.local/share/claude/versions   # sessions and settings in ~/.claude stay
rm ~/.local/bin/mise                                              # tools in ~/.local/share/mise stay
rm ~/.local/bin/herdr-app ~/.local/bin/herdr-core && rm -rf ~/Applications/Herdr.app ~/.local/share/herdr-core
brew bundle --file=Brewfile
```

## Shell

- **Terminal:** [Ghostty](https://ghostty.org), with [Herdr](https://herdr.dev) to run terminals and coding agents side by side. Config: [`home/.config/ghostty/config`](home/.config/ghostty/config).
- **Font:** [Geist Mono](https://vercel.com/font) from [Nerd Fonts](https://www.nerdfonts.com). The Nerd Font glyphs are necessary for the prompt icons.
- **Prompt:** [Starship](https://starship.rs), with the [Nerd Font Symbols preset](https://starship.rs/presets/nerd-font) in [`home/.config/starship.toml`](home/.config/starship.toml).
- **Shell:** zsh, no framework. [`home/.zshrc`](home/.zshrc) loads the modules in [`home/.config/zsh`](home/.config/zsh) and caches the init scripts of mise, fzf, zoxide, direnv, and Starship. A new shell starts in about 50 ms.
- **Plugins:** [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) and [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting), installed with Homebrew.

| File | What it does |
| --- | --- |
| [`.zprofile`](home/.zprofile) | Homebrew environment (static, no subprocess) and [OrbStack](https://orbstack.dev) |
| [`completion.zsh`](home/.config/zsh/completion.zsh), [`history.zsh`](home/.config/zsh/history.zsh), [`key-bindings.zsh`](home/.config/zsh/key-bindings.zsh) | Completion menu, shared 50k history, emacs keys with prefix history search. Adapted from [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) (MIT) |
| [`aliases/core.zsh`](home/.config/zsh/aliases/core.zsh) | `ll`, `..`, `path`, `reload` |
| [`aliases/git.zsh`](home/.config/zsh/aliases/git.zsh) | Git and `gh` shortcuts; `repo`, `pr`, `pr-new` open the repo or PR in the browser |
| [`aliases/brew.zsh`](home/.config/zsh/aliases/brew.zsh) | `brewm`: update and upgrade everything, clean up, notify |
| [`aliases/claude.zsh`](home/.config/zsh/aliases/claude.zsh) | [Claude Code](https://claude.com/product/claude-code) and [Codex](https://github.com/openai/codex) launchers, [nono](https://nono.sh) sandbox variants, pipe helpers |
| [`aliases/pi.zsh`](home/.config/zsh/aliases/pi.zsh) | [Pi](https://pi.dev) coding agent shortcuts |
| [`aliases/pnpm.zsh`](home/.config/zsh/aliases/pnpm.zsh) | `p`, `dev`, `build`, `lint` |
| [`aliases/docker.zsh`](home/.config/zsh/aliases/docker.zsh) | `d`, `dc`, `dcu`, `dex` |
| [`aliases/system.zsh`](home/.config/zsh/aliases/system.zsh) | `ports`, `killport`, `fkill`, `flushdns`, `battery` |
| [`aliases/network.zsh`](home/.config/zsh/aliases/network.zsh) | `myip`, `localip`, `netinfo`, `speedtest` |
| [`aliases/files.zsh`](home/.config/zsh/aliases/files.zsh), [`aliases/shortcuts.zsh`](home/.config/zsh/aliases/shortcuts.zsh) | `mkcd`, `extract`, `serve`, `uuid`, clipboard helpers |
| [`aliases/fun.zsh`](home/.config/zsh/aliases/fun.zsh) | Weather ([wttr.in](https://wttr.in)), currency ([Frankfurter](https://frankfurter.dev)), timers, `pomodoro`, and other toys |
| [`aliases/coffee.zsh`](home/.config/zsh/aliases/coffee.zsh) | Step-by-step AeroPress timer |

## Git

[`home/.config/git/config`](home/.config/git/config) holds the shared settings:

- `main` as the default branch for new repos.
- `push.autoSetupRemote`: the first `git push` sets the upstream.
- HTTPS for GitHub through [`gh auth setup-git`](https://cli.github.com/manual/gh_auth_setup-git), also for `git@github.com:` URLs. You need no SSH keys.
- [delta](https://dandavison.github.io/delta/) as the pager for diffs and `git add -p`.

[`home/.config/git/ignore`](home/.config/git/ignore) is the global ignore list: macOS files and Claude Code local files.

Git also reads `~/.gitconfig` ([docs](https://git-scm.com/docs/git-config#FILES)). Keep it machine-only: your name and email, [`includeIf`](https://git-scm.com/docs/git-config#_conditional_includes) blocks for work folders, and the credential helper from `gh auth setup-git`.

## macOS settings

[`macos/defaults.sh`](macos/defaults.sh) uses [`defaults write`](https://macos-defaults.com). It does not use `sudo`.

| Area | Setting |
| --- | --- |
| Finder | Path bar and status bar on, list view, search the current folder, new windows open home, all file extensions visible |
| Dock | Auto-hide, icon size 55, no recent apps, minimize into the app icon, scale effect |
| Desktop | A click on the wallpaper does not hide windows; no margins between tiled windows |
| Trackpad | Tap to click, natural scrolling off |
| Files | No `.DS_Store` files on network and USB volumes |
| Screenshots | Saved to `~/Documents/Screenshots` |

## Machine-only settings

Put anything private (work aliases, tokens, work paths) in `~/.zshrc.local`. `.zshrc` loads it near the end. It is never committed. See [PUBLISHING.md](PUBLISHING.md).

Some aliases read settings from it:

```sh
# ~/.zshrc.local
export WEATHER_CITY="Lisbon"              # weather, wttr (empty = location from IP)
export HOME_CURRENCY="EUR"                # currency, watchrate, ratehistory (default USD)
export NONO_CLAUDE_PROFILE="my-profile"   # nclaude, scc (sandboxed Claude Code)
```

## Keep it up to date

| Task | Command |
| --- | --- |
| Update Homebrew, all formulae and casks, and App Store apps; clean up | `brewm` (add `--doctor` to also run `brew doctor`) |
| List what is missing from this Mac | `brew bundle check --file=Brewfile --verbose` |
| List what is installed but not in the Brewfile | `brew bundle cleanup --file=Brewfile` (no `--force`: it only lists) |
| Update the Tools section after you change the Brewfile | `scripts/gen-tools.py` |

## Undo

- `install.sh` never deletes a file. When a real file is in the way of a link, it moves the file to `<name>.backup.<timestamp>`. To restore one, remove the link and move the backup back:
  ```sh
  rm ~/.zshrc && mv ~/.zshrc.backup.20261125120000 ~/.zshrc
  ```
- To reset a macOS setting, delete its key, for example `defaults delete com.apple.dock tilesize && killall Dock`.
- To remove an app: `brew uninstall --cask <name>` or `brew uninstall <name>`.

## Tools

Install one tool with the command in its row. The [Brewfile](Brewfile) has all of them. Each tool name links to its homepage. Each install command links to the package that Homebrew, the App Store, or the VS Code Marketplace installs.

<!-- tools:start -->

<!-- Generated by scripts/gen-tools.py from the Brewfile. Do not edit by hand. -->

### Terminal

| Tool | Install | What for |
| --- | --- | --- |
| [Ghostty](https://ghostty.org/) | [`brew install --cask ghostty`](https://formulae.brew.sh/cask/ghostty) | GPU terminal |
| [Herdr](https://herdr.dev/) | [`brew install --cask herdr-app`](https://formulae.brew.sh/cask/herdr-app) | Desktop app for terminals and coding agents |
| [starship](https://starship.rs/) | [`brew install starship`](https://formulae.brew.sh/formula/starship) | Shell prompt |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | [`brew install zsh-autosuggestions`](https://formulae.brew.sh/formula/zsh-autosuggestions) | Suggest commands from history |
| [zsh-fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | [`brew install zsh-fast-syntax-highlighting`](https://formulae.brew.sh/formula/zsh-fast-syntax-highlighting) | Color commands as you type |
| [GeistMono Nerd Font (Geist Mono)](https://github.com/ryanoasis/nerd-fonts) | [`brew install --cask font-geist-mono-nerd-font`](https://formulae.brew.sh/cask/font-geist-mono-nerd-font) | Terminal font with Nerd Font icons |

### Runtimes and package managers

| Tool | Install | What for |
| --- | --- | --- |
| [mise](https://mise.jdx.dev/) | [`brew install mise`](https://formulae.brew.sh/formula/mise) | Node, pnpm, and other runtimes (replaces nvm) |
| [uv](https://docs.astral.sh/uv/) | [`brew install uv`](https://formulae.brew.sh/formula/uv) | Python |
| [rust](https://www.rust-lang.org/) | [`brew install rust`](https://formulae.brew.sh/formula/rust) | Safe, concurrent, practical language |
| [zig](https://ziglang.org/) | [`brew install zig`](https://formulae.brew.sh/formula/zig) | Programming language designed for robustness, optimality, and clarity |
| [sccache](https://github.com/mozilla/sccache) | [`brew install sccache`](https://formulae.brew.sh/formula/sccache) | Compiler cache |

### Modern CLI

| Tool | Install | What for |
| --- | --- | --- |
| [eza](https://eza.rocks) | [`brew install eza`](https://formulae.brew.sh/formula/eza) | ls |
| [bat](https://github.com/sharkdp/bat) | [`brew install bat`](https://formulae.brew.sh/formula/bat) | cat |
| [fd](https://github.com/sharkdp/fd) | [`brew install fd`](https://formulae.brew.sh/formula/fd) | find |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | [`brew install ripgrep`](https://formulae.brew.sh/formula/ripgrep) | grep |
| [fzf](https://junegunn.github.io/fzf/) | [`brew install fzf`](https://formulae.brew.sh/formula/fzf) | Fuzzy finder |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | [`brew install zoxide`](https://formulae.brew.sh/formula/zoxide) | cd (replaces autojump) |
| [git-delta](https://dandavison.github.io/delta/) | [`brew install git-delta`](https://formulae.brew.sh/formula/git-delta) | Git diff pager |
| [direnv](https://direnv.net/) | [`brew install direnv`](https://formulae.brew.sh/formula/direnv) | Per-directory env vars |
| [jq](https://jqlang.github.io/jq/) | [`brew install jq`](https://formulae.brew.sh/formula/jq) | Lightweight and flexible command-line JSON processor |
| [gum](https://github.com/charmbracelet/gum) | [`brew install gum`](https://formulae.brew.sh/formula/gum) | Pretty shell-script prompts |
| [tree](https://oldmanprogrammer.net/source.php?dir=projects/tree) | [`brew install tree`](https://formulae.brew.sh/formula/tree) | Display directories as trees (with optional color/HTML output) |
| [ncdu](https://dev.yorhel.nl/ncdu) | [`brew install ncdu`](https://formulae.brew.sh/formula/ncdu) | Disk usage |
| [coreutils](https://www.gnu.org/software/coreutils/) | [`brew install coreutils`](https://formulae.brew.sh/formula/coreutils) | GNU File, Shell, and Text utilities |
| [fswatch](https://emcrisostomo.github.io/fswatch/) | [`brew install fswatch`](https://formulae.brew.sh/formula/fswatch) | Monitor a directory for changes and run a shell command |
| [terminal-notifier](https://github.com/julienXX/terminal-notifier) | [`brew install terminal-notifier`](https://formulae.brew.sh/formula/terminal-notifier) | Send macOS User Notifications from the command-line |

### System monitoring

| Tool | Install | What for |
| --- | --- | --- |
| [btop](https://github.com/aristocratos/btop) | [`brew install btop`](https://formulae.brew.sh/formula/btop) | Resource monitor. C++ version and continuation of bashtop and bpytop |
| [macmon](https://github.com/vladkens/macmon) | [`brew install macmon`](https://formulae.brew.sh/formula/macmon) | Apple Silicon power/temperature |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | [`brew install fastfetch`](https://formulae.brew.sh/formula/fastfetch) | Like neofetch, but much faster because written mostly in C |
| [mole](https://mole.fit) | [`brew install mole`](https://formulae.brew.sh/formula/mole) | Mac cleanup |

### Git and GitHub

| Tool | Install | What for |
| --- | --- | --- |
| [gh](https://cli.github.com/) | [`brew install gh`](https://formulae.brew.sh/formula/gh) | GitHub command-line tool |
| [act](https://nektosact.com) | [`brew install act`](https://formulae.brew.sh/formula/act) | Run GitHub Actions locally |
| [actionlint](https://rhysd.github.io/actionlint/) | [`brew install actionlint`](https://formulae.brew.sh/formula/actionlint) | Lint workflow files |
| [shellcheck](https://www.shellcheck.net/) | [`brew install shellcheck`](https://formulae.brew.sh/formula/shellcheck) | Lint shell scripts |

### Security

| Tool | Install | What for |
| --- | --- | --- |
| [gitleaks](https://gitleaks.io/) | [`brew install gitleaks`](https://formulae.brew.sh/formula/gitleaks) | Secret scanner |
| [zizmor](https://docs.zizmor.sh/) | [`brew install zizmor`](https://formulae.brew.sh/formula/zizmor) | GitHub Actions security audit |
| [osv-scanner](https://google.github.io/osv-scanner/) | [`brew install osv-scanner`](https://formulae.brew.sh/formula/osv-scanner) | Dependency vulnerability scanner |
| [nono](https://nono.sh) | [`brew install nono`](https://formulae.brew.sh/formula/nono) | Sandbox for agents |

### Cloud, containers, databases

| Tool | Install | What for |
| --- | --- | --- |
| [OrbStack](https://orbstack.dev/) | [`brew install --cask orbstack`](https://formulae.brew.sh/cask/orbstack) | Docker and Linux VMs |
| [helm](https://helm.sh/) | [`brew install helm`](https://formulae.brew.sh/formula/helm) | Kubernetes package manager |
| [awscli](https://aws.amazon.com/cli/) | [`brew install awscli`](https://formulae.brew.sh/formula/awscli) | Official Amazon AWS command-line interface |
| [postgresql@16](https://www.postgresql.org/) | [`brew install postgresql@16`](https://formulae.brew.sh/formula/postgresql@16) | Object-relational database system |

### Media and documents

| Tool | Install | What for |
| --- | --- | --- |
| [ffmpeg](https://ffmpeg.org/) | [`brew install ffmpeg`](https://formulae.brew.sh/formula/ffmpeg) | Play, record, convert, and stream select audio and video codecs |
| [poppler](https://poppler.freedesktop.org/) | [`brew install poppler`](https://formulae.brew.sh/formula/poppler) | PDF tools |

### AI

| Tool | Install | What for |
| --- | --- | --- |
| [Claude](https://claude.com/download) | [`brew install --cask claude`](https://formulae.brew.sh/cask/claude) | Claude desktop |
| [Claude Code](https://claude.com/product/claude-code) | [`brew install --cask claude-code`](https://formulae.brew.sh/cask/claude-code) | Claude Code CLI |
| [Codex](https://github.com/openai/codex) | [`brew install --cask codex`](https://formulae.brew.sh/cask/codex) | OpenAI's coding agent that runs in your terminal |
| [ChatGPT](https://chatgpt.com/) | [`brew install --cask chatgpt`](https://formulae.brew.sh/cask/chatgpt) | OpenAI's official ChatGPT desktop app |
| [pi-coding-agent](https://pi.dev/) | [`brew install pi-coding-agent`](https://formulae.brew.sh/formula/pi-coding-agent) | AI agent toolkit |
| [ollama](https://ollama.com/) | [`brew install ollama`](https://formulae.brew.sh/formula/ollama) | Local models |
| [Wispr Flow](https://wisprflow.ai/) | [`brew install --cask wispr-flow`](https://formulae.brew.sh/cask/wispr-flow) | Voice dictation |
| [tokenuse](https://github.com/russmckendrick/tokenuse) | [`brew install russmckendrick/tap/tokenuse`](https://github.com/russmckendrick/homebrew-tap) | Local-only Rust TUI for AI coding tool token and cost usage |
| [Token Use](https://github.com/russmckendrick/tokenuse) | [`brew install --cask russmckendrick/tap/tokenuse-desktop`](https://github.com/russmckendrick/homebrew-tap) | Desktop app for local AI coding tool token and cost usage |
| [AgentsView](https://www.agentsview.io/) | [`brew install --cask agentsview`](https://formulae.brew.sh/cask/agentsview) | Browse, search and analyse your past AI coding sessions |
| [Textream](https://textream.net/) | [`brew install --cask f/textream/textream`](https://github.com/f/homebrew-textream) | Teleprompter that highlights scripts in real time as you speak |

### Apps

| Tool | Install | What for |
| --- | --- | --- |
| [1Password](https://1password.com/) | [`brew install --cask 1password`](https://formulae.brew.sh/cask/1password) | Password manager (sign in first) |
| [Google Chrome](https://www.google.com/chrome/) | [`brew install --cask google-chrome`](https://formulae.brew.sh/cask/google-chrome) | Browser |
| [Slack](https://slack.com/) | [`brew install --cask slack`](https://formulae.brew.sh/cask/slack) | Team chat |
| [Zoom](https://www.zoom.us/) | [`brew install --cask zoom`](https://formulae.brew.sh/cask/zoom) | Video calls |
| [Fathom](https://fathom.video/) | [`brew install --cask fathom`](https://formulae.brew.sh/cask/fathom) | Meeting recorder and notes |
| [Tailscale](https://tailscale.com/) | [`brew install --cask tailscale-app`](https://formulae.brew.sh/cask/tailscale-app) | Private network (WireGuard) |
| [Raycast](https://raycast.com/) | [`brew install --cask raycast`](https://formulae.brew.sh/cask/raycast) | Launcher (replaces Spotlight/Alfred) |
| [Microsoft Visual Studio Code](https://code.visualstudio.com/) | [`brew install --cask visual-studio-code`](https://formulae.brew.sh/cask/visual-studio-code) | Open-source code editor |
| [Figma](https://www.figma.com/) | [`brew install --cask figma`](https://formulae.brew.sh/cask/figma) | Collaborative team software |
| [Miro](https://miro.com/) | [`brew install --cask miro`](https://formulae.brew.sh/cask/miro) | Online collaborative whiteboard platform |
| [Notion](https://www.notion.com/) | [`brew install --cask notion`](https://formulae.brew.sh/cask/notion) | App to write, plan, collaborate, and get organised |
| [Notion Calendar](https://www.notion.com/product/calendar) | [`brew install --cask notion-calendar`](https://formulae.brew.sh/cask/notion-calendar) | Calendar for professionals and teams |
| [Notion Mail](https://www.notion.com/product/mail) | [`brew install --cask notion-mail`](https://formulae.brew.sh/cask/notion-mail) | Email client integrated with Notion workspace |
| [Spotify](https://www.spotify.com/) | [`brew install --cask spotify`](https://formulae.brew.sh/cask/spotify) | Music streaming service |
| [Numi](https://numi.app/) | [`brew install --cask numi`](https://formulae.brew.sh/cask/numi) | Calculator |

### Mac App Store (needs App Store sign-in; mas = CLI for it)

Needs an App Store sign-in. `brew bundle` installs them with [mas](https://github.com/mas-cli/mas).

| Tool | Install | What for |
| --- | --- | --- |
| [mas](https://github.com/mas-cli/mas) | [`brew install mas`](https://formulae.brew.sh/formula/mas) | Mac App Store command-line interface |
| [BetterSnapTool](https://apps.apple.com/app/id417375580) | [`mas install 417375580`](https://apps.apple.com/app/id417375580) | Window snapping |
| [Paste](https://apps.apple.com/app/id967805235) | [`mas install 967805235`](https://apps.apple.com/app/id967805235) | Clipboard history |
| [Folder Peek](https://apps.apple.com/app/id1615988943) | [`mas install 1615988943`](https://apps.apple.com/app/id1615988943) | Folders in the menu bar |
| [Speedtest](https://apps.apple.com/app/id1153157709) | [`mas install 1153157709`](https://apps.apple.com/app/id1153157709) | Network speed test |
| [Xcode](https://apps.apple.com/app/id497799835) | [`mas install 497799835`](https://apps.apple.com/app/id497799835) | Apple SDKs and simulators |
| [Keynote](https://apps.apple.com/app/id361285480) | [`mas install 361285480`](https://apps.apple.com/app/id361285480) | Presentations |
| [Pages](https://apps.apple.com/app/id361309726) | [`mas install 361309726`](https://apps.apple.com/app/id361309726) | Documents |
| [Numbers](https://apps.apple.com/app/id361304891) | [`mas install 361304891`](https://apps.apple.com/app/id361304891) | Spreadsheets |

### VS Code extensions

| Tool | Install | What for |
| --- | --- | --- |
| [anthropic.claude-code](https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code) | [`code --install-extension anthropic.claude-code`](https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code) | Claude Code for VS Code |
| [openai.chatgpt](https://marketplace.visualstudio.com/items?itemName=openai.chatgpt) | [`code --install-extension openai.chatgpt`](https://marketplace.visualstudio.com/items?itemName=openai.chatgpt) | Codex, OpenAI's coding agent |
| [openai.codex-audio](https://marketplace.visualstudio.com/items?itemName=openai.codex-audio) | [`code --install-extension openai.codex-audio`](https://marketplace.visualstudio.com/items?itemName=openai.codex-audio) | Codex dictation (microphone) |
| [biomejs.biome](https://marketplace.visualstudio.com/items?itemName=biomejs.biome) | [`code --install-extension biomejs.biome`](https://marketplace.visualstudio.com/items?itemName=biomejs.biome) | Biome: format and lint JS/TS |
| [bradlc.vscode-tailwindcss](https://marketplace.visualstudio.com/items?itemName=bradlc.vscode-tailwindcss) | [`code --install-extension bradlc.vscode-tailwindcss`](https://marketplace.visualstudio.com/items?itemName=bradlc.vscode-tailwindcss) | Tailwind CSS IntelliSense |
| [formulahendry.auto-rename-tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-rename-tag) | [`code --install-extension formulahendry.auto-rename-tag`](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-rename-tag) | Rename paired HTML/XML tags |
| [github.vscode-github-actions](https://marketplace.visualstudio.com/items?itemName=github.vscode-github-actions) | [`code --install-extension github.vscode-github-actions`](https://marketplace.visualstudio.com/items?itemName=github.vscode-github-actions) | GitHub Actions workflows and runs |
| [graphql.vscode-graphql](https://marketplace.visualstudio.com/items?itemName=graphql.vscode-graphql) | [`code --install-extension graphql.vscode-graphql`](https://marketplace.visualstudio.com/items?itemName=graphql.vscode-graphql) | GraphQL language support |
| [graphql.vscode-graphql-syntax](https://marketplace.visualstudio.com/items?itemName=graphql.vscode-graphql-syntax) | [`code --install-extension graphql.vscode-graphql-syntax`](https://marketplace.visualstudio.com/items?itemName=graphql.vscode-graphql-syntax) | GraphQL syntax highlighting |
| [mquandalle.graphql](https://marketplace.visualstudio.com/items?itemName=mquandalle.graphql) | [`code --install-extension mquandalle.graphql`](https://marketplace.visualstudio.com/items?itemName=mquandalle.graphql) | GraphQL syntax highlighting (legacy) |
| [prisma.prisma](https://marketplace.visualstudio.com/items?itemName=prisma.prisma) | [`code --install-extension prisma.prisma`](https://marketplace.visualstudio.com/items?itemName=prisma.prisma) | Prisma schema support |
| [redhat.vscode-yaml](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) | [`code --install-extension redhat.vscode-yaml`](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) | YAML language support |
| [ms-vscode.vscode-typescript-next](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-typescript-next) | [`code --install-extension ms-vscode.vscode-typescript-next`](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-typescript-next) | TypeScript nightly |
| [ms-azuretools.vscode-containers](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-containers) | [`code --install-extension ms-azuretools.vscode-containers`](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-containers) | Container tools |
| [ms-vscode-remote.remote-containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) | [`code --install-extension ms-vscode-remote.remote-containers`](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) | Dev Containers |
| [cweijan.vscode-postgresql-client2](https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-postgresql-client2) | [`code --install-extension cweijan.vscode-postgresql-client2`](https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-postgresql-client2) | PostgreSQL client |
| [cweijan.dbclient-jdbc](https://marketplace.visualstudio.com/items?itemName=cweijan.dbclient-jdbc) | [`code --install-extension cweijan.dbclient-jdbc`](https://marketplace.visualstudio.com/items?itemName=cweijan.dbclient-jdbc) | JDBC adapter for the database client |
| [ms-vscode.sublime-keybindings](https://marketplace.visualstudio.com/items?itemName=ms-vscode.sublime-keybindings) | [`code --install-extension ms-vscode.sublime-keybindings`](https://marketplace.visualstudio.com/items?itemName=ms-vscode.sublime-keybindings) | Sublime Text keymap |
| [vscode-icons-team.vscode-icons](https://marketplace.visualstudio.com/items?itemName=vscode-icons-team.vscode-icons) | [`code --install-extension vscode-icons-team.vscode-icons`](https://marketplace.visualstudio.com/items?itemName=vscode-icons-team.vscode-icons) | File icons |

### macOS utilities

| Tool | Install | What for |
| --- | --- | --- |
| [DockDoor](https://dockdoor.net/) | [`brew install --cask dockdoor`](https://formulae.brew.sh/cask/dockdoor) | Window previews in the Dock |
| [MonitorControl](https://github.com/MonitorControl/MonitorControl) | [`brew install --cask monitorcontrol`](https://formulae.brew.sh/cask/monitorcontrol) | External display brightness |
| [Logitech Options+](https://www.logitech.com/en-us/software/logi-options-plus.html) | [`brew install --cask logi-options+`](https://formulae.brew.sh/cask/logi-options+) | Software for Logitech devices |
| [Purge](https://purgemac.com/) | [`brew install --cask purge`](https://formulae.brew.sh/cask/purge) | Clear caches and junk files |

<!-- tools:end -->

## Contributing

This repo is public. Read [PUBLISHING.md](PUBLISHING.md) before you change anything. Agents: read [AGENTS.md](AGENTS.md).
