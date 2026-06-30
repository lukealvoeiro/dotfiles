# dotfiles

Personal dotfiles for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).
The repo lives at `~/dotfiles` and `setup.sh` symlinks each tracked file into `$HOME`.

## What's inside

| Area | Files |
| --- | --- |
| Shell | `.zshrc`, `.p10k.zsh` (Zsh + [Zap](https://github.com/zap-zsh/zap) plugins + Powerlevel10k) |
| Terminals | `.tmux.conf`, `.wezterm.lua`, `.config/ghostty` |
| Editor | `.config/nvim` (LazyVim), `.config/zed` |
| Git | `.gitconfig`, `.config/git`, `.config/lazygit`, `.config/graphite` |
| Packages | `brew.txt` (Homebrew leaves) |

## Setup

```bash
git clone https://github.com/lukealvoeiro/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Symlink the dotfiles into $HOME (requires `stow`: brew install stow)
./setup.sh

# Or symlink AND install the Homebrew packages from brew.txt
./setup.sh --brew
```

`setup.sh` runs `stow --restow`, so it is safe to re-run after pulling changes.
Files listed in `.stow-local-ignore` (this README, helper scripts, `brew.txt`,
etc.) are intentionally not symlinked.

## Secrets

Secrets are kept out of git. Copy the example and fill in real values:

```bash
cp .zshrc.secrets.example .zshrc.secrets
$EDITOR .zshrc.secrets
```

`.zshrc` sources `.zshrc.secrets` automatically if it exists.

## Updating the package list

After installing/removing Homebrew packages, regenerate `brew.txt`:

```bash
./backup.sh
```

## Helper scripts

- `git-status-all.sh` (`gsa`) — branch + short status across local repos.
- `find-session.sh` (`find-session`) — locate a session JSONL by id.
