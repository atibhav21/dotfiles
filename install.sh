#!/usr/bin/env bash
set -euo pipefail

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

# Install plugins (idempotent)
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Enable plugins in ~/.zshrc (append if missing; keep highlighting last)
if ! grep -q "zsh-autosuggestions" "$HOME/.zshrc"; then
  # add autosuggestions
  sed -i 's/^plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions)/' "$HOME/.zshrc"
fi

if ! grep -q "zsh-syntax-highlighting" "$HOME/.zshrc"; then
  # add syntax-highlighting LAST
  sed -i 's/^plugins=(\(.*\))/plugins=(\1 zsh-syntax-highlighting)/' "$HOME/.zshrc"
fi

# Ensure Ona secrets sourcing exists (safety)
if ! grep -q "ona-secrets.sh" "$HOME/.zshrc"; then
  echo ". /etc/profile.d/ona-secrets.sh" >> "$HOME/.zshrc"
fi

echo "Installed + enabled. Reloading..."
source "$HOME/.zshrc" || true