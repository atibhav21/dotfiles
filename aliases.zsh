# Git and general aliases (Ona/Gitpod dotfiles)
alias grpo='git remote prune origin'

# gcam + push
gcamp() { git commit -a -m "$*" && git push; }

# gcam + force push
gcamf() { git commit -a -m "$*" && git push --force; }

