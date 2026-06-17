vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",

  {
    src = "https://github.com/olimorris/codecompanion.nvim",
    name = "codecompanion.nvim",
    version = vim.version.range("^19.0.0"),
  },
}, { load = true })

if vim.fn.executable("codex-acp") == 0 then
  vim.notify(
    "codex-acp is not on PATH. Install the native binary/Homebrew package first.",
    vim.log.levels.WARN
  )
end

require("codecompanion").setup({
  adapters = {
    acp = {
      codex = function()
        return require("codecompanion.adapters").extend("codex", {
          commands = {
            default = {
              "codex-acp",
            },
          },

          defaults = {
            auth_method = "chatgpt",
          },
        })
      end,
    },
  },

  interactions = {
    chat = {
      adapter = {
        name = "codex",
      },
    },
  },

  opts = {
    log_level = "INFO",
  },
})

local map = vim.keymap.set

map({ "n", "v" }, "<leader>cca", "<cmd>CodeCompanionActions<cr>", {
  desc = "CodeCompanion actions",
  silent = true,
})

map("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", {
  desc = "Toggle CodeCompanion chat",
  silent = true,
})

map("v", "<leader>cc", "<cmd>CodeCompanionChat Add<cr>", {
  desc = "Add selection to CodeCompanion chat",
  silent = true,
})

map("n", "<leader>cn", "<cmd>CodeCompanionChat<cr>", {
  desc = "New CodeCompanion chat",
  silent = true,
})

map("n", "<leader>ccr", "<cmd>CodeCompanionChat RefreshCache<cr>", {
  desc = "Refresh CodeCompanion cache",
  silent = true,
})

vim.cmd([[cab cc CodeCompanion]])
