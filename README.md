How to build Poky operating system for STM32MP1.
## Install deps
Tested on Ubuntu 24
```
sudo apt install -y build-essential chrpath cpio debianutils diffstat file gawk gcc git iputils-ping libacl1 liblz4-tool locales python3 python3-git python3-jinja2 python3-pexpect python3-pip python3-subunit socat texinfo unzip wget xz-utils zstd
```
## Clone
```
git clone --remote-submodules --recurse-submodules https://github.com/AndreiCherniaev/stm32mp1_scarthgap.git
cd stm32mp1_scarthgap
```
## Build distro
```
source poky/oe-init-build-env
bitbake core-image-minimal
```
