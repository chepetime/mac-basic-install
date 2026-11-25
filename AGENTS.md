# AGENTS.md

Guidance for coding agents (Claude Code, Codex, and others) that work in this repo.

## What this repo is

A public, minimal setup for a new Mac: a Homebrew `Brewfile`, a few config files, and an install script. It documents the tools. It is not a full dotfiles dump.

## Layout

| Path                         | Purpose                                                    |
| ---------------------------- | ---------------------------------------------------------- |
| `README.md`                  | Install steps and the tool list. Source of truth for docs. |
| `Brewfile`                   | Every app and CLI tool, grouped with comments.             |
| `install.sh`                 | Idempotent bootstrap: CLT, Homebrew, clone, `brew bundle`, symlinks, mise, defaults. Runs from a clone or from `curl`. |
| `macos/defaults.sh`          | macOS settings with `defaults write`. No `sudo`.           |
| `home/`                      | Files that mirror `~`. `install.sh` symlinks them into place. |
| `home/.config/zsh/`          | zsh modules: completion, history, key bindings, `aliases/*.zsh`. |
| `home/.config/git/`          | Shared git config and global ignore. Identity stays in `~/.gitconfig`, outside the repo. |
| `PUBLISHING.md`              | Rules for what may be committed. Read it before any change. |
| `.githooks/pre-commit`       | Runs `gitleaks` on staged changes.                         |
| `.github/workflows/`         | CI: secret scan (`gitleaks.yml`) and lint (`lint.yml`).    |

## Rules

1. **Follow `PUBLISHING.md`.** This repo is public. Never add secrets, personal data, work names, internal URLs, or work paths. If you are not sure that content is safe, do not add it; ask.
2. **Shell files must be generic.** zsh modules live in `home/.config/zsh/`. Each file must work on any Mac: no work aliases, no hard-coded locations, people, hosts, or paths. Read machine-specific values from env vars that the user sets in `~/.zshrc.local`, and document them in `README.md`. Install zsh plugins with Homebrew, not git submodules.
3. **Homebrew first, one method per tool.** Install tools through the `Brewfile`: `brew`, `cask`, `mas` for App Store apps, `vscode` for extensions. Do not add a second installer (`curl | sh`, npm global, self-update commands) for a tool that Homebrew already manages. Node and pnpm are the exception: mise manages them. Use another method only when no formula or cask exists, and document it in `README.md`.
4. **Keep docs and Brewfile in sync.** When you add or remove a tool in `Brewfile`, update the tool table in `README.md` in the same change.
5. **Check names.** Confirm each new entry with `brew info <name>` or `brew info --cask <name>` before you add it.
6. **Keep `install.sh` idempotent.** Running it twice must be safe. Back up existing files; never delete them.
7. **macOS settings mirror a real Mac.** Add a `defaults write` only for a setting that is in use, with a short comment. No `sudo`.

## Checks before you commit

```sh
brew bundle check --file=Brewfile   # Brewfile parses
shellcheck install.sh macos/defaults.sh .githooks/pre-commit
for f in home/.zshrc home/.zprofile home/.config/zsh/**/*.zsh; do zsh -n "$f"; done
gitleaks git --no-banner            # no secrets
actionlint && zizmor .github/       # only if workflows changed
```
