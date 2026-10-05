#!/bin/bash
set -e

REPO_ROOT="$HOME/dotfiles/"
BRANCH="master"
BACKUP_DIR="$HOME/dotfiles/package-lists"
COMMIT_MSG="Auto-update yay npm pipx packages $(date +%Y-%m-%d_%H:%M)"

mkdir -p "$BACKUP_DIR"
mkdir -p "$REPO_ROOT/.config"
mkdir -p "$REPO_ROOT/.local"

# Save the last run timestamp
echo "$(date +%Y-%m-%d_%H:%M:%S)" >"$BACKUP_DIR/last-session.txt"

# Run your package backup script

# --- Backup ---
echo "Backing up packages..."
pacman -Qqe >"$BACKUP_DIR/pacman.txt"
yay -Qqe >"$BACKUP_DIR/yay.txt"
pnpm list -g --depth=0 --parseable | awk -F/ '{print $NF}' >"$BACKUP_DIR/pnpm.txt"
npm list -g --depth=0 --parseable | awk -F/ '{print $NF}' >"$BACKUP_DIR/npm.txt"
pipx list --short >"$BACKUP_DIR/pipx.txt"
echo "Backup complete. Saved in $BACKUP_DIR"

mkdir -p "$REPO_ROOT/.local/bin"
mkdir -p "$REPO_ROOT/.ssh"

rsync -a --delete \
  --exclude='id_*' \
  "$HOME/.ssh/" \
  "$REPO_ROOT/.ssh/"

rsync -a --delete "$HOME/.local/bin/" "$REPO_ROOT/.local/bin/"
rsync -a --delete "$HOME/.config/swaync/" "$REPO_ROOT/.config/swaync/"
rsync -a --delete "$HOME/.config/cava/" "$REPO_ROOT/.config/cava/"
rsync -a --delete "$HOME/.config/wlogout/" "$REPO_ROOT/.config/wlogout/"
rsync -a --delete "$HOME/.config/Wallpapers/" "$REPO_ROOT/.config/Wallpapers/"
rsync -a --delete "$HOME/.config/rofi/" "$REPO_ROOT/.config/rofi/"
rsync -a --delete "$HOME/.config/wofi/" "$REPO_ROOT/.config/wofi/"
rsync -a --delete "$HOME/.config/hypr/" "$REPO_ROOT/.config/hypr/"
rsync -a --delete "$HOME/.config/fastfetch/" "$REPO_ROOT/.config/fastfetch/"
rsync -a --delete "$HOME/.config/kitty/" "$REPO_ROOT/.config/kitty/"
rsync -a --delete "$HOME/.config/eww/" "$REPO_ROOT/.config/eww/"

# Make sure we are in the repo root
cd "$REPO_ROOT"

git add install-pkg.sh -f
git add package-lists/ -f
git add .local/bin/ -f
git add .config/swaync/ -f
git add .config/cava/ -f
git add .config/wlogout/ -f
git add .config/rofi/ -f
git add .config/wofi/ -f
git add .config/hypr/ -f
git add .config/fastfetch/ -f
git add .config/kitty/ -f
git add .config/Wallpapers/Scripts
git add .config/eww/ -f

# Commit changes
git commit -m "$COMMIT_MSG"
git push origin "$BRANCH"
echo "Packages updated and pushed: $COMMIT_MSG"
