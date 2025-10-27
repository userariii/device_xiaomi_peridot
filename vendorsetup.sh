#!/bin/bash
# thanks @Krtonia for the script :)

# Define colour codes
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
NC="\033[0m" # No Color

fatal() {
    echo -e "${RED}[FATAL] $1${NC}"
    return 1
}

info() {
    echo -e "${CYAN}$1${NC}"
}

success() {
    echo -e "${GREEN}$1${NC}"
}

warn() {
    echo -e "${YELLOW}$1${NC}"
}

# Ask for input 
read -p "Do you want to clone your device resource? (yes/no): " choice

# accept only lower case
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

if [ "$choice" = "yes" ]; then
    info "Cloning all resources..."

    # Vendor
    warn "Cleaning vendor directory..."
    rm -rf vendor/xiaomi/peridot
    info "Cloning vendor tree..."
    git clone -b fifteen --depth 1 https://github.com/Blazing-Forest/vendor_xiaomi_peridot.git vendor/xiaomi/peridot || fatal "Vendor tree clone failed!"

    # Kernel sources
    warn "Cleaning kernel directory..."
    rm -rf kernel/xiaomi/sm8635
    info "Cloning kernel sources..."
    #git clone -b sixteen --depth 1 https://github.com/Blazing-Forest/kernel_xiaomi_mugetsu.git kernel/xiaomi/sm8635 || fatal "Kernel source clone failed!"

    # Kernel modules
    warn "Cleaning kernel modules directory..."
    rm -rf kernel/xiaomi/sm8635-modules
    info "Cloning kernel modules..."
    #git clone -b sixteen --depth 1 https://github.com/Blazing-Forest/kernel_xiaomi_sm8635-modules.git kernel/xiaomi/sm8635-modules || fatal "Kernel modules clone failed!"

    # Kernel devicetrees
    warn "Cleaning kernel devicetrees directory..."
    rm -rf kernel/xiaomi/sm8635-devicetrees
    info "Cloning kernel devicetrees..."
    #git clone -b sixteen --depth 1 https://github.com/Blazing-Forest/kernel_xiaomi_sm8635-devicetrees.git kernel/xiaomi/sm8635-devicetrees || fatal "Kernel devicetrees clone failed!"

    # Hardware xiaomi
    warn "Cleaning hardware/xiaomi directory..."
    rm -rf hardware/xiaomi
    info "Cloning hardware xiaomi"
    git clone -b lineage-23.0-peridot https://github.com/Blazing-Forest/hardware_xiaomi.git hardware/xiaomi || fatal "Hardware xiaomi clone failed!"

    # Priv Keys
    rm -rf vendor/priv-keys
    info "Cloning priv-keys..."
    git clone https://github.com/TheCloverProject-Devices/vendor_clover-priv.git vendor/clover-priv || fatal "cloning keys failed!"

    # Mi Cam
    warn "Cleaning camera directory..."
    rm -rf device/xiaomi/peridot-miuicamera
    rm -rf vendor/xiaomi/peridot-miuicamera
    info "Cloning Miui Camera"
    #git clone -b sixteen https://github.com/Blazing-Forest/device_xiaomi_peridot-miuicamera.git device/xiaomi/peridot-miuicamera || fatal "Mi Cam clone failed"
    #git clone -b sixteen https://github.com/Blazing-Forest/vendor_xiaomi_peridot-miuicamera.git vendor/xiaomi/peridot-miuicamera || fatal "Mi Cam clone failed"

    # Dolby
    warn "Cleaning Dolby if exists"
    rm -rf packages/apps/XiaomiDolby
    info "Cloning Ximi Dolby"
    git clone -b sixteen https://github.com/Blazing-Forest/packages_apps_XiaomiDolby packages/apps/XiaomiDolby || fatal "Dolby clone failed"

    success "All resources cloned successfully!"

elif [ "$choice" = "no" ]; then
    warn "Skipping clone..."
else
    fatal "Invalid choice. Please type yes or no."
fi

echo -e "${BLUE}ctrl + C and ctrl + V moment...\n\nlunch lineage_peridot-bp2a-userdebug\n${NC}"

return 0