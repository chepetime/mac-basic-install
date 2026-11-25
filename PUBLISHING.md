# Publishing rules

This repo is public. Everything in it, including git history, is visible to everyone and can be cached or indexed. Deleting a file later does not remove it from history or from caches.

## 1. Never commit private or work content

Do not commit:

- Secrets: API tokens, passwords, private keys, `.env` files, cookies, session files.
- Personal data: email addresses, phone numbers, home paths with real names, hostnames.
- Work content: employer names, internal project names, internal URLs or hostnames, work repos and paths, ticket systems, work-only aliases, scripts, or agent skills.
- Machine identity: SSH config, `known_hosts`, git `includeIf` paths, signing keys.

Put these in files that git ignores:

| What                         | Where                                 |
| ---------------------------- | ------------------------------------- |
| Shell aliases, env, functions | `~/.zshrc.local`                     |
| Git identity per directory   | `~/.gitconfig` (not in this repo)     |
| Secrets                      | macOS Keychain or 1Password — read at runtime, never written to a file |

## 2. Copy files, not history

To bring a file from a private repo into this one, copy the current file and review it. Do not merge, cherry-pick, or push the private repo's history. Old commits can hold content that the current file does not show.

## 3. Scan before every commit

- The pre-commit hook in `.githooks/pre-commit` runs `gitleaks` on staged changes. Enable it once per clone:

  ```sh
  git config core.hooksPath .githooks
  ```

- The `Secret scan` GitHub Actions workflow scans the full history on every push and pull request.
- Lint workflow changes with `actionlint` and `zizmor` before you push them.

## 4. Review every diff by eye

The scanner finds secrets. It does not find work names or personal data. Before each commit, read `git diff --staged` and check it against rule 1.

## 5. If something leaks

1. Rotate the secret at once. A secret that was pushed is compromised, even after you remove it.
2. Remove it from history (`git filter-repo`) and force-push.
3. Ask GitHub Support to purge cached views if needed.
