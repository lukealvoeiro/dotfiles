# dotfiles

Personal dotfiles for my macOS/Linux development environment, managed with
[GNU Stow](https://www.gnu.org/software/stow/). Stow symlinks the tracked files
into `$HOME`, so editing a file here updates the live config in place.

## Bootstrap

```sh
git clone https://github.com/lukealvoeiro/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Symlink everything into $HOME (idempotent; safe to re-run)
./scripts/setup.sh

# Or, to also install Homebrew packages from brew.txt:
./scripts/setup.sh --brew
```

`setup.sh` runs `stow --restow .`, which symlinks every tracked file into `$HOME`
except the paths listed in [`.stow-local-ignore`](.stow-local-ignore)
(`scripts/`, `shell/`, `brew.txt`, `profile.jpg`, `README.md`, `*.example`).

## Layout

| Path | What it is |
| --- | --- |
| `.zshrc` | Zsh entrypoint; loads plugins then sources the fragments below |
| `.config/zsh/` | Modular zsh config: `env.zsh`, `aliases.zsh`, `functions.zsh`, `completions.zsh` |
| `.p10k.zsh` | Powerlevel10k prompt configuration |
| `.config/nvim/` | Neovim setup (LazyVim based) — see its own [README](.config/nvim/README.md) |
| `.config/` | Other app configs: ghostty, wezterm, zed, lazygit, neovide, gh, graphite |
| `.tmux.conf`, `.wezterm.lua` | tmux + WezTerm config |
| `.gitconfig` | Git aliases and settings |
| `brew.txt` | Homebrew package list (install via `setup.sh --brew`) |
| `scripts/` | Helper scripts (not symlinked into `$HOME`) |
| `shell/` | Standalone shell snippets (e.g. `nvm-init.sh`), not symlinked |
| `profile.jpg` | Profile picture for any avatar needs |

### Helper scripts (`scripts/`)

- `setup.sh` — stow the dotfiles into `$HOME` (`--brew` also installs `brew.txt`).
- `backup.sh` — refresh `brew.txt` from currently installed Homebrew leaves.
- `git-status-all.sh` (`gsa`) — show branch + short status across local repos.
- `find-session.sh` (`find-session`) — locate a session JSONL by id.

## Local and secret configuration

Two files are sourced by `.zshrc` if present and are **git-ignored**:

- `~/dotfiles/.zshrc.secrets` — API keys / tokens. Copy from
  [`.zshrc.secrets.example`](.zshrc.secrets.example).
- `~/.zshrc.local` — machine- and work-specific aliases, functions, and env
  (e.g. `AWS_PROFILE`, work CLIs, repo shortcuts). Copy from
  [`.zshrc.local.example`](.zshrc.local.example).

Keeping these out of the committed config keeps `.zshrc` portable across
machines.
