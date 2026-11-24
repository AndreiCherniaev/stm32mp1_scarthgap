# Append essential KMS/GBM EGLFS features
PACKAGECONFIG:append = " eglfs gbm kms libinput"
	
# Crucial for STM32MP1: Explicitly pass the hardware constraint down to the Qt 6 CMake compiler
# Failing to pass '-no-opengles3' will trigger compilation errors on modern Qt 6 builds
QT_CONFIG_FLAGS += " -no-opengles3"

# Force dependencies to guarantee that the hardware libdrm providers are populated
DEPENDS += "libdrm virtual/libgles2"

PACKAGECONFIG:remove = "tests examples"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://eglfs.json"
do_install:append() {
    install -d ${D}${sysconfdir}/qt6
    install -m 0644 ${WORKDIR}/eglfs.json ${D}${sysconfdir}/qt6/eglfs.json
}
FILES:${PN} += "${sysconfdir}/qt6/eglfs.json"
