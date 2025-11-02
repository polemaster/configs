## Omarchy post-installation configuration

This README file describes my configuration of Omarchy. \
Omarchy was installed from the official ISO image.

### Connect to wifi (if the TUI is not working)

```bash
sudo rfkill unblock wlan
```

Then connect to the wi-fi via TUI (Impala).

### Increase pacman speed

```bash
sudo reflector --verbose --country 'Poland' --country 'Germany' --protocol https --age 12 --sort rate --fastest 10 --save /etc/pacman.d/mirrorlist
```

Or:

```bash
yay -S rate-mirrors-bin
sudo rate-mirrors arch --save /etc/pacman.d/mirrorlist
```

### Install Brave

```bash
yay -S brave-bin
```

### Configure neovim

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.config/nvim
mkdir ~/repos
cd ~/repos
git clone https://github.com/polemaster/configs
cd ~/.config
cp -r ~/repos/configs/nvim .
sudo pacman -S --needed neovim npm ripgrep fd make xclip r python-neovim
sudo npm install -g neovim stylelint stylelint-config-standard tree-sitter-cli
```

Also, create a file ~/.config/stylelint/.stylelintrc.json with the content:

```json
{
  "extends": "stylelint-config-standard",
  "rules": {
    "at-rule-no-unknown": null
  }
}
```

### Change caps lock to escape

```bash
cd ~/.config/hypr
nvim input.conf
```

- Change _compose:caps_ to _caps:escape_ and save and exit.
- Uncomment _natural_scroll = true_ line.

```bash
hyprctl reload
```

### Change key repeat and delay rates

Go to `~/.config/hypr/input.conf` and change the values to:

```
repeat_rate = 30
repeat_delay = 300
```

### Set kitty as the default terminal

```bash
sudo pacman -S kitty
```

Go to `~/.config/uwsm/default` and change the default terminal from _alacritty_ to _kitty_.

### Change font size in the terminal

Go to `~/.config/kitty/kitty.conf` and change _font_size_ to 11.

### Change bash to zsh

```bash
sudo pacman -S zsh
chsh -s /usr/bin/zsh
```

Reboot.

### Configure zsh

```bash
cp ~/repos/configs/zsh/.zsh_aliases ~
```

- Go to https://github.com/romkatv/zsh4humans and follow the instructions.
- Modify .zshrc by adding this at the end and removing pre-existing aliases:

```
source ~/.zsh_aliases

HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
```

### Configure Polish keyboard

Go to `~/.config/hypr/input.conf` and change options inside _input_ to:

```bash
kb_layout = pl,es
kb_options = caps:escape,grp:alt_shift_toggle
```

### Configure git

If skipped during Omarchy installation, set it up now:

```bash
git config --global user.name "name"
git config --global user.email "email"
```

Or in the other way:

```bash
git config --global --edit
```

And adding/changing:

```bash
[user]
    name = <name>
    email = <email>
```

### FIDO2 (Yubico keys)

_Omarchy menu -> Setup -> Security -> FIDO2_

### Set up figerprint log-in

**Note**: This is for 27c6:550a fingerprint reader (you can check it with `lsusb`).

```bash
yay -S libfprint-2-tod1-goodix
```

When prompted to remove libfprint (conflict), do it. \
Then, add fingerprint:

```bash
fprintd-enroll
```

### Install partition manager

```bash
sudo pacman -S exfatprogs partitionmanager dosfstools ntfs-3g
```

### Mount devices automatically

```bash
sudo pacman -S udiskie
```

Add this to the file `~/.config/hypr/hyprland.conf`:

```bash
exec-once = udiskie
```

Reload Hyprland or reboot. \
**Note**: at this point, you can copy files from backup / previous computer

### Change keybindings

Add this to the end of `~/.config/hypr/bindings.conf`:

```bash
# Omarchy menu on Super + Space
unbind = SUPER, SPACE
bindd = SUPER, SPACE, Omarchy menu, exec, omarchy-menu

# App launcher on Super key, like in Windows and Linux
bindr = SUPER, SUPER_L , exec, omarchy-launch-walker

# Change full tiling screen binding
unbind = SUPER ALT, F
unbind = SUPER SHIFT, F
bindd = SUPER SHIFT, F, Full width, fullscreen, 1

# Bind Super E to open files instead
bindd = SUPER, E, File manager, exec, uwsm-app -- nautilus --new-window

# Lock screen on Super + U
bindd = SUPER, U, Lock screen, exec, loginctl lock-session

# Moving through the windows with Super + h/j/k/l
unbind = SUPER, K
unbind = SUPER, J
bindd = SUPER, H, Move window focus left, movefocus, l
bindd = SUPER, L, Move window focus right, movefocus, r
bindd = SUPER, K, Move window focus up, movefocus, u
bindd = SUPER, J, Move window focus down, movefocus, d

# Bind help (previously Super + K) to Super + I
bindd = SUPER, I, Show key bindings, exec, omarchy-menu-keybindings

# Bind toggle (previously Super + J) to Super + O
bindd = SUPER, O, Toggle window split, togglesplit, # dwindle

# Keybindings for fast moving through grouped windows
bindd = SUPER, grave, Next window in group, changegroupactive, f
bindd = SUPER SHIFT, grave, Previous window in group, changegroupactive, b
bindd = ALT, grave, Next window in group, changegroupactive, f
bindd = ALT SHIFT, grave, Previous window in group, changegroupactive, b

# Shutdown button turns off the computer
bindld = , XF86PowerOff, Shutdown, exec, sh -c "omarchy-state clear re*-required && systemctl poweroff --no-wall"
```

### Set start-up apps

To `~/.config/hypr/autostart.conf` add:

```bash
exec-once = $browser
```

### Change Waybar

The directory to edit waybar is `~/.config/waybar/`.

#### Show battery percentage

Edit _battery_ in `config.jsonc`:

```json
"format": "{icon} {capacity}%",
"format-discharging": "{icon} {capacity}%",
"format-charging": "{icon} {capacity}%",
```

#### Show current keyboard

Edit **config.jsonc** file. \
Add `"hyprland/language",` to _modules-right_. \
Add:

```json
"hyprland/language": {
  "format": "{short}",
  "tooltip": false,
  "on-click": "hyprctl switchxkblayout 'ite-tech.-inc.-ite-device(8910)-keyboard' next"
},
```

before `"custom/omarchy"`.

Now edit **style.css** file. \
Add `#language,` for _min-width_ and _margin_ where others are defined (_#cpu_, _#battery_, etc.).
Add this:

```css
#language {
  margin-right: 15px;
}
```

#### Remove cpu

Remove all cpu-related code as it is unnecessary.

#### Change margin for wifi:

```css
#network {
  margin-right: 8px;
}
```

### Move using ctrl + hjkl in menus

Add these lines to `~/.config/walker/config.toml`:

```bash
next = ["Down", "ctrl j"]
previous = ["Up", "ctrl k"]
```
