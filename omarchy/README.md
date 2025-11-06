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

### Set the default terminal

Modify `~/.config/xdg-terminals.list` file - add to the top of the file:

- `kitty.desktop` for kitty
- `Alacritty.desktop` for alacritty

You can verify if the .desktop file exists by running `ls /usr/share/applications`.

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

### Install other apps

- Set up VMware workstation (from my arch linux README).
- Install [Mullvad VPN](https://wiki.archlinux.org/title/Mullvad).

```bash
yay -S anki-bin calibre visual-studio-code-bin
```

### Network (systemd-networkd vs NetworkManager)

#### systemd-networkd + iwd vs NetworkManager

By default, systemd-networkd and iwd are responsible for network connection in Omarchy (with iwd for wi-fi).

That's where NetworkManager comes in - it is by far the most popular method of network management on Linux. It solves 2 main issues that systemd-networkd + iwd setup suffers from:

- easy VPN connection
- 802.1x support (a.k.a. WPA/WPA2 Enterprise or Eduroam).

#### iwd vs wpa_supplicant (with NetworkManager)

NetworkManager is built on top of iwd or wpa_supplicant (it supports both, though wpa_supplicant is the default). Overall, iwd is faster and newer than wpa_supplicant. However, you might encounter some problems with it.

When it comes to **VPN**, I have been encountering some issues with iwd, while wpa_supplicant supplicant "just works".

As for connection to **eduroam**, here is how it works for me:

| eduroam                 | iwd | wpa_supplicant |
| :---------------------- | :-: | :------------: |
| TLS (certificates)      | ❌  |       ❌       |
| PEAP (email + password) | ✅  |       ✅       |

Truth be told, TLS might work on different OS/computer/setup. Just because it didn't work for me doesn't mean it won't work for you. There were some people on github that managed it without any problems (https://github.com/basecamp/omarchy/issues/1414).

#### Switching to NetworkManager

**All** (iwd/wpa_supplicant):

```bash
sudo pacman -S networkmanager
sudo systemctl disable --now wpa_supplicant.service systemd-networkd.service systemd-networkd-wait-online.service systemd-networkd.socket systemd-networkd-varlink.socket iwd.service
```

**wpa_supplicant**:

```bash
sudo systemctl mask iwd.service
sudo systemctl enable --now wpa_supplicant
printf "[device]\nwifi.backend=wpa_supplicant\n" | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf
```

**iwd**:

```bash
sudo systemctl mask wpa_supplicant.service
printf "[device]\nwifi.backend=iwd\n" | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf
```

**All** (iwd/wpa_supplicant):

```bash
sudo systemctl enable --now NetworkManager.service
sudo systemctl restart NetworkManager.service

rfkill unblock wifi
nmcli networking on
nmcli radio wifi on
reboot
```

Make sure there are no errors during execution of each of the commands. You can verify that the NetworkManager with iwd/wpa_supplicant works with:

```bash
ps aux | grep -E "(wpa_supplicant|iwd)"
```

That's it! Now everything should be running smoothly 😎.

For OpenVPN support, install:

```bash
sudo pacman -S networkmanager-openvpn
```

**Sources:**

- https://github.com/basecamp/omarchy/issues/1414
- https://wiki.archlinux.org/title/NetworkManager#Using_iwd_as_the_Wi-Fi_backend.

#### eduroam connection (TLS, not working ❌)

To connect to eduroam (WPA/WPA2 Enterprise) using TLS method with certificates, you first need to obtain all necessary certificates:

- CA certificate (.pem/.crt)
- Client certificate (.pem)
- Private key (.pem)

On PG we can download .crt (CA, which is already in .pem format) and user certificate in .p12 format.

The .p12 certificate needs to be split into 2 files:

```bash
mkdir ~/.certificates
openssl pkcs12 -in ~/.certificates/certyfikat_uzytkownika.p12 -clcerts -nokeys -out ~/.certificates/eduroam-client.pem
openssl pkcs12 -in ~/.certificates/certyfikat_uzytkownika.p12 -nocerts -nodes -out ~/.certificates/eduroam-private.key
chmod 600 ~/.certificates/eduroam-private.key
```

We need the files in /etc directory for some reason (in home directory didn't work for me). So copy them:

```bash
sudo mkdir -p /etc/certs/eduroam
sudo cp ~/.certificates/PG_Root_CA.crt /etc/certs/eduroam/
sudo cp ~/.certificates/eduroam-client.pem /etc/certs/eduroam/
sudo cp ~/.certificates/eduroam-private.key /etc/certs/eduroam/
```

Now we are ready to add the eduroam connection.

**NetworkManager with wpa_supplicant:**

You have 3 options to create a connection:

- `nmtui` - a TUI tool
- `nmcli` - a CLI tool
- `nm-connection-editor` - a GUI tool

`nmcli` option:

```bash
sudo nmcli connection add \
  type wifi \
  con-name "eduroam" \
  ifname "wlan0" \
  ssid "eduroam" \
  -- \
  wifi-sec.key-mgmt wpa-eap \
  802-1x.eap tls \
  802-1x.identity "<your_student_login>@student.pg.edu.pl" \
  802-1x.ca-cert "/etc/certs/eduroam/PG_Root_CA.crt" \
  802-1x.client-cert "/etc/certs/eduroam/eduroam-client.pem" \
  802-1x.private-key "/etc/certs/eduroam/eduroam-client.pem" \
  802-1x.private-key-password-flags 1


nmcli connection up "eduroam"
```

**NetworkManager with iwd:**

Edit the following file:

```bash
sudo vim /var/lib/iwd/eduroam.8021x
```

and paste this contents there:

```
[Security]
EAP-Method=TLS
EAP-TLS-CACert=/etc/certs/eduroam/PG_Root_CA.crt
EAP-Identity=<your_student_login>@student.pg.edu.pl
EAP-TLS-ClientCert=/etc/certs/eduroam/eduroam-client.pem
EAP-TLS-ClientKey=/etc/certs/eduroam/eduroam-private.key
#EAP-TLS-ClientKeyPassphrase=key-passphrase

[Settings]
AutoConnect=true
```

Then, connect to the network with:

```bash
nmcli connection up "eduroam"
```

It might work or it might not. For me it didn't. You can try rebooting and connecting again too.

#### eduroam connection (PEAP, working ✅)

This method is much easier to set up, but also less secure as someone might pose as eduroam and steal your credentials. Here is how you set it up.

**wpa_supplicant** method:

- `nmtui` - a TUI tool
- `nmcli` - a CLI tool
- `nm-connection-editor` - a GUI tool

For _anonymous-identity_ write `anonymous@student.pg.edu.pl`.
For the second (first was PEAP) authentication method (if not chosen for you already) choose `MSCHAPv2`.

I used `nmtui` for creating this connection. You can choose whichever you prefer. \
And that's it! You should be able to connect to the eduroam without any problems.

**iwd** method:

Edit the following file:

```bash
sudo vim /var/lib/iwd/eduroam.8021x
```

and paste the contents there:

```
[Security]
EAP-Method=PEAP
EAP-Identity=anonymous@student.pg.edu.pl
EAP-PEAP-Phase2-Method=MSCHAPV2
EAP-PEAP-Phase2-Identity=<your_student_login>@student.pg.edu.pl
EAP-PEAP-Phase2-Password=YOUR_PASSWORD

[Settings]
AutoConnect=true
```

You can now connect with e.g. `nmcli` tool:

```bash
nmcli connection up "eduroam"
```

#### Useful commands

```bash
sudo vim /etc/NetworkManager/conf.d/wifi_backend.conf
sudo vim /var/lib/iwd/eduroam.8021x
nmcli connection show
nmcli connection up "network_name"
systemctl status systemd-networkd.service
```

### Troubleshooting

#### Reset Hyprland

It is possible that a system update (in particular Omarchy update) breaks something in the configuration. To solve the problem, reset the configuration to the new default:

```bash
omarchy-reset-hyprland
```
