vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
}, { load = true })

require("mason").setup({})

local servers = {
--  dockerls = {},
--  terraformls = {},
	gopls = {
	  settings = {
	    gopls = {
	      gofumpt = true,
	      staticcheck = true,
	      usePlaceholders = true,
	      analyses = {
	        unusedparams = true,
	        unusedwrite = true,
	        nilness = true,
	        shadow = true,
	      },
	    },
	  },
	},	
--  ts_ls = {},
  kotlin_lsp = {
		root_markers = {
			"settings.gradle",
      "settings.gradle.kts",
      "pom.xml",
      "build.gradle",
      "build.gradle.kts",
		}
	},
--  lua_ls = {
--    settings = {
--      Lua = {
--        completion = {
--          callSnippet = "Replace",
--        },
--      },
--    },
--  },
}

local ensure_installed = vim.tbl_keys(servers)

-- Extra non-LSP tools can also go here, for example:
-- vim.list_extend(ensure_installed, {
--   "stylua",
--   "goimports",
-- })

require("mason-tool-installer").setup({
  ensure_installed = ensure_installed,
})

-- Keep mason-lspconfig, but stop it from auto-enabling servers.
-- We enable them ourselves below with vim.lsp.enable().
require("mason-lspconfig").setup({
  ensure_installed = ensure_installed,
  automatic_enable = false,
})

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end
