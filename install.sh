#!/usr/bin/env bash
set -euo pipefail

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

echo "Installing zsh plugins..."

# Install autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Install syntax highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Enable plugins in .zshrc
if ! grep -q "zsh-autosuggestions" "$HOME/.zshrc"; then
  sed -i 's/^plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions)/' "$HOME/.zshrc"
fi

if ! grep -q "zsh-syntax-highlighting" "$HOME/.zshrc"; then
  sed -i 's/^plugins=(\(.*\))/plugins=(\1 zsh-syntax-highlighting)/' "$HOME/.zshrc"
fi

# Ensure syntax highlighting is last (important)
sed -i 's/zsh-syntax-highlighting//g' "$HOME/.zshrc"
sed -i 's/^plugins=(\(.*\))/plugins=(\1 zsh-syntax-highlighting)/' "$HOME/.zshrc"

# Ensure Ona secrets sourcing exists
if ! grep -q "ona-secrets.sh" "$HOME/.zshrc"; then
  echo ". /etc/profile.d/ona-secrets.sh" >> "$HOME/.zshrc"
fi

# Make new terminals use zsh instead of bash
if ! grep -q "Auto-switch to zsh" "$HOME/.bashrc" 2>/dev/null; then
  cat >> "$HOME/.bashrc" <<'BEOF'

# Auto-switch to zsh (Ona/Gitpod)
if [[ $- == *i* ]] && command -v zsh >/dev/null 2>&1; then
  exec zsh
fi
BEOF
fi

echo "Done."