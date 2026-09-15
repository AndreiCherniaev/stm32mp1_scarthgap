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
## Work with bmaptool
```
bitbake-layers create-layer meta-custom-layer
mkdir -p "meta-custom-layer/wic/"
wcurl https://raw.githubusercontent.com/rauc/meta-rauc-community/refs/heads/master/meta-rauc-raspberrypi/files/wic/sdimage-dual-raspberrypi.wks.in -o "meta-custom-layer/wic/sdimage-dual-raspberrypi.wks.in"
Then
```
nano "/home/q/stm32mp1_scarthgap/build/conf/bblayers.conf"
```
and to the end of list add
```
${TOPDIR}/../meta-custom-layer \
```
## Build distro
```
source poky/oe-init-build-env
bitbake core-image-minimal
```
## Error
```
WARNING: Host distribution "ubuntu-24.04" has not been validated with this version of the build system; you may possibly experience unexpected failures. It is recommended that you use a tested distribution.
Loading cache: 100% |                                                                                                                                                                                                                                                                                 | ETA:  --:--:--
Loaded 0 entries from dependency cache.
Parsing recipes: 100% |################################################################################################################################################################################################################################################################################| Time: 0:00:56
Parsing of 2514 .bb files complete (0 cached, 2514 parsed). 4387 targets, 141 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION           = "2.8.0"
BUILD_SYS            = "x86_64-linux"
NATIVELSBSTRING      = "universal"
TARGET_SYS           = "arm-poky-linux-gnueabi"
MACHINE              = "stm32mp1"
DISTRO               = "poky"
DISTRO_VERSION       = "5.0.1"
TUNE_FEATURES        = "arm vfp cortexa7 neon vfpv4 thumb callconvention-hard"
TARGET_FPU           = "hard"
meta                 
meta-poky            
meta-yocto-bsp       = "heads/scarthgap-5.0.1:4b07a5316ed4b858863dfdb7cab63859d46d1810"
meta-oe              
meta-python          = "scarthgap:b0c2c648a1af89e7a8dd4c2ec841f3bc0ed0ccb9"
meta-st-stm32mp      = "HEAD:b820cf3a1a855d2bd95969251e6465e281502759"
meta-custom-layer    = "main:3309fc95a985b6e73b459d8c499bcbe6303df4d6"

