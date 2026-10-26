# dotfiles

My [Omarchy](https://omarchy.org) (Arch + Hyprland) dotfiles, managed with [chezmoi](https://www.chezmoi.io).

> The old Fedora config lives on the [`fedora-old`](../../tree/fedora-old) branch.

## What's inside

| Area | Paths |
|---|---|
| Shell | `~/.bashrc`, `~/.bash_profile`, `~/.profile`, `~/.XCompose` |
| Hyprland | `~/.config/hypr/` (my overrides on top of Omarchy defaults) |
| Omarchy | `~/.config/omarchy/shell.json`, `shell.toml`, `hooks/` |
| Theme | `~/.config/omarchy/themes/last/` (colors + wallpaper), `~/.config/aether/` |
| Editor | `~/.config/nvim/` (LazyVim) |
| Terminals | `~/.config/ghostty/`, `alacritty/`, `kitty/`, `tmux/` |
| Tools | `~/.config/git/`, `starship.toml`, `btop/`, `lazygit/` |
| Dev tools | `~/.config/mise/config.toml` (chezmoi, claude, codex, gh, node, opencode) |
| Zed | `~/.config/zed/settings.json`, `themes/` |
| Audio | `~/.config/wireplumber/wireplumber.conf.d/` (Bluetooth A2DP auto-connect, KEF LSX II LT no-suspend) |
| Desktop | `~/.config/mimeapps.list` (default apps), `~/.config/gtk-3.0/bookmarks` (Nautilus sidebar) |
| Spotify | `~/.config/spicetify/` (`text` theme + marketplace) |

## Restore on a new machine

1. Install Omarchy and finish its first-run setup.
2. Install chezmoi:
   ```bash
   sudo pacman -S chezmoi
   ```
3. Clone the repo **without applying**, then preview what would change:
   ```bash
   chezmoi init https://github.com/nahtanpng/dotfiles.git
   chezmoi diff
   ```
4. Apply:
   ```bash
   chezmoi apply -v
   ```
   (Steps 3 and 4 in one go: `chezmoi init --apply nahtanpng/dotfiles`.)
5. Activate the theme and reload things:
   ```bash
   omarchy-theme-set last
   hyprctl reload
   ```
6. Spicetify (needs Spotify and spicetify installed):
   ```bash
   yay -S spicetify-cli
   spicetify backup apply
   ```
   If it fails with a permission error on `/opt/spotify`, run
   `sudo chmod a+wr /opt/spotify /opt/spotify/Apps -R` and try again.
7. Install dev tools from the mise config:
   ```bash
   mise install
   ```
8. Restart audio so the WirePlumber rules load:
   ```bash
   systemctl --user restart wireplumber
   ```
9. Open `nvim` once so LazyVim installs the plugins from `lazy-lock.json`.

## Back up changes

After editing any tracked config:

```bash
chezmoi re-add          # copy every tracked file's current state into the repo
chezmoi cd              # jump into the repo (~/.local/share/chezmoi)
git add -A
git commit -m "update hypr bindings"
git push
exit
```

Check what changed before committing with `chezmoi diff` or `git diff` inside `chezmoi cd`.

### Track a new file or folder

```bash
chezmoi add ~/.config/<app>
```

### Switched to a new Omarchy theme

```bash
chezmoi add ~/.config/omarchy/themes/<theme-name>
```

### Stop tracking something

```bash
chezmoi forget ~/.config/<app>
```

## Pull updates on another machine

```bash
chezmoi update -v       # git pull + apply
```

## Never commit

- `~/.config/gh/`: contains the GitHub auth token
- Anything with API keys or passwords. Check first with
  `grep -riE "token|key|secret|password" ~/.config/<app>`
- Browser profiles (`BraveSoftware`, `chromium`, ...): huge caches, not config
- Theme folders that are their own git clones (they contain a `.git/`)

Backup files (`*.bak*`) are excluded via `.chezmoiignore`.

## Cheat sheet

| Command | What it does |
|---|---|
| `chezmoi diff` | Show differences between repo and `$HOME` |
| `chezmoi apply -v` | Write repo files into `$HOME` |
| `chezmoi re-add` | Write `$HOME` changes back into the repo |
| `chezmoi add <path>` | Start tracking a file |
| `chezmoi managed` | List all tracked files |
| `chezmoi cd` | Open a shell in the repo |
| `chezmoi update` | Pull from GitHub and apply |
