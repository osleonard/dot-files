return {
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "j-hui/fidget.nvim",
        opts = {},
      },
      {
        "mfussenegger/nvim-dap",
        config = function()
          local dap = require("dap")

          dap.configurations.scala = {
            {
              type = "scala",
              request = "launch",
              name = "RunOrTest",
              metals = {
                runType = "runOrTestFile",
              },
            },
            {
              type = "scala",
              request = "launch",
              name = "Test Target",
              metals = {
                runType = "testTarget",
              },
            },
          }
        end
      },
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.settings = {
	 defaultBspToBuildTool = true,
         showImplicitArguments = true,
         showImplicitConversionsAndClasses = true,
         showInferredType = true,
         superMethodLensesEnabled = true,
	 autoImportBuild = 'on',
	 excludedPackages = {
           "akka.actor.typed.javadsl",
           "com.github.swagger.akka.javadsl",
           "akka.stream.javadsl",
           "akka.http.javadsl",
         },
      }
      metals_config.init_options = {
        statusBarProvider = 'on',
      }
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
      metals_config.on_attach = function(client, bufnr)
        -- your on_attach function
        require("metals").setup_dap()
        vim.keymap.set("n", "<space>c", [[<cmd>lua require("telescope").extensions.metals.commands()<CR>]])
        vim.keymap.set("v", "K", [[<Esc><cmd>lua require("metals").type_of_range()<CR>]])
        vim.keymap.set("n", "<leader>ws", [[<cmd>lua require("metals").hover_worksheet({ border = "single" })<CR>]])
        vim.keymap.set("n", "<leader>tt", [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]])
        vim.keymap.set("n", "<leader>tr", [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]])
        vim.keymap.set("n", "<leader>st", [[<cmd>lua require("metals").toggle_setting("showImplicitArguments")<CR>]])
      end
      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  }
}
