#!/bin/bash
# Backup & restore script for Arch/Node/Python environments

BACKUP_DIR="$HOME/dotfiles/package-lists/"
mkdir -p "$BACKUP_DIR"

echo "installing and Backing up package-lists"

echo "Restoring packages..."
xargs -a "$BACKUP_DIR/pacman.txt" sudo pacman -S --needed --noconfirm
xargs -a "$BACKUP_DIR/yay.txt" yay -S --needed --noconfirm
xargs -a "$BACKUP_DIR/pnpm.txt" pnpm add -g
xargs -a "$BACKUP_DIR/pipx.txt" pipx install
echo "Restore complete."

# --- Backup ---
echo "Backing up packages..."
pacman -Qqe >"$BACKUP_DIR/pacman.txt"
yay -Qqe >"$BACKUP_DIR/yay.txt"
pnpm list -g --depth=0 --parseable | awk -F/ '{print $NF}' >"$BACKUP_DIR/pnpm.txt"
pipx list --short >"$BACKUP_DIR/pipx.txt"
echo "Backup complete. Saved in $BACKUP_DIR"
