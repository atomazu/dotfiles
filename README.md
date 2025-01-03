## Misc. Setup Quirks

1. System needs this to be set in Grub:
> MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)

2. GitHub repo url is
> git@github.com:atomazu/dotfiles.git

3. Use stow to link the dotfiles to .config
> stow .config

4. Install yay using the following command:
> sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

5. Enable OSProber in Grub config.
> GRUB_DISABLE_OS_PROBER=false