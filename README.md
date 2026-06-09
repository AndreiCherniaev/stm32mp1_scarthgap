How to build Poky operating system for STM32MP1.
## Install deps
Tested on Ubuntu 24 (build fails on Ubuntu 26.04)
```
sudo apt install -y build-essential chrpath cpio debianutils diffstat file gawk gcc git iputils-ping libacl1 liblz4-tool locales python3 python3-git python3-jinja2 python3-pexpect python3-pip python3-subunit socat texinfo unzip wget xz-utils zstd
```
## Clone
```
git clone --remote-submodules --recurse-submodules https://github.com/AndreiCherniaev/stm32mp1_scarthgap.git
cd stm32mp1_scarthgap
```
## Avoiding unprivileged user namespace restrictions
Ubuntu 24.04 added an apparmor policy preventing usage of unprivileged user namespace restrictions to improve security. Unfortunately this prevents bitbake from working, because it uses namespaces to forbid untracked downloads outside of the do_fetch task. Ironically, bitbake does this to improve security. This results in the following error message:
```
ERROR: User namespaces are not usable by BitBake, possibly due to AppArmor.
See https://discourse.ubuntu.com/t/ubuntu-24-04-lts-noble-numbat-release-notes/39890#unprivileged-user-namespace-restrictions for more information.
```
To disable this apparmor restriction
```
echo 0 | sudo tee /proc/sys/kernel/apparmor_restrict_unprivileged_userns
```
You will need to run this command every time you reboot your machine.
## Build distro
```
source poky/oe-init-build-env
bitbake core-image-minimal
```
## Create image
```
cd tmp/deploy/images/stm32mp1/scripts
./create_sdcard_from_flashlayout.sh "../flashlayout_core-image-minimal/extensible/FlashLayout_sdcard_stm32mp157f-dk2-extensible.tsv"
```
## Write image
```
sudo dd if="$HOME/stm32mp1/build/tmp/deploy/images/stm32mp1/FlashLayout_sdcard_stm32mp157f-dk2-extensible.raw" of="/dev/disk/by-id/usb-Generic_STORAGE_DEVICE-0:0" bs=4M conv=fsync status=progress
```
