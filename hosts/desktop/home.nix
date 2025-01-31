{ inputs, pkgs, ... }:

{
  imports = [
    ./../../home/sway.nix
    ./../../home/nixvim.nix
  ];
  home.username = "jonas";
  home.homeDirectory = "/home/jonas";
  home.stateVersion = "24.11";
  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
   };
  };

  home.packages = with pkgs; [
    tree
    grim
    slurp
    wmenu
    wl-clipboard
    osu-lazer-bin
    xfce.thunar 
    file-roller
    anki-bin 
    pavucontrol
  ];

  fonts.fontconfig.enable = true;
  programs.firefox.enable = true;

  # catppuccin.enable = true;
  # catppuccin.flavor = "macchiato";
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  qt = {
    enable = true;

    # These options are needed for catppuccin
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  gtk = {
    enable = true;
  };

  programs.fastfetch.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''[ "$(tty)" = "/dev/tty1" ] && uwsm start select''; 
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    terminal = "tmux-256color";
    escapeTime = 10;
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
    ];
  };

  programs.git = {
    enable = true;
    userName = "atomazu";
    userEmail = "contact@atomazu.org";
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        dpi-aware = "yes";
        font = "monospace:size=11";
      };

      mouse = {
        hide-when-typing = "yes";
      };
    }; 
  };

  wayland.windowManager.sway = {
    extraOptions = ["--unsupported-gpu"];

    config = {
      output = {
        DP-3 = {
          mode = "2560x1440@240hz";
          pos = "1440 0";
        };
        DP-4 = {
          mode = "2560x1440@144hz";
          pos = "0 0";
          transform = "270";
        };
      };
    };
  };
}
