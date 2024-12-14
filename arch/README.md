# Arch Linux Installation & Configuration Guide

## During _archinstall_

1. connect to the internet using [iwctl](https://wiki.archlinux.org/title/Iwd#Connect_to_a_network)
1. **locale**: en_US, **keyboard**: pl
1. choose _Desktop_ profile with _gnome_ and _gdm_
1. **audio**: _pipewire_
1. **network configuration**: NetworkManager
1. **additional packages**: _firefox vim_
1. **optional repositories**: _multilib_

## Without using archinstall (to use disk encryption)

???

## Settings

- **Power**: _Power Button_ &rarr; _Power off_
- **Multitasking**: Turn off _Hot Corner_
- **Search**: _Search location_ &rarr; leave only videos, _Apps_ &rarr; leave _Files, Calculator, Characters, Settings_
- **Keyboard**

  1. _Add input source_ &rarr; _Polish, Spanish_
  2. _View and Customize Shortcuts_:
     - _Launchers_: web browser = ctrl + f
     - _Navigation_: hide all windows = super + d
     - _Windows_: close windows = super + w, maximize window = super + m
     - _Custom Shortcuts_: nautilus = super + e, kgx = super + t

## Tweaks

- **Keyboard**: _Additional Layout Options_ &rarr; _Caps Lock behavior_ &rarr; _Make Caps Lock an additional Esc_

## Firefox:

1. Install extensions: bitwarden, ublock, privacy badger, canvas blocker, facebook container
2. user.js???

## Terminal:

1. **pacman config**

   - Uncomment these lines in /etc/pacman.conf:

     ```
     Color
     ParallelDownloads = 5
     ```

     And add this line:  
      `ILoveCandy`

   - Install _reflector_ and [configure it](https://wiki.archlinux.org/title/Reflector):  
     `sudo pacman -S reflector`

1. **nerd font**
   - `sudo pacman -S ttf-roboto-mono-nerd`
   - change font in _gnome-tweaks_, then restart terminal
1. **zsh4humans**
   - https://github.com/romkatv/zsh4humans
   - copy & paste, then configure
1. **zsh_aliases**
   - copy from github

## Neovim

```
sudo pacman -S --needed neovim npm ripgrep fd make xclip r python-neovim
sudo npm install -g neovim
```

Then copy config from [my github](https://github.com/polemaster/configs/tree/main) to _~/.config/nvim_.

## Bluetooth

```
systemctl start bluetooth.service
systemctl enable bluetooth.service
```

## Extensions

1. Install extension in the web browser on extensions.gnome.org website
2. `sudo pacman -S gnome-browser-connector`
3. Install extensions
   - IdeaPad

## Battery life

### For everyone

```
sudo pacman -S tlp
systemctl start tlp.service
systemctl enable tlp.service
```

### Only for Lenovo laptop users

Additionally, if you have a Lenovo laptop, you can go to [Arch wiki](https://wiki.archlinux.org/title/Laptop/Lenovo) for more info.  
In my case, I needed to write in the terminal:  
`echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`  
and/or install _Ideapad_ extension (to enable _Conservation mode_).

## Installing packages

Create your own _pkglist.txt_ file containing all packages you would like to have.

### Install packages from the file

`pacman -S --needed - < pkglist.txt`

### Uninstall unnecessary packages

`pacman -Rsu $(comm -23 <(pacman -Qq | sort) <(sort pkglist.txt))`

### AUR packages

First, install AUR helper: [_yay_](https://github.com/Jguer/yay).

```
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
yay -Y --gendb
yay -Syu --devel
yay -Y --devel --save
```

Then, install your packages from _pkglist.txt_.

## Add various configs from my github

- **VSCodium**: _settings.json_ and _keybindings.json_, install vim extension
- **.editorconfig** file
- copy **mpv.conf** to a _.config/mpv_ directory

## Configure Wireshark

Follow _Limiting capture permission to only one group_ from the site below:  
https://wiki.wireshark.org/CaptureSetup/CapturePrivileges

## Adding yourself to groups _input_ and _video_

This fixes some issues, e.g. _snapshot_ (camera) app not detecting video inputs.

```
sudo usermod -a -G input,video polemaster
```

## Steam

```
sudo pacman -S steam
```

or

```
yay -S steam gamescope gamescope-session-steam-git
```

_gamescope_ provides an experimental HDR support. It needs to be [enabled on Steam](https://wiki.archlinux.org/title/HDR_monitor_support#Configure_Steam). AMD is better suited for HDR than NVIDIA.

## Adding printers

```
sudo pacman -S cups system-config-printer
```

More info here: https://wiki.archlinux.org/title/CUPS.  
Then you can use GUI software (_Print Settings_) to add drivers and add printers.

## Setting up VirtualBox

Helpful link: https://wiki.archlinux.org/title/VirtualBox

1. `sudo pacman -S virtualbox virtualbox-guest-iso` - Choose option depending on your [kernel](https://wiki.archlinux.org/title/VirtualBox#Install_the_core_packages).
1. `sudo usermod -aG vboxusers polemaster` - this enables the use of host USB devices
1. `yay -S virtualbox-ext-oracle` - for host camera usage (Oracle extension pack)
1. Reboot computer.

### Adding Windows 11

1. Create new Virtual Machine
1. Change resolution - explained [here](https://www.ghacks.net/2022/06/11/how-to-change-the-windows-screen-size-in-virtualbox/). Then change scale to appropriate (200% in my case).
1. Shut down Windows and enable network in VirtualBox settings.
1. Start Windows.

## Installing CUDA

```
sudo pacman -S cudnn cuda
yay -S miniconda3
echo "[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh" >> ~/.zshrc
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
cd /opt
sudo chown -R $USER:$USER miniconda3
conda update conda
(conda install cryptography) -- not necessary
conda create -n <name-of-env> python
conda activate <name-of-env>
pip install --upgrade pip
pip install tensorflow[and-cuda] -- use bash if square brackets don't work in zsh
```

## Enabling Secure Boot

https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot#Implementing_Secure_Boot
https://www.reddit.com/r/archlinux/comments/13d7rec/setting_up_secure_boot_while_dual_booting_windows/
https://www.reddit.com/r/archlinux/comments/10pq74e/my_easy_method_for_setting_up_secure_boot_with/

## Encryption of the disk

LUKS, VeraCrypt

## Troubleshooting

### Sound not working

- Sound on PC:
  alsamixer -> select sound card and unmute
- Sound on Laptop with Intel:
  sudo pacman -S sof-firmware

### Printers not found

Add CUPS: https://wiki.archlinux.org/title/CUPS

### I can't disable Wayland

- Edit _/etc/gdm/custom.conf_.
- During start-up select Gnome (with Xorg, if possible) instead of Gnome-classic

### I can't add Windows to grub

```
sudo pacman -S os-prober
sudo os-prober (Windows should show, if not: sudo mkdir /mnt/win11 && sudo mount /dev/nvme0n1p1 /mnt/win11)
sudo grub-mkconfig -o /boot/grub/grub.cfg (if Windows not added edit /etc/defualt/grub: uncomment last line (GRUB_DISABLE_OS_PROBER=false) and rerun the command)
```

### YubiKeys are not working

Install:

- (optionally?) _yubikey-manager_ or _yubikey-manager-qt_
- one or both of these: _yubico-pam_, _pam-u2f_

### Videos not playing in Tor Browser

```
sudo pacman -S ffmpeg4.4
```
