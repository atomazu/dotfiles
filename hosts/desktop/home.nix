{ config, pkgs, inputs, ... }:

{
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

  programs.starship.enable = true;
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
    ];
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      nerdtree
      vim-fugitive
      vim-nix
      syntastic
      vim-commentary
      auto-pairs
    ];
    settings = {
      number = true;
      tabstop = 2;
      relativenumber = true;
      shiftwidth = 2;
      expandtab = true;
    };
    extraConfig = ''
      set nocompatible
      filetype plugin indent on
      let NERDTreeShowHidden=1
      syntax on

      map <C-n> :NERDTreeToggle<CR>
      let g:airline#extensions#tabline#enabled = 1
      let g:airline_powerline_fonts = 1
      inoremap jj <esc>
    '';
  };

  programs.git = {
    enable = true;
    userName = "atomazu";
    userEmail = "contact@atomazu.org";
  };
}
