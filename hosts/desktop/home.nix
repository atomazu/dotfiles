{ config, pkgs, inputs, ... }:

{
  imports = [
    ./programs/vim.nix
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
  ];

  programs.starship.enable = true;
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
    ];
  };

    programs.git = {
    enable = true;
    userName = "atomazu";
    userEmail = "contact@atomazu.org";
  };
}
