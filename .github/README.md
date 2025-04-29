# My Dotfiles

Hey there! This repository holds my personal configuration files (dotfiles), managed with [yadm](https://yadm.io/). They're set up for my Arch Linux system running the [Hyprland](https://hyprland.org/) Wayland compositor.

This is very much *my* personal setup, reflecting how I like things configured.

## How Things Are Organized (Conceptually)

Instead of one big file, the configuration is split across different areas, mostly following standard conventions:

1.  **Core Application Settings (`.config/`):** This is the main hub. You'll find configurations here for key graphical components like:
    *   **Hyprland:** The window manager itself, including rules, device-specific tweaks (laptop vs. desktop), startup scripts, and wallpaper management (`hyprpaper`).
    *   **Waybar:** The status bar, with distinct styles including a custom "compact mode".
    *   **Albert:** The application launcher, with its settings and defined web search engines.
    *   **Foot:** My terminal emulator.
    *   **Mako:** The notification daemon.
    *   **Fastfetch:** The system information tool, including a custom logo.
    *   **GTK & Qt:** Basic theme settings for application toolkits.

2.  **Shell & Terminal Tools (Dotfiles in Home):** Configurations for command-line tools reside directly in the home directory:
    *   `.zshrc`: Zsh shell setup (using Oh My Zsh).
    *   `.vimrc`: Vim editor configuration (using vim-plug).
    *   `.tmux.conf`: Tmux terminal multiplexer settings.

3.  **Custom Themes & Data (`.local/share/`):** Some application-specific data or themes that don't belong in `.config` live here, like my custom Albert theme.

4.  **Helper Scripts (`.config/hypr/scripts/`, `.config/uwsm/`):** Various shell scripts assist with functionality:
    *   Hyprland scripts handle things like screenshots (`hyprshot.sh`), toggling night light (`sunset_toggle.sh`), and cycling wallpapers (`paper_cycle.sh`).
    *   UWSM appears to be my custom set of scripts for managing the session environment and starting services correctly within Hyprland.

5.  **Repository Assets (`.github/`):** Contains this README and the screenshots shown below.

## Key Features & Highlights

*   **Hyprland:** Tailored setup with different configurations for my desktop and laptop.
*   **Waybar Compact Mode:** A script toggles Waybar between a standard and a minimal, compact appearance.
*   **Custom Albert Theme:** A personalized look for the Albert launcher.
*   **UWSM:** My scripts for managing environment variables (like GPU-specific ones) and launching session applications.

## Screenshot

![default_desktop](https://github.com/atomazu/dotfiles/blob/master/.github/default_desktop.png)
