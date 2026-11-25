# Pi coding agent shortcuts

# Sessions
alias pic='pi --continue'      # continue the most recent Pi session; accepts an optional prompt
alias pir='pi --resume'        # open the Pi session picker
alias pif='pi --fork'          # fork a previous session by path/id
alias pin='pi --name'          # start a named session: pin "My session"

# Common Pi commands
alias pih='pi --help'          # show Pi help
alias pil='pi list'            # list installed Pi packages
alias pii='pi install'         # install a Pi package
alias piu='pi update --all'    # update Pi + installed packages + model catalogs
alias picfg='pi config'        # open Pi config TUI
alias pim='pi --list-models'   # list available models; accepts optional search text

# One-shot/non-interactive helpers
alias piq='pi --print'         # quick one-shot prompt, e.g. piq "summarize this repo"
alias pio='pi --offline'       # start Pi without startup network operations
alias pia='pi --approve'       # trust project-local Pi files for this run
alias pina='pi --no-approve'   # ignore project-local Pi files for this run

# Useful model/thinking presets
alias pihigh='pi --thinking high'
alias pixhigh='pi --thinking xhigh'
alias picodex='pi --provider openai-codex'
alias piclaude='pi --provider anthropic'
alias pideepseek='pi --model openrouter/deepseek/deepseek-v3.2'
