#!/bin/bash
# MacHunter - Dev + Pentest Mac bootstrap script
# Author: GreatBam
# Description: Sets up essential CLI/GUI tools, zsh config, and aliases

echo "Starting MacHunter setup..."

# Check if git is already installed
if ! command -v git &>/dev/null; then
  echo "Git not found — no worries, will be installed shortly."
fi

# Check if brew is already installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed."
fi

# Remove Homebrew telemetry
brew analytics off
echo "Homebrew telemetry disabled."

# Update Homebrew 
brew update && brew upgrade
echo "Brew updated successfully."

# Use brew to install core tools
brew install \
  zsh \
  git \
  tmux \
  htop \
  wget \
  curl \
  openssh \
  bat \
  fzf \
  tree \
  python \
  docker \
  docker-compose \
  nmap \
  aircrack-ng \
  hashcat \
  masscan \
  whois \
  netcat \
  go \
  starship \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  figlet \
  lolcat || true
echo "Core tools installed."

# Switch terminal if zsh is not already the default one
if [[ "$SHELL" != "$(which zsh)" ]]; then
  chsh -s "$(which zsh)"
  echo "Zsh set as default shell."
fi

# Install NVM and Node.js LTS
echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Installing latest Node.js LTS version..."
nvm install --lts

# Use brew to install GUI tools
brew install --cask vscodium bruno
echo "GUI tools installed."

# Update .zshrc file if not already done
if ! grep -q "# MacHunter Setup ↓↓↓↓↓↓" ~/.zshrc; then
  cat <<'EOF' >> ~/.zshrc
# MacHunter Setup ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

# Starship prompt
eval "$(starship init zsh)"

# Zsh plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Banner
figlet "MacHunter" | lolcat

# Aliases
alias quickscan="nmap -T4 -F"
alias fullscan="nmap -A -T4"
alias livehosts="nmap -sn 192.168.1.0/24"

# MacHunter Setup ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
EOF
  echo "~/.zshrc file updated."
else
  echo "~/.zshrc already contains MacHunter config — skipped."
fi

# Reload zsh terminal
source ~/.zshrc || true
echo "~/.zshrc file loaded."

echo "MacHunter installation fully terminated, happy hacking :) !"
