#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root (using sudo)."
    exit 1
fi

# Update pkgfile database
sudo pkgfile -u

# --- Install yay ---
echo "Installing yay..."
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# --- Install Packages ---
echo "Installing packages from package_list..."
mapfile -t packages < <(grep -v '^$\|^\s*#' package_list.txt)

for pkg in "${packages[@]}"; do
    # Check if the package is found by pkgfile in a repository
    if pkgfile -b -s "$pkg" &> /dev/null; then
        # Package found in official repositories
        sudo pacman -S --noconfirm "$pkg"
    else
        # Assume it's an AUR package (or doesn't exist)
        yay -S --noconfirm "$pkg"
    fi
done

# --- Configure GRUB ---
echo "Configuring GRUB..."
sed -i '/^MODULES=/s/)/ nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/default/grub
sed -i 's/^GRUB_DISABLE_OS_PROBER=.*$/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# --- Manage Dotfiles ---
echo "Managing dotfiles with Stow..."
echo "Removing ~/.config/hyprland"
rm -rf ~/.config/hyprland
echo "Stowing .config"
stow .config

# --- Enable UFW ---
echo "Enabling and starting UFW..."
systemctl enable --now ufw

echo "Installation complete!"