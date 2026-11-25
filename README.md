# Void Sway Estuary Rice

Minimalist forest-toned Sway desktop environment on Void Linux using the **Atelier Estuary Dark** palette and **CozetteVector** font.

## Components

- **WM:** Sway
- **Bar:** Waybar
- **Terminal:** kitty (`CozetteVector` + `Noto Color Emoji`)
- **System Monitor:** btop (TTY theme)
- **Music:** `mpd` + `ncmpcpp` + `cava` (`estuary` theme) + `scadd` (`yt-dlp` SoundCloud importer)
- **Audio:** PipeWire + WirePlumber + `pipewire-pulse`

## Included Files

- `.config/sway/` — Sway config & theme include
- `.config/waybar/` — Waybar layout & CSS styling
- `.config/kitty/` — Kitty config & Atelier Estuary Dark theme
- `.config/cava/` — Cava config & `estuary` color theme
- `.config/mpd/mpd.conf` — MPD PipeWire configuration
- `.config/fontconfig/fonts.conf` — `monospace` / `Cozette` → `CozetteVector` mapping
- `.local/bin/` — Helper scripts (`audio-start`, `waybar-start`, `vol-status`, `vol-toggle`, `scadd`, `screenshot`, etc.)
- `.local/share/wallpapers/` — Forest wallpaper (`wallhaven-oxoqp9.png`)

## Dependencies (Void Linux)

```sh
sudo xbps-install -S sway waybar kitty btop cava mpd mpc ncmpcpp \
  pipewire wireplumber yt-dlp ffmpeg grim slurp wl-clipboard noto-fonts-emoji
```

*(Also install **CozetteVector** font into `~/.local/share/fonts` or `/usr/share/fonts`.)*

## Installation

```sh
git clone https://github.com/potraxivatel/foksfiles.git ~/foksfiles
cd ~/foksfiles
./install.sh
```

`install.sh` backs up any existing configs to `~/.dotfiles-backup-<timestamp>`, installs files into `~/.config`, `~/.local/bin`, and `~/.local/share/wallpapers`, and rewrites hardcoded home paths to `$HOME`.
