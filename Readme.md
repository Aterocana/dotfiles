# 🏠 Dotfiles – Arch Linux + Wayland (Sway) Setup

These are my personal dotfiles used in Arch Linux with [Sway](https://github.com/swaywm/sway) as Tile Manager.
They are handled by [GNU Stow](https://www.gnu.org/software/stow/).

---

## 📦 Used tools

- 🎮 **Window manager**: [Sway](https://github.com/swaywm/sway).
- 💬 **Terminal**: [Kitty](https://github.com/kovidgoyal/kitty).
- 🔧 **Prompt**: [Zsh](https://www.zsh.org/) + [Starship](https://github.com/starship/starship).
- 🖋️ **Editor**: [Neovim](https://github.com/neovim/neovim).
- 📊 **Status Bar**: [Waybar](https://github.com/Alexays/Waybar).
- 🧩 **Gestione dotfiles**: [GNU Stow](https://www.gnu.org/software/stow/).
- 🗂️ **Script**: personal scripts useful to solve repetitive tasks (mainly with [Rofi](https://github.com/in0ni/rofi-wayland))).

---

## 🚀 Quick installation

```bash
git clone https://github.com/Aterocana/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## 🔧 Requirements

[Arch Linux](https://archlinux.org/) with following packages:

* swayfx, swayfx-debug, swaylock-blur-git, swaylock-effects, swaybg-git, wlroots, wlrobs-hg, xdg-desktop-portal-wlr.
* wl-clipboard, clipman, rofi-wayland.
* zsh, zsh-autocomplete, zsh-autosuggestions, zsh-completions, zsh-syntax-highlighting, starship, fzf-tab-git.
* stow
* nerd-fonts (group), ttf-nerd-fonts-symbols, ttf-nerd-fonts-symbols-mono.

🧩 Future improvements

* [ ]  Hostname detection to support different machines.

📜 Licenza
MIT – Feel free to copy, fork and adapt to your needs.
