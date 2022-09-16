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
g.mapleader = ','
g.maplocalleader = ' '

local f = require("functions")
local map = f.map
local opt = vim.opt
local global_opt = vim.opt_global

-- load plugins
require("plugins")
require("lsp").setup()

local indent = 2

-- global
global_opt.shortmess:remove("F"):append("c")
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
global_opt.laststatus = 3
global_opt.number = true

cmd("colorscheme dracula")

