#!/usr/bin/env bash
# setup.sh — Install tools that chezmoi doesn't manage.
# Run once on a fresh machine after `chezmoi init --apply`.

set -euo pipefail

# ============================================================
# Package lists — add new programs here
# ============================================================

BREW_FORMULAE=(
  bash-completion
  ffmpeg
  git-delta
  git-lfs
  gnupg
  go
  highlight
  neovim
  pnpm
  starship
  volta
  zsh-history-substring-search
)

BREW_FORMULAE_MACOS=(
  gnu-tar
)

BREW_CASKS=(
  font-meslo-lg-nerd-font
)

# Mapping: apt package names for the formulae above (where available).
# Tools without an apt equivalent are handled separately below.
APT_PACKAGES=(
  bash-completion
  ffmpeg
  git-lfs
  gnupg
  golang
  highlight
  neovim
  zsh-history-substring-search
)

# ============================================================
# Helpers
# ============================================================

info()  { printf '\033[1;34m==> %s\033[0m\n' "$*"; }
warn()  { printf '\033[1;33mWARN: %s\033[0m\n' "$*"; }
error() { printf '\033[1;31mERROR: %s\033[0m\n' "$*" >&2; }

install_brew_formulae() {
  local to_install=()
  for f in "$@"; do
    if ! brew list --formula "$f" &>/dev/null; then
      to_install+=("$f")
    fi
  done
  if (( ${#to_install[@]} )); then
    info "brew install ${to_install[*]}"
    brew install "${to_install[@]}"
  else
    info "All Homebrew formulae already installed"
  fi
}

install_brew_casks() {
  local to_install=()
  for c in "$@"; do
    if ! brew list --cask "$c" &>/dev/null; then
      to_install+=("$c")
    fi
  done
  if (( ${#to_install[@]} )); then
    info "brew install --cask ${to_install[*]}"
    brew install --cask "${to_install[@]}"
  else
    info "All Homebrew casks already installed"
  fi
}

install_apt_packages() {
  local to_install=()
  for p in "$@"; do
    if ! dpkg -s "$p" &>/dev/null 2>&1; then
      to_install+=("$p")
    fi
  done
  if (( ${#to_install[@]} )); then
    info "apt install ${to_install[*]}"
    sudo apt update -qq
    sudo apt install -y "${to_install[@]}"
  else
    info "All apt packages already installed"
  fi
}

# ============================================================
# Post-install / special setup
# Only tools that need steps beyond a package install go here.
# ============================================================

setup_git_lfs() {
  if git lfs env &>/dev/null; then
    info "Git LFS already configured"
    return
  fi
  info "Configuring Git LFS…"
  git lfs install
}

setup_rustup() {
  if command -v rustup &>/dev/null; then
    info "Rustup already installed"
    return
  fi
  info "Installing Rustup…"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
}

setup_bun() {
  if command -v bun &>/dev/null; then
    info "Bun already installed"
    return
  fi
  info "Installing Bun…"
  curl -fsSL https://bun.sh/install | bash
}

# Linux-only: install tools that aren't in apt repos
setup_linux_extras() {
  if ! command -v starship &>/dev/null; then
    info "Installing Starship…"
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
  fi

  if ! command -v delta &>/dev/null; then
    warn "git-delta is not in apt — install manually: https://github.com/dandavison/delta/releases"
  fi

  if ! command -v volta &>/dev/null; then
    info "Installing Volta…"
    curl https://get.volta.sh | bash -s -- --skip-setup
  fi

  if ! command -v pnpm &>/dev/null; then
    info "Installing pnpm…"
    curl -fsSL https://get.pnpm.io/install.sh | sh -
  fi

  # Nerd Font
  local font_dir="$HOME/.local/share/fonts"
  if ! ls "$font_dir"/MesloLGSNerdFont* &>/dev/null 2>&1; then
    info "Installing MesloLGS Nerd Font…"
    mkdir -p "$font_dir"
    local tmp
    tmp="$(mktemp -d)"
    curl -fsSL -o "$tmp/Meslo.tar.xz" \
      "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.tar.xz"
    tar -xf "$tmp/Meslo.tar.xz" -C "$font_dir"
    rm -rf "$tmp"
    command -v fc-cache &>/dev/null && fc-cache -f "$font_dir"
  fi
}

# ============================================================
# Main
# ============================================================

main() {
  info "Setting up dotfiles dependencies…"

  if [[ "$OSTYPE" == darwin* ]]; then
    if ! command -v brew &>/dev/null; then
      error "Homebrew not found — install it first: https://brew.sh"
      exit 1
    fi
    install_brew_formulae "${BREW_FORMULAE[@]}" "${BREW_FORMULAE_MACOS[@]}"
    install_brew_casks "${BREW_CASKS[@]}"
  else
    install_apt_packages "${APT_PACKAGES[@]}"
    setup_linux_extras
  fi

  setup_git_lfs
  setup_rustup
  setup_bun

  info "Done! Set your terminal font to \"MesloLGS Nerd Font\" for prompt glyphs."
}

main "$@"
