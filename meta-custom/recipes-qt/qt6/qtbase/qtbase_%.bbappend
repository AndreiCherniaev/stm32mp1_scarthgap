# Append essential KMS/GBM EGLFS features
PACKAGECONFIG:append = " eglfs kms gbm gles2 fontconfig icu"

# Crucial for STM32MP1: Explicitly pass the hardware constraint down to the Qt 6 CMake compiler
# Failing to pass '-no-opengles3' will trigger compilation errors on modern Qt 6 builds
QT_CONFIG_FLAGS += " -no-opengles3"

# Force dependencies to guarantee that the hardware libdrm providers are populated
DEPENDS += "libdrm virtual/libgles2"
