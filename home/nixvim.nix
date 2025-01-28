{ ... }:

{
  programs.nixvim = {
    enable = true;

    opts = {
      number = true;
      relativenumber = true;
      splitright = true;
      splitbelow = true;

      tabstop = 2;
      shiftwidth = 2;
      cursorline = true;
      scrolloff = 10;
      expandtab = true;
      autoindent = true;
    };

    colorschemes.catppuccin.enable = true;
    clipboard.register = "unnamedplus";

    plugins = {
      web-devicons.enable = true;
      lualine.enable = true;
      treesitter.enable = true;
      telescope.enable = true;
      telescope.extensions.fzf-native.enable = true;
      tmux-navigator.enable = true;

      oil.enable = true;
      commentary.enable = true;
      nix.enable = true;
      bufferline.enable = true;
      
      lsp-format.enable = true;
      lsp-signature.enable = true;
      lsp-status.enable = true;
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          nixd.enable = true;
        };
      };
      
      cmp.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;

      nvim-surround.enable = true;
      nvim-autopairs.enable = true;

      dashboard.enable = true;
      noice.enable = true;
      dressing.enable = true;
      colorizer.enable = true;
      which-key.enable = true;

      cmake-tools.enable = true;
      toggleterm.enable = true;
    };

    keymaps = [
      {
         key = "<leader>ff";
         action = "<cmd>Telescope find_files<CR>";
         mode = "n";
         options = { silent = true; };
      }
    ];
  };
}
