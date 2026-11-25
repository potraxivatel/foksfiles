#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
backed_up=0

backup_if_exists() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    local rel="${target#"$HOME"/}"
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    cp -a "$target" "$BACKUP_DIR/$rel"
    backed_up=1
  fi
}

install_tree() {
  local subdir="$1"
  local src_root="$REPO_DIR/$subdir"
  [[ -d "$src_root" ]] || return 0

  while IFS= read -r -d '' src; do
    local rel="${src#"$src_root"/}"
    local dst="$HOME/$subdir/$rel"
    mkdir -p "$(dirname "$dst")"
    backup_if_exists "$dst"
    cp -a "$src" "$dst"

    # Rewrite hardcoded /home/void references for portability across users/distros
    if [[ "$HOME" != "/home/void" ]] && grep -Iq . "$dst" 2>/dev/null; then
      sed -i "s|/home/void|$HOME|g" "$dst"
    fi
  done < <(find "$src_root" -type f -print0)
}

install_tree ".config"
install_tree ".local/bin"
install_tree ".local/share/wallpapers"

if [[ -d "$HOME/.local/bin" ]]; then
  chmod +x "$HOME/.local/bin"/* 2>/dev/null || true
fi

mkdir -p "$HOME/.config/mpd/playlists" "$HOME/Music" "$HOME/.local/state/audio"

if command -v fc-cache >/dev/null 2>&1; then
  fc-cache -f >/dev/null 2>&1 || true
fi

echo "Dotfiles installed into $HOME."
if [[ $backed_up -eq 1 ]]; then
  echo "Previous configs backed up to: $BACKUP_DIR"
fi