Sstate summary: Wanted 6 Local 0 Mirrors 0 Missed 6 Current 1966 (0% match, 99% complete)##################################################################################################################################################################################                            | ETA:  0:00:00
Initialising tasks: 100% |#############################################################################################################################################################################################################################################################################| Time: 0:00:02
NOTE: Executing Tasks
ERROR: core-image-minimal-1.0-r0 do_image_wic: ExecutionError('/home/q/stm32mp1_scarthgap/build/tmp/work/stm32mp1-poky-linux-gnueabi/core-image-minimal/1.0/temp/run.do_image_wic.1533678', 1, None, None)
ERROR: Logfile of failure stored in: /home/q/stm32mp1_scarthgap/build/tmp/work/stm32mp1-poky-linux-gnueabi/core-image-minimal/1.0/temp/log.do_image_wic.1533678
Log data follows:
| DEBUG: Executing python function extend_recipe_sysroot
| NOTE: Direct dependencies are ['/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-core/glibc/cross-localedef-native_2.39.bb:do_populate_sysroot', '/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-core/glibc/ldconfig-native_2.12.1.bb:do_populate_sysroot', '/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/binutils/binutils-cross_2.42.bb:do_populate_sysroot', '/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/cdrtools/cdrtools-native_3.01.bb:do_populate_sysroot', '/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/qemu/qemuwrapper-cross_1.0.bb:do_populate_sysroot', '/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-kernel/kmod/depmodwrapper-cross_1.0.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-core/update-rc.d/update-rc.d_0.8.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/btrfs-tools/btrfs-tools_6.7.1.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/createrepo-c/createrepo-c_1.0.4.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/dnf/dnf_4.19.0.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/dosfstools/dosfstools_4.2.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/e2fsprogs/e2fsprogs_1.47.0.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/erofs-utils/erofs-utils_1.7.1.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/fdisk/gptfdisk_1.0.9.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/makedevs/makedevs_1.0.1.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/mtools/mtools_4.0.43.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/opkg-utils/opkg-utils_0.6.3.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/pseudo/pseudo_git.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/rpm/rpm_4.19.1.1.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/squashfs-tools/squashfs-tools_git.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-devtools/syslinux/syslinux_6.04-pre2.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-extended/parted/parted_3.6.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-extended/pigz/pigz_2.8.bb:do_populate_sysroot', 'virtual:native:/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-support/bmaptool/bmaptool_git.bb:do_populate_sysroot']
| NOTE: Installed into sysroot: []
| NOTE: Skipping as already exists in sysroot: ['tf-a-stm32mp', 'u-boot-stm32mp', 'optee-os-stm32mp', 'gettext-minimal-native', 'cross-localedef-native', 'glibc', 'ldconfig-native', 'binutils-cross-arm', 'cdrtools-native', 'cmake-native', 'gcc-runtime', 'libgcc', 'gdb-cross-arm', 'libtool-native', 'm4-native', 'qemu-native', 'qemuwrapper-cross', 'texinfo-dummy-native', 'depmodwrapper-cross', 'linux-libc-headers', 'libusb-compat-native', 'openocd-stm32mp-native', 'sdcard-raw-tools-native', 'stm32wrapper4dbg-native', 'hidapi-stm32mp-native', 'openssl-native', 'coreutils-native', 'expat-native', 'gettext-native', 'glib-2.0-native', 'libxml2-native', 'ncurses-native', 'readline-native', 'update-rc.d-native', 'util-linux-libuuid-native', 'util-linux-native', 'zlib-native', 'btrfs-tools-native', 'createrepo-c-native', 'dnf-native', 'dosfstools-native', 'e2fsprogs-native', 'elfutils-native', 'erofs-utils-native', 'gptfdisk-native', 'file-native', 'flex-native', 'gnu-config-native', 'json-c-native', 'libcomps-native', 'libdnf-native', 'libedit-native', 'libmodulemd-native', 'librepo-native', 'lua-native', 'make-native', 'makedevs-native', 'mtd-utils-native', 'mtools-native', 'nasm-native', 'opkg-utils-native', 'perl-native', 'pseudo-native', 'python3-build-native', 'python3-flit-core-native', 'python3-iniparse-native', 'python3-installer-native', 'python3-packaging-native', 'python3-pyproject-hooks-native', 'python3-setuptools-native', 'python3-six-native', 'python3-wheel-native', 'python3-native', 'rpm-native', 'squashfs-tools-native', 'swig-native', 'syslinux-native', 'bc-native', 'bzip2-native', 'groff-native', 'libarchive-native', 'libidn2-native', 'libnsl2-native', 'libsolv-native', 'libtirpc-native', 'lzlib-native', 'parted-native', 'pigz-native', 'shadow-native', 'unzip-native', 'xz-native', 'zstd-native', 'gobject-introspection-native', 'kmod-native', 'acl-native', 'attr-native', 'bmaptool-native', 'curl-native', 'debianutils-native', 'gdbm-native', 'gmp-native', 'gnutls-native', 'libtasn1-native', 'gpgme-native', 'libassuan-native', 'libbsd-native', 'libcap-ng-native', 'libcap-native', 'libcheck-native', 'libffi-native', 'libgcrypt-native', 'libgpg-error-native', 'libmd-native', 'libmicrohttpd-native', 'libpcre2-native', 'libunistring-native', 'libusb1-native', 'libyaml-native', 'lz4-native', 'lzo-native', 'mpfr-native', 'nettle-native', 'popt-native', 'sqlite3-native']
| DEBUG: Python function extend_recipe_sysroot finished
| DEBUG: Executing python function set_image_size
| DEBUG: 12636.000000 = 9720 * 1.300000
| DEBUG: 12636.000000 = max(12636.000000, 8192)[12636.000000] + 0
| DEBUG: 12636.000000 = int(12636.000000)
| DEBUG: 12636 = aligned(12636)
| DEBUG: returning 12636
| DEBUG: Python function set_image_size finished
| DEBUG: Executing shell function do_image_wic
| INFO: Creating image(s)...
| 
| WARNING: bootloader config not specified, using defaults
| 
| ERROR: No boot files defined, IMAGE_BOOT_FILES unset for entry #1
| 
| WARNING: exit code 1 from a shell command.
ERROR: Task (/home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-core/images/core-image-minimal.bb:do_image_wic) failed with exit code '1'
NOTE: Tasks Summary: Attempted 4319 tasks of which 4317 didn't need to be rerun and 1 failed.

Summary: 1 task failed:
  /home/q/stm32mp1_scarthgap/build/../poky/meta/recipes-core/images/core-image-minimal.bb:do_image_wic
Summary: There was 1 WARNING message.
Summary: There was 1 ERROR message, returning a non-zero exit code.
```
