## Omarchy post-installation configuration

This README file describes my configuration of Omarchy. \
Omarchy was installed from the official ISO image.

### First steps

1. Connect to WiFi via TUI.
1. Update Omarchy and reboot.
1. Clone _configs_ repository from GitHub.
1. Set up neovim (see below).
1. Set up zsh (from _configs_).
1. Set up firefox (see below).
   - (Optional) Change mirrorlist from Omarchy to reflector-generated one (see below) & Update the system.
1. Copy hyprland config from backup, update shell to zsh & reboot.
1. Continue with the instructions below.

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

### Install Firefox

After installing, open and close it. Copy .mozilla folder from backup and open Firefox.

If you see a message: `Using an older version of Firefox can corrupt bookmarks...`, then you must update Firefox to newest version bypassing Omarchy update.

### Increase pacman speed

```bash
sudo reflector --verbose --country 'Poland' --country 'Germany' --protocol https --age 12 --sort rate --fastest 10 --save /etc/pacman.d/mirrorlist
```

Or:

```bash
yay -S rate-mirrors-bin
sudo rate-mirrors arch --save /etc/pacman.d/mirrorlist
```

```bash
hyprctl reload
```

### Customize the _foot_ terminal

Go to `~/.config/foot/foot.ini` and change _Font:size_ to 11.
Change `include=~/.local/state/omarchy/current/theme/foot.ini` to `include=/usr/share/foot/themes/tokyonight-night`.

### Change bash to zsh

```bash
sudo pacman -S zsh
chsh -s /usr/bin/zsh
```

Reboot.

### Configure zsh

```bash
sudo pacman -S zsh grml-zsh-config zsh-completions zsh-autosuggestions zsh-syntax-highlighting starship ttf-jetbrains-mono-nerd
cp ~/repos/configs/zsh/* ~
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

Now we need to enable it. First check where the file responsible for normal way of setting it up is:

```bash
which omarchy-setup-security-fingerprint
```

Looking at the code, Gemini suggested running only some of the functions from that file:

```bash
bash -c '
  source <(sed -n "/^setup_pam_config()/,/^}/p; /^setup_lock_fingerprint_pam()/,/^}/p" /usr/share/omarchy/bin/omarchy-setup-security-fingerprint)
  setup_pam_config
  setup_lock_fingerprint_pam
'
```

And to prevent the future Omarchy updates from replacing my custom `libfprint` package:

```bash
sudo nvim /etc/pacman.conf
```

and under the `[Options]`:

```
IgnorePkg = libfprint-git libfprint-tod libfprint-2-tod1-goodix
```

### Copy old config files

Go to the .config directory in the backup folder.

```bash
cp -rv calibre mpv ~/.config
```

### Set default browser

```bash
omarchy default browser firefox
```

### Understanding installed apps

```bash
ls ~/.local/share/applications/
pacman -Qe
```

### Modifying ESC behavior in Wayland app menu

To change ESC to quit the app menu immediately instead of clearing text, modify this file:

```bash
sudo cp /usr/share/omarchy/shell/plugins/dock/AppGrid.qml /usr/share/omarchy/shell/plugins/dock/AppGrid.qml.bak
sudo nvim /usr/share/omarchy/shell/plugins/dock/AppGrid.qml
```

Change this:

```
else if (event.key === Qt.Key_Escape) {
    if (root.menuEntry) root.menuEntry = null
    else if (root.filterText) root.setFilter("")
    else root.close()
}
```

to:

```qml
else if (event.key === Qt.Key_Escape) {
    if (root.menuEntry && !root.filterText) root.menuEntry = null
    else root.close()
}
```

To apply the changes, run:

```bash
omarchy restart shell
```

### Install other apps

```bash
sudo pacman -S --needed - < apps
yay -S --needed - < aur_apps
```

or if there are blank lines or comments:

```bash
grep -vE '^\s*(#|$)' apps | sudo pacman -S --needed -
grep -vE '^\s*(#|$)' aur_apps | yay -S --needed -
```

### Change default image viewer to eog (Eye of Gnome)

```bash
xdg-mime default org.gnome.eog.desktop image/png
xdg-mime default org.gnome.eog.desktop image/jpeg
xdg-mime default org.gnome.eog.desktop image/gif
xdg-mime default org.gnome.eog.desktop image/webp
xdg-mime default org.gnome.eog.desktop image/bmp
xdg-mime default org.gnome.eog.desktop image/tiff
```

### Set up Virtual Machines software

We will use [libvirt](https://wiki.archlinux.org/title/Libvirt), [QEMU](https://wiki.archlinux.org/title/QEMU) and [virt-manager](https://wiki.archlinux.org/title/Virt-manager). The guide for installation was taken from [here](https://tanis.codes/posts/virt-manager-qemu-arch-linux/).

```bash
sudo pacman -S qemu-desktop libvirt dnsmasq openbsd-netcat dmidecode virt-manager
sudo systemctl enable --now libvirtd.socket
sudo usermod -aG libvirt $USER
sudo virsh net-autostart default
sudo virsh net-start default
```

Edit /etc/libvirt/network.conf file and change backend to iptables, if not using firewalld.

### Eduroam

If you are not using Gnome and are using NetworkManager, install `network-manager-applet`:

```bash
sudo pacman -S network-manager-applet
```

Use `nm-connection-editor` to connect to eduroam using the [guide](https://gdansktech.atlassian.net/wiki/spaces/HPPG/pages/636551348/Eduroam+Linux) from PG.

### Troubleshooting

#### Screensaver turns on in Firefox while watching videos

By default, Firefox tries to notify the `gtk` fallback about inhibiting screensaver but `gtk` tries to talk to GNOME daemon that doesn't exist in Omarchy. Changing the setting to `none` causes the browser to resolve to plan B: using `zwp_idle_inhibit_manager_v1` (native Wayland protocol).

```bash
mkdir -p ~/.config/xdg-desktop-portal
cat << 'EOF' > ~/.config/xdg-desktop-portal/hyprland-portals.conf
[preferred]
default=hyprland;gtk
org.freedesktop.impl.portal.Inhibit=none
EOF
systemctl --user restart xdg-desktop-portal
```
