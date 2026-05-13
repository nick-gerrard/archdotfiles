#!/usr/bin/env bash
# =============================================================================
# bootstrap.sh — macOS dev environment setup
# Usage: bash bootstrap.sh
# =============================================================================

set -euo pipefail

DOTFILES_REPO="https://github.com/nick-gerrard/archdotfiles"
DOTFILES_DIR="$HOME/dotfiles"

# Mac-compatible stow packages (skip Linux-only: hypr, waybar, rofi, dunst, Thunar)
STOW_PACKAGES=(nvim kitty tmux zsh btop fastfetch)

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------
info()    { echo "$(tput setaf 4)[INFO]$(tput sgr0) $*"; }
success() { echo "$(tput setaf 2)[OK]$(tput sgr0) $*"; }
warn()    { echo "$(tput setaf 3)[WARN]$(tput sgr0) $*"; }
abort()   { echo "$(tput setaf 1)[ERROR]$(tput sgr0) $*" >&2; exit 1; }

# -----------------------------------------------------------------------------
# 1. Xcode Command Line Tools
# -----------------------------------------------------------------------------
info "Checking Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  # Wait for installation to complete
  until xcode-select -p &>/dev/null; do sleep 5; done
  success "Xcode CLT installed."
else
  success "Xcode CLT already installed."
fi

# -----------------------------------------------------------------------------
# 2. Homebrew
# -----------------------------------------------------------------------------
info "Checking Homebrew..."
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for Apple Silicon (adjust if Intel)
  eval "$(/opt/homebrew/bin/brew shellenv)"
  success "Homebrew installed."
else
  success "Homebrew already installed."
fi

info "Updating Homebrew..."
brew update

# -----------------------------------------------------------------------------
# 3. Brewfile — install everything
# -----------------------------------------------------------------------------
info "Installing packages from Brewfile..."

brew bundle  --file=/dev/stdin <<'BREWFILE'

# ── Taps ─────────────────────────────────────────────────────────────────────
tap "nikitabobko/tap"          # Aerospace WM
tap "homebrew/cask-fonts"      # Nerd Fonts

# ── Shell & terminal ─────────────────────────────────────────────────────────
brew "zsh"
brew "stow"
brew "starship"                # p10k alternative — fast, zero-config to start

# ── CLI essentials ───────────────────────────────────────────────────────────
brew "git"
brew "gh"
brew "curl"
brew "wget"
brew "jq"
brew "yq"
brew "htop"
brew "btop"
brew "fastfetch"
brew "tmux"

# ── Modern CLI replacements ───────────────────────────────────────────────────
brew "ripgrep"                 # rg — better grep
brew "fzf"                     # fuzzy finder
brew "bat"                     # better cat
brew "eza"                     # better ls
brew "fd"                      # better find
brew "zoxide"                  # better cd
brew "delta"                   # better git diff
brew "tldr"                    # better man pages

# ── Editor ───────────────────────────────────────────────────────────────────
brew "neovim"

# ── Python ───────────────────────────────────────────────────────────────────
brew "uv"                      # uv handles Python installs + venvs
brew "ruff"

# ── Node ─────────────────────────────────────────────────────────────────────
brew "node"
brew "pnpm"

# ── Go ───────────────────────────────────────────────────────────────────────
brew "go"

# ── C ────────────────────────────────────────────────────────────────────────
brew "gcc"
brew "cmake"
brew "make"

# ── Docker (CLI only) ────────────────────────────────────────────────────────
brew "docker"
brew "docker-compose"
brew "lazydocker"              # TUI for docker

# ── PostgreSQL ───────────────────────────────────────────────────────────────
brew "postgresql@17"
brew "pgcli"

# ── Infra / DevOps ───────────────────────────────────────────────────────────
brew "httpie"
brew "ngrok"

# ── Fonts ────────────────────────────────────────────────────────────────────
cask "font-jetbrains-mono-nerd-font"
cask "font-fira-code-nerd-font"
cask "font-meslo-lg-nerd-font"

# ── Terminal ─────────────────────────────────────────────────────────────────
cask "kitty"

# ── Window management ────────────────────────────────────────────────────────
cask "nikitabobko/tap/aerospace"
cask "raycast"                 # Rofi replacement — launcher, clipboard, more
cask "sketchybar"              # Waybar replacement — scriptable status bar

# ── Browsers ─────────────────────────────────────────────────────────────────
cask "google-chrome"
cask "firefox"

# ── Communication ────────────────────────────────────────────────────────────
cask "discord"
cask "signal"

# ── Dev GUI tools ────────────────────────────────────────────────────────────
cask "tableplus"               # Postgres GUI (great free tier)

# ── Gaming ───────────────────────────────────────────────────────────────────
cask "steam"

# ── System utilities ─────────────────────────────────────────────────────────
cask "stats"                   # Menu bar system monitor (Waybar widget equiv)
cask "the-unarchiver"
cask "ollama"

BREWFILE

success "Brewfile done."

# -----------------------------------------------------------------------------
# 4. Oh My Zsh
# -----------------------------------------------------------------------------
info "Checking Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  success "Oh My Zsh installed."
else
  success "Oh My Zsh already installed."
