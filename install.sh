#!/bin/bash
# MacHunter - Dev + Pentest Mac bootstrap script
# Author: GreatBam
# Description: Sets up essential CLI/GUI tools, zsh config, and aliases

echo "Starting MacHunter setup..."

if ! command -v git &>/dev/null; then
  echo "Git not found — no worries, will be installed shortly."
fi

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed."
fi

brew analytics off

echo "Homebrew telemetry disabled."

brew update && brew upgrade

echo "Brew updated successfully."

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
  lolcat

echo "Core tools installed."

if [[ "$SHELL" != "$(which zsh)" ]]; then
  chsh -s "$(which zsh)"
  echo "Zsh set as default shell."
fi

brew install --cask docker vscodium postman

echo "GUI tools installed."

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

source ~/.zshrc

echo "~/.zshrc file loaded."

echo "MacHunter installation fully terminated, happy hacking :) !"
