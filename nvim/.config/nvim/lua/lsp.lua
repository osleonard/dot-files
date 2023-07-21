local api = vim.api
local f = require('functions')

local map = f.map


local setup = function()
  local lsp_config = require("lspconfig")
  local bare_capabilities = vim.lsp.protocol.make_client_capabilities()
  local capabilities = require("cmp_nvim_lsp").default_capabilities(bare_capabilities)

  lsp_config.util.default_config = vim.tbl_extend("force", lsp_config.util.default_config, {
    capabilities = capabilities,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

  local lsp_group = api.nvim_create_augroup("lsp", { clear = true })

  local on_attach = function(client, bufnr)
    map("n", "gD", [[<cmd>lua vim.lsp.buf.definition()<CR>]])
    map("n", "K", [[<cmd>lua vim.lsp.buf.hover()<CR>]])
    map("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
    map("n", "gr", [[<cmd>lua vim.lsp.buf.references()<CR>]])
    map("n", "gds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
    map("n", "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
    map("n", "<space>e", [[<cmd>lua vim.diagnostic.open_float({scope="line"})<CR>]])
    map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
    map("n", "<leader>rn", [[<cmd>lua vim.lsp.buf.rename()<CR>]])
    map("n", "<leader>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
    map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
    map("n", "<leader>f", [[<cmd>lua vim.lsp.buf.format({ async = true })<CR>]])
    map("n", "<leader>aa", [[<cmd>lua vim.diagnostic.setqflist()<CR>]]) -- all workspace diagnostics
    map("n", "<leader>ae", [[<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]]) -- all workspace errors
    map("n", "<leader>aw", [[<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]]) -- all workspace warnings
    map("n", "<leader>d", "<cmd>lua vim.diagnostic.setloclist()<CR>") -- buffer diagnostics only
    map("n", "[c", "<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>")
    map("n", "]c", "<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>")
    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  end

  --================================
  -- Metals specific setup
  --================================
  local metals_config = require("metals").bare_config()
  metals_config.tvp = {
    icons = {
      enabled = true
    }
  }

  metals_config.settings = {
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    showInferredType = true,
    excludedPackages = {
      "akka.actor.typed.javadsl",
      "com.github.swagger.akka.javadsl",
      "akka.stream.javadsl",
      "akka.http.javadsl",
    },
    fallbackScalaVersion = "2.13.10",
    serverVersion = "1.0.0",
  }

  metals_config.init_options.statusBarProvider = "on"
  metals_config.capabilities = capabilities

  metals_config.on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    -- Metals specific mappings
    map("v", "K", [[<Esc><cmd>lua require("metals").type_of_range()<CR>]])
    map("n", "<leader>ws", [[<cmd>lua require("metals").hover_worksheet({ border = "single" })<CR>]])
    map("n", "<leader>tt", [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]])
    map("n", "<leader>tr", [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]])
    map("n", "<leader>st", [[<cmd>lua require("metals").toggle_setting("showImplicitArguments")<CR>]])

    api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = lsp_group,
    })
    api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = lsp_group,
    })
    api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      callback = vim.lsp.codelens.refresh,
      buffer = bufnr,
      group = lsp_group,
    })
    api.nvim_create_autocmd("FileType", {
      pattern = { "dap-repl" },
      callback = function()
        require("dap.ext.autocompl").attach()
      end,
      group = lsp_group,
    })

    -- nvim-dap
    local dap = require("dap")

    dap.configurations.scala = {
      {
        type = "scala",
        request = "launch",
        name = "Run or test with input",
        metals = {
          runType = "runOrTestFile",
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " +")
          end,
        },
      },
      {
        type = "scala",
        request = "launch",
        name = "Run or Test",
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

    map("n", "<leader>dc", [[<cmd>lua require("dap").continue()<CR>]])
    map("n", "<leader>dr", [[<cmd>lua require("dap").repl.toggle()<CR>]])
    map("n", "<leader>dK", [[<cmd>lua require("dap.ui.widgets").hover()<CR>]])
    map("n", "<leader>dt", [[<cmd>lua require("dap").toggle_breakpoint()<CR>]])
    map("n", "<leader>dso", [[<cmd>lua require("dap").step_over()<CR>]])
    map("n", "<leader>dsi", [[<cmd>lua require("dap").step_into()<CR>]])
    map("n", "<leader>drl", [[<cmd>lua require("dap").run_last()<CR>]])

    dap.listeners.after["event_terminated"]["nvim-metals"] = function(session, body)
      dap.repl.open()
    end

    require("metals").setup_dap()
  end

  local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
  api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
      require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
  })
  
  

  lsp_config.jsonls.setup({
    on_attach = on_attach,
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
  })

  lsp_config.tsserver.setup({
    on_attach = on_attach,
    root_dir = function (pattern)
      local cwd  = vim.loop.cwd();
      local root = util.root_pattern("package.json", "tsconfig.json", ".git")(pattern);
      return root or cwd;
    end
  })
  -- These server just use the vanilla setup
  local servers = { "bashls", "dockerls", "html", "tsserver", "yamlls", "gopls", "rust_analyzer" }
  for _, server in pairs(servers) do
    lsp_config[server].setup({ on_attach = on_attach })
  end

end

return {
  setup = setup,
}
