-- Neovim init based on kickstart.nvim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basic settings
vim.opt.number = true        -- Show line numbers
vim.opt.tabstop = 4          -- Number of spaces tabs count for
vim.opt.shiftwidth = 4       -- Number of spaces used for (auto)indent
vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.wrap = false         -- Disable line wrapping
vim.opt.mouse = 'a'          -- Enable mouse mode
vim.opt.breakindent = true   -- Enable break indent
vim.opt.timeoutlen = 300     -- Shrink wait time so which-key will show sooner
vim.opt.inccommand = 'split' -- Preview substitutions live
vim.opt.scrolloff = 10       -- Min number of screen lines around cursor
vim.opt.undofile = true      -- Save undo history

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- Lazy.nvim setup
require('lazy').setup({
  { 'folke/which-key.nvim', opts = {} },
  { 'sainnhe/everforest',
      priority = 1000,
      init = function()
          vim.cmd.colorscheme 'everforest'
          vim.cmd.hi 'Comment gui=none'
      end,
  },
  { 'nvim-treesitter/nvim-treesitter', opts = { 
      run = ':TSUpdate' } },
  { 'hrsh7th/nvim-cmp', config = function() 
      local cmp = require('cmp')
      cmp.setup({
          snippet = {
              expand = function(args)
                  vim.fn['vsnip#anonymous'](args.body) -- For vsnip users
              end,
          },
          mapping = {
              ['<C-k>'] = cmp.mapping.select_prev_item(),
              ['<C-j>'] = cmp.mapping.select_next_item(),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.close(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
          },
          sources = {
              { name = 'nvim_lsp' },
              { name = 'buffer' },
          },
      })
  end },
  { 'hrsh7th/cmp-nvim-lsp', opts = {} },
  { 'nvim-lua/plenary.nvim' },  -- No options needed
  { 'nvim-telescope/telescope.nvim', opts = { 
      requires = { 'nvim-lua/plenary.nvim' } } },
  { 'williamboman/mason.nvim', opts = {} },
  { 'williamboman/mason-lspconfig.nvim', opts = {} },
  { 'WhoIsSethDaniel/mason-tool-installer.nvim', opts = {
      ensure_installed = { 'stylua', 'clangd'} } },
  { 'stevearc/conform.nvim', opts = {} },
  { 'neovim/nvim-lspconfig', config = function() 
      local lspconfig = require('lspconfig')
      lspconfig.clangd.setup{}
  end },
})

-- Setup which-key
require('which-key').setup {}

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = {
      "bash",
      "c",
      "cpp",
      "diff",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "query",
      "vim",
      "vimdoc",
  },
  highlight = {
      enable = true,
  },
}

