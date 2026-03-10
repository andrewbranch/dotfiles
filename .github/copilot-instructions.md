# Copilot Instructions

## Architecture

This is a **chezmoi**-managed dotfiles repository. Chezmoi reads source files from the `home/` directory (configured via `.chezmoi.toml.tmpl`'s `sourceDir`) and applies them to the user's home directory. `setup.sh` handles tool installation outside chezmoi's scope.

Key chezmoi conventions used here:

- **Templates** (`.tmpl` suffix): Files using Go `text/template` syntax, rendered with data from `.chezmoi.toml.tmpl` (currently `email`, `gpgKey`, and `.chezmoi.os`).
- **Naming prefixes**: `dot_` → `.`, `private_dot_` → `.` with restricted permissions. These are chezmoi conventions, not custom to this repo.
- **`.chezmoiignore`**: Controls which files are skipped per OS (e.g., `Documents/` ignored on non-Windows, `karabiner` ignored on non-macOS).

## File conventions

- **Shell config layering**: `.profile` holds shared env/aliases/PATH (sourced by both `.zshrc` and `.bashrc`). Shell-specific config stays in the respective rc file.
- **OS-specific blocks**: Use `{{ if eq .chezmoi.os "darwin" }}` / `"linux"` / `"windows"` guards in templates. Keep platform-specific code inside these guards rather than creating separate files per OS.
- **`extras/`**: Contains files managed by git but _not_ by chezmoi (iTerm2 prefs, keyboard layouts). These are referenced manually by users, not auto-deployed.

## Editing guidelines

- Always edit the chezmoi source files under `home/`, never the deployed files in `~`.
- When adding new dotfiles, follow chezmoi naming: `home/dot_foo` for `~/.foo`, `home/dot_foo.tmpl` if it needs template rendering.
- Test templates with `chezmoi execute-template < file.tmpl` before applying.
- Run `chezmoi diff` to preview changes and `chezmoi apply` to deploy.

## Setup script

`setup.sh` is idempotent—it skips already-installed tools. When adding new tools:

- Add Homebrew formulae to `BREW_FORMULAE` (or `BREW_FORMULAE_MACOS` / `BREW_CASKS`).
- Add apt equivalents to `APT_PACKAGES`.
- If a tool needs special install steps on Linux, add a function in the "Post-install / special setup" section and call it from `main()`.

## Style

- Shell scripts use `set -euo pipefail`, 2-space indentation, and the `info`/`warn`/`error` helper functions for output.
- Neovim config uses 2-space indentation in Lua.
