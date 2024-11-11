-- Basic settings
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = false -- Show relative line numbers
vim.opt.mouse = 'a'          -- Enable mouse support
vim.opt.ignorecase = true    -- Case insensitive search
vim.opt.smartcase = true     -- But case sensitive when uppercase present
vim.opt.hlsearch = true      -- Highlight search results
vim.opt.wrap = true          -- Wrap long lines
vim.opt.breakindent = true   -- Preserve indentation in wrapped text
vim.opt.tabstop = 4          -- Tab width
vim.opt.shiftwidth = 4       -- Indentation width
vim.opt.expandtab = true     -- Convert tabs to spaces
vim.opt.termguicolors = true -- True color support

-- Basic key mappings
vim.g.mapleader = " "        -- Set leader key to space

-- Basic status line
vim.opt.statusline = " %f %m %= %l:%c "

-- Make background transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermbg = "NONE" })
