## Install pipewire and remove pulseaudio:
https://wiki.archlinux.org/title/PipeWire
pacman -S pipewire wireplumber pipewire-alsa pipewire-pulse

## Sound
### Sound on PC:
alsamixer -> select sound card and unmute
### Sound on Laptop with Intel:
sudo pacman -S sof-firmware

## Add CUPS (for printers):
https://wiki.archlinux.org/title/CUPS

## Pacman configuration
### Uncomment these lines in /etc/pacman.conf:
Color
ParallelDownloads = 5
### And add this line:
ILoveCandy

### Faster mirrors:
install reflector
copy this to /etc/xdg/reflector/reflector.conf:
#### Set the output path where the mirrorlist will be saved (--save).
--save /etc/pacman.d/mirrorlist
#### Select the transfer protocol (--protocol).
--protocol http,https
#### Select the country (--country)
#### Consult the list of available countries with "reflector --list-countries" and
#### select the countries nearest to you or the ones that you trust. For example:
--country Germany
#### Use only the most recentyly synchronized mirrors (--latest).
--latest 20
#### Sort the mirrors by synchronization time (--sort).
--sort rate

## Disable wayland by editing:
/etc/gdm/custom.conf
This solves cursor problems (it doesn't change in firefox on wayland)

## Change keyboard layout:
Gnome setting -> Keyboard -> Click + -> Click ... -> Resize windows (it's bugged) to type 'polish'

## For dual boot with Windows if you have both systems on one drive:
sudo pacman -S os-prober
sudo os-prober (Windows should show, if not: sudo mkdir /mnt/win11 && sudo mount /dev/nvme0n1p1 /mnt/win11)
sudo grub-mkconfig -o /boot/grub/grub.cfg (if Windows not added edit /etc/defualt/grub: uncomment last line (GRUB_DISABLE_OS_PROBER=false) and rerun the command)

## Configure YubiKey - install:
* (optionally?) yubikey-manager or yubikey-manager-qt
* one or both of these: yubico-pam, pam-u2f

## Wireshark configuration:
sudo pacman -S wireshark-qt
https://wiki.wireshark.org/CaptureSetup/CapturePrivileges
Follow *Limiting capture permission to only one group* from the site above
