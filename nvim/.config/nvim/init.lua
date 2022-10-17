-- lets ensure packer is installed

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

 if packer_bootstrap then
    require('packer').sync()
 end

local api = vim.api
local cmd = vim.cmd
local g = vim.g


-- Leader map
g.mapleader = ","

g.netrw_banner = 0

local f = require("functions")
local map = f.map
local opt = vim.opt
local global_opt = vim.opt_global

-- load plugins
require("plugins")
require("lsp").setup()

local indent = 2

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
global_opt.completeopt = { "menuone", "noinsert", "noselect" }
global_opt.scrolloff = 5
global_opt.number = true
global_opt.spell  = true
global_opt.guifont = "Fira Code 14"


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
vim.diagnostic.config({
  virtual_text = false
})
vim.cmd [[
set signcolumn=yes
autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
]]


cmd("colorscheme dracula")

-- custom mappings 
map("n", "<leader>v", " <C-w>v<C-w>l")
map("n", "<leader>h", " <C-w>s<C-w>j")

