# My Arch Linux Installation & Configuration

## Pre-installation

### Secure disk erasure

This should be done from live environment (e.g. live Arch, SystemRescue).

Firstly, format the the disk, according to [archwiki](https://wiki.archlinux.org/title/Solid_state_drive/Memory_cell_clearing):

```
sudo nvme format /dev/nvme0n1 -s 1
```

Next, overwrite the disk as specified in [archwiki](https://wiki.archlinux.org/title/Dm-crypt/Drive_preparation):

```
cryptsetup open --type plain --key-file /dev/urandom --sector-size 4096 /dev/nvme0n1 to_be_wiped
lsblk
dd if=/dev/zero of=/dev/mapper/to_be_wiped status=progress bs=1M
cryptsetup close to_be_wiped
```

## Installation: using _archinstall_

1. connect to the internet using [iwctl](https://wiki.archlinux.org/title/Iwd#Connect_to_a_network)
1. **locale**: en_US, **keyboard**: pl
1. choose _Desktop_ profile with _gnome_ and _gdm_
1. **audio**: _pipewire_
1. **network configuration**: NetworkManager
1. **additional packages**: _firefox vim_
1. **optional repositories**: _multilib_

## Installation: without using _archinstall_ (with Secure Boot and full-disk encryption)

The commands come from Archwiki's [Installation Guide](https://wiki.archlinux.org/title/Installation_guide) and [LUKS on a partition with TPM2 and Secure Boot](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition_with_TPM2_and_Secure_Boot).

Set the console keyboard layout (optional - has no effect after installation):

```
loadkeys pl
setfont ter-132b
```

Normal part:

```
cat /sys/firmware/efi/fw_platform_size          // should return 64 for UEFI 64-bit
rfkill             // should return unblocker
rfkill unblock wlan     // optional: if the interface is blocked, unblock it:
ip link            // network interface should be enabled
ip link set wlan0 up    // optional: should already be up
iwctl // for connecting via Wi-Fi
device list // should be powered on
station wlan0 scan
station wlan0 get-networks
station wlan0 connect <SSID>
timedatectl // should return current time
timedatectl set-timezone Europe/Prague // will persist after rebooting
cfdisk nvme0n1
```

Create 2 partitions:

1. 1GB - EFI System
1. Rest of the drive - Linux root (x86-64)

```
cryptsetup luksFormat /dev/nvme0n1p2 // Important - type blank password
cryptsetup open /dev/nvme0n1p2 root
mkfs.ext4 /dev/mapper/root
mount /dev/mapper/root /mnt

mkfs.fat -F 32 /dev/nvme0n1p1
mount --mkdir /dev/nvme0n1p1 /mnt/boot

vim /etc/pacman.d/mirrorlist // optional: better download speed (it gets copied after reboot)
pacstrap -K /mnt base linux linux-firmware

arch-chroot /mnt
pacman -S vim amd-ucode networkmanager iwd reflector linux-headers sudo

ln -sf /usr/share/zoneinfo/Europe/Prague /etc/localtime
hwclock --systohc
```

Uncomment this line from _/etc/locale.gen_:

```
en_US.UTF-8 UTF-8
```

Then type:

```
locale-gen
echo KEYMAP=pl > /etc/vconsole.conf
```

And add this to _/etc/locale.conf_:

```
LANG=en_US.UTF-8
```

Create the _/etc/hostname_ containing:

```
archlinux
```

Enable NetworkManager service:

```
systemctl enable NetworkManager.service
```

Change the line in /etc/mkinitcpio.conf:

```
HOOKS=(base systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems fsck)
```

Change /etc/kernel/cmdline to:

```
rw quiet bgrt_disable
```

Change the _linux.preset_ file to be the same as [here](https://wiki.archlinux.org/title/Unified_kernel_image#.preset_file). Change _efi_ to _boot_

Next steps:

```
bootctl install
mkinitcpio -P
rm /boot/initramfs*
passwd
exit
reboot
```

### Secure Boot

```
systemctl enable systemd-boot-update.service
pacman -S sbctl
sbctl status
sbctl create-keys
sbctl enroll-keys -m
sbctl status
sbctl sign -s /boot/EFI/Linux_arch-linux.efi
sbctl sign -s /boot/EFI/Linux_arch-linux-fallback.efi
sbctl sign -s -o /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed /usr/lib/systemd/boot/efi/systemd-bootx64.efi
bootctl install
sbctl verify
```

_Comment:_

These 2 files are copied from /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed file:

- sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
- sbctl sign -s /boot/EFI/systemd/systemd-bootx64.efi

### Setting up TPM

```
systemd-cryptenroll /dev/nvme0n1p2 --recovery-key
systemd-cryptenroll /dev/nvme0n1p2 --wipe-slot=empty --tpm2-device=auto --tpm2-pcrs=7
```

`--tpm2-with-pin=yes` can be added to the second command to create TPM pin. However, beware:

_"Note that incorrect PIN entry when unlocking increments the TPM dictionary attack lockout mechanism, and may lock out users for a prolonged time, depending on its configuration. The lockout mechanism is a global property of the TPM, systemd-cryptenroll does not control or configure the lockout mechanism. You may use tpm2-tss tools to inspect or configure the dictionary attack lockout, with tpm2_getcap(1) and tpm2_dictionarylockout(1) commands, respectively."_

## Post-installation

Driver installation:

```
pacman -S nvidia nvidia-utils nvidia-settings
```

Adding a user:

```
useradd -m -g users -G wheel polemaster
```

Other packages:

```
pacman -S --needed - < pkglist.txt
pacman -S nvtop less ntfs-3g mesa-utils
systemctl enable gdm
systemctl enable systemd-timesyncd // enable internet time sync if disabled
reboot
```

### Settings

- **Power**: _Power Button_ &rarr; _Power off_
- **Multitasking**: Turn off _Hot Corner_
- **Search**: _Search location_ &rarr; leave only videos, _Apps_ &rarr; leave _Files, Calculator, Characters, Settings_
- **Keyboard**

  1. _Add input source_ &rarr; _Polish, Spanish_
  2. _View and Customize Shortcuts_:
     - _Launchers_: Web Browser = _Ctrl + F_
     - _Navigation_:
       - Hide all windows = _Super + D_
       - Move window one workspace to the left = _Shift + Super + J_
       - Move window one workspace to the right = _Shift + Super + K_
       - Switch to workplace on the left = _Super + J_
       - Switch to workplace on the right = _Super + K_
     - _Windows_: Close windows = _Super + W_, Maximize Window = _Super + M_
     - _Custom Shortcuts_: Nautilus = _Super + E_, kgx = _Super + T_

### Tweaks

- **Keyboard**: _Additional Layout Options_ &rarr; _Caps Lock behavior_ &rarr; _Make Caps Lock an additional Esc_

### Firefox:

1. Install extensions: bitwarden & ublock
1. Change settings to privacy-friendly.

### Terminal:

If using alacritty, copy the folder from my github to ~/.config/alacritty/

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
   - change font in _gnome-tweaks_, then restart terminal (not needed in Alacritty)
1. **zsh4humans**
   - https://github.com/romkatv/zsh4humans
   - copy & paste, then configure
1. **zsh_aliases**
   - copy from github

### Neovim

```

sudo pacman -S --needed neovim npm ripgrep fd make xclip r python-neovim
sudo npm install -g neovim

```

Then copy config from [my github](https://github.com/polemaster/configs/tree/main) to _~/.config/nvim_.

### Bluetooth

```

systemctl start bluetooth.service
systemctl enable bluetooth.service

```

### NVIDIA pacman hook (for NVIDIA GPU)

This is needed in the rare case that only _nvidia_ package gets updated, without the kernel.  
As described [here](https://wiki.archlinux.org/title/NVIDIA#pacman_hook), edit file _/etc/pacman.d/hooks/nvidia.hook_:

```
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux

[Action]
Description=Updating NVIDIA module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux*) exit 0; esac; done; /usr/bin/mkinitcpio -P'
```

### Gnome Extensions

1. Install extension in the web browser on extensions.gnome.org website
2. `sudo pacman -S gnome-browser-connector`
3. Install extensions
   - IdeaPad

### Battery life

#### For everyone

```

sudo pacman -S tlp
systemctl start tlp.service
systemctl enable tlp.service

```

#### Only for Lenovo laptop users

Additionally, if you have a Lenovo laptop, you can go to [Arch wiki](https://wiki.archlinux.org/title/Laptop/Lenovo) for more info.
In my case, I needed to write in the terminal:
`echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`
and/or install _Ideapad_ extension (to enable _Conservation mode_).

### Installing packages

Create your own _pkglist.txt_ file containing all packages you would like to have.

#### Install packages from the file

`pacman -S --needed - < pkglist.txt`

#### Uninstall unnecessary packages

`pacman -Rsu $(comm -23 <(pacman -Qq | sort) <(sort pkglist.txt))`

#### AUR packages

First, install AUR helper: [_yay_](https://github.com/Jguer/yay).

```

pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
yay -Y --gendb
yay -Syu --devel
yay -Y --devel --save

```

Then, install your packages from _pkglist.txt_.

### Add various configs from my github

- **VSCodium**: _settings.json_ and _keybindings.json_, install vim extension
- **.editorconfig** file
- copy **mpv.conf** to a _.config/mpv_ directory

### Configure Wireshark

Add yourself do the _wireshark_ group:

```
sudo usermod -aG wireshark polemaster
```

### Adding yourself to groups _input_ and _video_

This fixes some issues, e.g. _snapshot_ (camera) app not detecting video inputs.

```

sudo usermod -a -G input,video polemaster

```

### Default applications

In gnome settings, some default applications can be changed.
Moreover, to change default pdf viewer and docx, type:

```
xdg-mime default org.gnome.Evince.desktop application/pdf
xdg-mime defualt libreoffice-writer.desktop application/vnd.openxmlformats-officedocument.wordprocessingml.document
```

### Steam

Enable _multilib_ in _/etc/pacman.conf_ if not enabled already.

```

sudo pacman -S steam

```

or

```

yay -S steam gamescope gamescope-session-steam-git

```

_gamescope_ provides an experimental HDR support. It needs to be [enabled on Steam](https://wiki.archlinux.org/title/HDR_monitor_support#Configure_Steam). AMD is better suited for HDR than NVIDIA.

### Adding printers

```

sudo pacman -S cups system-config-printer

```

More info here: https://wiki.archlinux.org/title/CUPS.
Then you can use GUI software (_Print Settings_) to add drivers and add printers.

### Setting up VirtualBox

Helpful link: https://wiki.archlinux.org/title/VirtualBox

1. `sudo pacman -S virtualbox virtualbox-host-modules-arch virtualbox-guest-iso` - Choose option depending on your [kernel](https://wiki.archlinux.org/title/VirtualBox#Install_the_core_packages).
1. `sudo usermod -aG vboxusers polemaster` - this enables the use of host USB devices
1. `yay -S virtualbox-ext-oracle` - for host camera usage (Oracle extension pack)
1. Reboot computer.

#### Adding Windows 11

1. Create new Virtual Machine
1. Change resolution - explained [here](https://www.ghacks.net/2022/06/11/how-to-change-the-windows-screen-size-in-virtualbox/). Then change scale to appropriate (200% in my case).
1. Shut down Windows and enable network in VirtualBox settings.
1. Start Windows.

### Installing CUDA

```
sudo pacman -S cuda cuda-tools
```

## Troubleshooting

### Sound not working

- Sound on PC:
  alsamixer -> select sound card and unmute
- Sound on Laptop with Intel:
  sudo pacman -S sof-firmware

### Printers not found

Add CUPS: https://wiki.archlinux.org/title/CUPS

### I want xorg instead of wayland

After start-up, in the login screen select _Gnome_ (_with Xorg_, if possible) instead of _Gnome-classic_

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

### Neovim treesitter giving warning

Solution:

```
sudo npm install -g tree-sitter-cli
```

### TPM2 troubleshooting

To check the current state of TPM:

```
sudo cryptsetup luksDump /dev/nvme0n1p2
```

To re-enroll TPM2 device:

```
sudo systemd-cryptenroll /dev/nvme0n1p2 --wipe-slot=tpm2
sudo systemd-cryptenroll /dev/nvme0n1p2 --tpm2-device=auto --tpm2-pcrs=7
```

To remove old recovery key and create a new one

```
sudo systemd-cryptenroll /dev/nvme0n1p2 --wipe-slot=recovery
sudo systemd-cryptenroll /dev/nvme0n1p2 --recovery-key
```

### Neovim not taking full terminal size (padding)

There is no perfect solution for this. Here are some [workarounds](https://www.reddit.com/r/neovim/comments/1d1443w/deleted_by_user/):  
"Change the size of the terminal (or the font). There is no space for one more column or row, so it shows that way. It's a common "issue" with terminal apps. You can also change the color of your terminal to look like neovim and so it won't be so noticeable."
