## Omarchy post-installation configuration

### Table of contents

...

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

### Configure neovim

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.config/nvim
mkdir ~/repos
cd ~/repos
git clone https://github.com/polemaster/configs
cd ~/.config
cp -r ~/repos/configs/nvim .
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

### Change Waybar

#### Show battery percentage

uh...

#### Show current keyboard

If different from default, show it

### Keybindings to change:

- Moving through the windows with Super + h/j/k/l
- Setting full width of the windows: Super + Alt + f -> ...
- Moving through grouped windows: Super + Alt + Tab -> Alt + `
- Browser: Super + Shift + B -> Super + B
- Omarchy menu: Super + Alt + Space -> Super + Space
- App launcher: Super + Space -> Super

### Assign apps to workspaces

Is it possible even?

- Browser -> w1
- Terminal -> w2

### Setting up Brave

```bash
yay -S brave-bin
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

Reload Hyprland or reboot.

### WTF

What is kb_options = compose:caps doing in input.conf?

### Useful commands on Omarchy
