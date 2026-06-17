local g = vim.g
local global_opt = vim.opt_global
local map = vim.keymap.set
local opt = vim.opt
local cmd = vim.cmd

local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

vim.loader.enable()

-- Leader map
g.mapleader = ","

-- no banner on netrw
g.netrw_banner = 0

vim.pack.add{{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" }}
cmd("colorscheme catppuccin-nvim")

-- global
global_opt.termguicolors = true
global_opt.hidden = true
global_opt.showtabline = 1
global_opt.updatetime = 300
global_opt.showmatch = true
global_opt.laststatus = 2
global_opt.wildignore = { ".git", "*/node_modules/*", "*/target/*", ".metals", ".bloop", ".ammonite" }
global_opt.ignorecase = true
global_opt.smartcase = true
global_opt.clipboard = "unnamed"
global_opt.completeopt = { "menuone",  "noselect", "popup" }
global_opt.scrolloff = 5
global_opt.number = true
global_opt.spell  = true
global_opt.guifont = "Fira Code 14"

opt.mouse = 'a'

opt.shortmess = {
  t = true, -- truncate file messages at start
  A = true, -- ignore annoying swap file messages
  o = true, -- file-read message overwrites previous
  O = true, -- file-read message overwrites previous
  T = true, -- truncate non-file messages in middle
  f = true, -- (file x of x) instead of just (x of x
  F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
  s = true,
  c = true,
  W = true, -- Don't show [w] or written when writing
}



-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
map("n", "-", vim.cmd.Ex)


augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

-- load plugins
require("plugins.telescope").setup()
require("plugins.gitsigns")
require("plugins.autopairs")
require("plugins.treesitter")
require("plugins.mason")
require("plugins.scala")
require("plugins.go")
require("lsp")
--require("lsp").setup()


