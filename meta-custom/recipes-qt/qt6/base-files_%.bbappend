# Add the files directory to the search path and append the JSON file to source URI
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://eglfs.json"

# Append the install step to deploy it to the target file system environment
do_install:append() {
    # Create the /etc/qt6 directory on the target filesystem path ${D}
    install -d ${D}${sysconfdir}/qt6

    # Install the config file with proper read permissions (0644)
    install -m 0644 ${WORKDIR}/eglfs.json ${D}${sysconfdir}/qt6/eglfs.json
}

# Ensure the file gets correctly packaged into the final runtime output binary tracking list
FILES:${PN} += "${sysconfdir}/qt6/eglfs.json"