fi

# ── zsh plugins ──────────────────────────────────────────────────────────────
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

install_zsh_plugin() {
  local name="$1" repo="$2"
  local dest="$ZSH_CUSTOM/plugins/$name"
  if [ ! -d "$dest" ]; then
    info "Installing zsh plugin: $name"
    git clone --depth=1 "$repo" "$dest"
  else
    success "zsh plugin already installed: $name"
  fi
}

install_zsh_plugin "zsh-autosuggestions" \
  "https://github.com/zsh-users/zsh-autosuggestions"
install_zsh_plugin "zsh-syntax-highlighting" \
  "https://github.com/zsh-users/zsh-syntax-highlighting"
install_zsh_plugin "zsh-completions" \
  "https://github.com/zsh-users/zsh-completions"

# ── Powerlevel10k ─────────────────────────────────────────────────────────────
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
  info "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
  success "Powerlevel10k installed."
else
  success "Powerlevel10k already installed."
fi

# -----------------------------------------------------------------------------
# 5. Dotfiles
# -----------------------------------------------------------------------------
info "Cloning dotfiles..."
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
  success "Dotfiles cloned to $DOTFILES_DIR."
else
  warn "Dotfiles directory already exists at $DOTFILES_DIR — pulling latest."
  git -C "$DOTFILES_DIR" pull
fi

info "Stowing dotfiles (Mac-compatible packages only)..."
cd "$DOTFILES_DIR"
for pkg in "${STOW_PACKAGES[@]}"; do
  if [ -d "$pkg" ]; then
    stow --restow --target="$HOME" "$pkg"
    success "Stowed: $pkg"
  else
    warn "Package not found, skipping: $pkg"
  fi
done

# -----------------------------------------------------------------------------
# 6. Python — install a default version via uv
# -----------------------------------------------------------------------------
info "Setting up Python via uv..."
if ! uv python list 2>/dev/null | grep -q "3.12"; then
  uv python install 3.12
  success "Python 3.12 installed via uv."
else
  success "Python 3.12 already available."
fi

# -----------------------------------------------------------------------------
# 7. Node — set up pnpm global store
# -----------------------------------------------------------------------------
info "Configuring pnpm..."
pnpm setup 2>/dev/null || true

# Global JS tools useful for Next/Svelte/React work
info "Installing global Node packages..."
pnpm add -g \
  typescript \
  ts-node \
  @sveltejs/cli \
  create-next-app \
  prettier \
  eslint

# -----------------------------------------------------------------------------
# 8. fzf shell integration
# -----------------------------------------------------------------------------
info "Setting up fzf shell integration..."
"$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish 2>/dev/null || true

# -----------------------------------------------------------------------------
# 9. macOS system defaults
# -----------------------------------------------------------------------------
info "Applying macOS system defaults..."

# Keyboard — fast key repeat (essential for Neovim)
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 14

# Disable press-and-hold accent menu (enables key repeat in all apps)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar and status bar in Finder
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable .DS_Store on network/USB
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Dock — autohide, remove delay, only show open apps
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock static-only -bool true   # only open apps in dock

# Screenshots — save to ~/Pictures/Screenshots
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# Disable autocorrect / smart quotes (ruins code)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Trackpad — tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Restart affected services
for app in "Finder" "Dock" "SystemUIServer"; do
  killall "$app" &>/dev/null || true
done

success "macOS defaults applied."

# -----------------------------------------------------------------------------
# 10. The "yay" equivalent — brew-update alias
# -----------------------------------------------------------------------------
info "Adding 'update' alias to shell..."
UPDATE_ALIAS='alias update="brew update && brew upgrade && brew cleanup && brew doctor"'

# Append only if not already present
ZSHRC="$HOME/.zshrc"
if ! grep -qF 'alias update=' "$ZSHRC" 2>/dev/null; then
  echo "" >> "$ZSHRC"
  echo "# Update everything (brew)" >> "$ZSHRC"
  echo "$UPDATE_ALIAS" >> "$ZSHRC"
  success "Added 'update' alias to .zshrc"
else
  warn "'update' alias already in .zshrc"
fi

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo ""
echo "$(tput setaf 2)╔═══════════════════════════════════════════╗"
echo "║        Bootstrap complete!                ║"
echo "║                                           ║"
echo "║  Restart your terminal, then:             ║"
echo "║   • p10k configure  (first-time setup)    ║"
echo "║   • aerospace       (start tiling WM)     ║"
echo "║   • update          (your new 'yay')      ║"
echo "╚═══════════════════════════════════════════╝$(tput sgr0)"
echo ""
warn "Manual steps remaining:"
warn "  1. Sign into Chrome, Firefox (extensions: uBlock Origin, LastPass)"
warn "  2. Configure Aerospace: ~/.config/aerospace/aerospace.toml"
warn "  3. Configure Sketchybar: brew services start sketchybar"
warn "  4. Open Raycast and set it as your Spotlight replacement (⌘Space)"
warn "  5. WhatsApp — install manually from whatsapp.com (no cask available)"
warn "  6. Docker daemon: requires Docker Desktop or colima ('brew install colima')"
