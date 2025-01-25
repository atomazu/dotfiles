{ pkgs, ... }:

{
  imports = [
    ./../../home/vim.nix
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
    fastfetch
    foot
    swaybg
    swaylock
    swayidle 
    mako
    wl-clipboard
    grim
    slurp
    wmenu
    osu-lazer-bin
  ];

  fonts.fontconfig.enable = true;
  programs.firefox.enable = true;

  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  gtk = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''[ "$(tty)" = "/dev/tty1"  ] && uwsm start select''; 
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  # programs.fzf = {
  #   enable = true;
  #   enableBashIntegration = true;
  # };

  catppuccin.enable = true;
  catppuccin.flavor = "macchiato";

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
    # settings = {
    #   main = {
    #     dpi-aware = "yes";
    #   };
    # }; 
  };
}
