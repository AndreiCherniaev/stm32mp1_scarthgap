SUMMARY = "Recipe to install a custom file to the target filesystem"
DESCRIPTION = "Recipe created by bitbake-layers"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# Point BitBake to look for local files inside the 'files' directory
SRC_URI = "file://eglfs.json"

do_install() {
    # Create the destination directory on the target (e.g., /etc/custom/)
    install -d ${D}${sysconfdir}/qt6/
    # Install the file with specific permissions (0644 = read/write for owner, read for others)
    install -m 0644 ${WORKDIR}/eglfs.json ${D}${sysconfdir}/qt6/eglfs.json
}

# Ensure the installed file is packaged properly into the final image
FILES:${PN} += "${sysconfdir}/qt6/eglfs.json"
