# Kali Linux Installation & Configuration Guide

## Scale everthing up

Enable _Kali HiDPI Mode_.

## Setting up terminal

### Changing size

Go to _File_ -> _Preferences_ -> _Dropdown_ -> _Size_ and set width and height to 100%

### Changing terminal font

1. Go to https://www.nerdfonts.com/font-downloads and download your desired font.
1. ````
   unzip <name-of-font>.zip
   mkdir -p ~/.local/share/fonts
   cp *.ttf ~/.local/share/fonts```
   ````
1. Reboot
1. In terminal: _File_ -> _Preferences_ -> _Change..._

### Prettifying & aliases

1. **zsh4humans**
   - https://github.com/romkatv/zsh4humans
   - copy & paste, then configure
1. **zsh_aliases**
   - copy from github

### Tweaks

Go to: _File_ -> _Behavior_ -> _Emulation_ and change to _linux_ - it changes the behavior of backspace.

## Remapping Caps Lock to Esc

Open _Session and Startup_ and go to _Application Autostart_ -> _Add_ -> In command type: `/usr/bin/setxkbmap -option "caps:swapescape"`

## Setting shortcuts

- Open _Window Manager_ and go to _Keyboard_. Change _Close window_ and _Maximize window_ shortcuts.
- Open _Keyboard_ and go to _Applications_. Change shortcuts for opening terminal (Super + T) and browser (Super + F)

## Neovim

```
sudo apt update && sudo apt install -y neovim npm ripgrep fd-find xclip python3-neovim make
sudo apt install python3-venv
sudo npm install -g neovim
```

optional: go to _lsp.lua_ file and comment line with r-languageserver
