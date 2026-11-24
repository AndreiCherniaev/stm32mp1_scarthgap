SUMMARY = "Hello World Qt6 Application"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS = "qtbase"

SRC_URI = " \
    file://CMakeLists.txt \
    file://main.cpp \
"

# In Yocto Scarthgap, local files unpack to ${WORKDIR} (or ${UNPACKDIR} in Styhead+)
S = "${WORKDIR}"

inherit qt6-cmake
