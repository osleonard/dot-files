require('packer').startup(function(use)
  -- Packer can manage itself
  use {
    "wbthomason/packer.nvim",
    config = require("plugins.packer").setup()
  }
  
  use({ "simrat39/rust-tools.nvim" })
  use {'sheerun/vim-polyglot'}
  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = require("plugins.treesitter").setup() }
  use {'fatih/vim-go',  run = ':GoUpdateBinaries' }
  use {'kyazdani42/nvim-web-devicons'}
  use {'dracula/vim', as = 'dracula'}
  use { "neovim/nvim-lspconfig" }
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
    config = require("plugins.telescope").setup()
  }
 use {
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  }
 use {
       "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
 }
 use {"tpope/vim-vinegar"}
 use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
    },
    config = function()
      require ("plugins.cmp").setup()
    end,
  })

end)
