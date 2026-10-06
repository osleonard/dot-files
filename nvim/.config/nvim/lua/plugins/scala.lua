vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/scalameta/nvim-metals" },
}, { load = true })

require("fidget").setup({})

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

local metals_config = require("metals").bare_config()

metals_config.settings = {
  serverVersion = "2.0.0-M19",
  serverProperties = { "-Xmx4g" },
  defaultBspToBuildTool = true,
  showImplicitArguments = true,
  showImplicitConversionsAndClasses = true,
  showInferredType = true,
  superMethodLensesEnabled = true,
  enableSemanticHighlighting = false,
  excludedPackages = {
    "akka.actor.typed.javadsl",
    "com.github.swagger.akka.javadsl",
    "akka.stream.javadsl",
    "akka.http.javadsl",
  },
}

metals_config.init_options = metals_config.init_options or {}
metals_config.init_options.statusBarProvider = "off"

-- Only set this if cmp-nvim-lsp is installed elsewhere.
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  metals_config.capabilities = cmp_nvim_lsp.default_capabilities()
end

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()

  local opts = { buffer = bufnr, silent = true }

   vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
     buffer = bufnr,
     silent = true,
     desc = "Goto Definition (Metals, no Telescope)",
   })

  vim.keymap.set(
    "n",
    "<space>c",
    function()
      require("telescope").extensions.metals.commands()
    end,
    opts
  )

  vim.keymap.set(
    "v",
    "K",
    function()
      require("metals").type_of_range()
    end,
    opts
  )

  vim.keymap.set(
    "n",
    "<leader>ws",
    function()
      require("metals").hover_worksheet({ border = "single" })
    end,
    opts
  )

  vim.keymap.set(
    "n",
    "<leader>tt",
    function()
      require("metals.tvp").toggle_tree_view()
    end,
    opts
  )

  vim.keymap.set(
    "n",
    "<leader>tr",
    function()
      require("metals.tvp").reveal_in_tree()
    end,
    opts
  )

  vim.keymap.set(
    "n",
    "<leader>st",
    function()
      require("metals").toggle_setting("showImplicitArguments")
    end,
    opts
  )
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.worksheet.sc",
  callback = function()
		vim.lsp.inlay_hint.enable(true)
  end,
  group = nvim_metals_group,
})

