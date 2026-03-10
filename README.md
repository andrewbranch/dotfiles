# dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

## Quick start

### macOS / Linux

```sh
# Install chezmoi and apply dotfiles in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply andrewbranch
```

Or if chezmoi is already installed:

```sh
chezmoi init --apply andrewbranch
```

On first run, you'll be prompted for your email and GPG key.

### Windows (PowerShell)

```powershell
# Install chezmoi
winget install twpayne.chezmoi
# -- or --
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.chezmoi.io/ps1 | iex

# Apply dotfiles
chezmoi init --apply andrewbranch
```

## Setup

After applying the dotfiles, run the setup script to install tools that chezmoi
doesn't manage (Starship prompt, Nerd Fonts, etc.):

```sh
./setup.sh
```

Then set your terminal font to **MesloLGS Nerd Font** for prompt glyphs.

## What's managed

| File | Platforms | Notes |
|------|-----------|-------|
| `.profile` | macOS, Linux | Shell environment, PATH, aliases |
| `.zshrc` | macOS, Linux | Zsh config, history, completions |
| `.bashrc` | macOS, Linux | Bash completions, prompt |
| `.bash_profile` | macOS, Linux | Sources bashrc + profile |
| `.inputrc` | macOS, Linux | Readline key bindings |
| `.gitconfig` | All | Templated for OS-specific credential helpers |
| `.config/nvim/` | macOS, Linux | Neovim config with lazy.nvim |
| `.config/starship.toml` | All | Cross-platform prompt theme |
| `Documents/PowerShell/Microsoft.PowerShell_profile.ps1` | Windows only | PowerShell profile |

## Day-to-day usage

```sh
chezmoi edit ~/.zshrc     # Edit the source, not the target
chezmoi apply             # Apply changes to home directory
chezmoi diff              # Preview what would change
chezmoi cd                # cd into the source directory
chezmoi update            # Pull latest from git and apply
```

## Extras (not chezmoi-managed)

The `extras/` directory contains reference files synced via git but not
automatically placed by chezmoi:

- **iTerm2 preferences** — Use iTerm2's _Settings → General → Preferences →
  Load preferences from a custom folder_ and point it at `extras/iTerm/`
- **Keychron keyboard layout** — Import via VIA or the Keychron launcher app
