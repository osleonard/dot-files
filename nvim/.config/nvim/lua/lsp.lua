vim.pack.add({
  { src = "https://github.com/j-hui/fidget.nvim" },
}, { load = true })

require("fidget").setup({})

local function setup()
  local lsp_attach_group = vim.api.nvim_create_augroup("osl-lsp-attach", { clear = true })
  local lsp_highlight_group = vim.api.nvim_create_augroup("osl-lsp-highlight", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_attach_group,
    callback = function(event)
      local bufnr = event.buf

      local function map(keys, func, desc)
        vim.keymap.set("n", keys, func, {
          buffer = bufnr,
          desc = "LSP: " .. desc,
        })
      end

      local ok_telescope, telescope_builtin = pcall(require, "telescope.builtin")

      map("gd", ok_telescope and telescope_builtin.lsp_definitions or vim.lsp.buf.definition, "[G]oto [D]efinition")

      map("<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, "Format file")

      map("gr", ok_telescope and telescope_builtin.lsp_references or vim.lsp.buf.references, "[G]oto [R]eferences")

      map("gI", ok_telescope and telescope_builtin.lsp_implementations or vim.lsp.buf.implementation, "[G]oto [I]mplementation")

      map("<leader>D", ok_telescope and telescope_builtin.lsp_type_definitions or vim.lsp.buf.type_definition, "Type [D]efinition")

      if ok_telescope then
        map("<leader>ds", telescope_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
      end

      map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
      map("K", vim.lsp.buf.hover, "Hover Documentation")
      map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      map("<C-space>", function()
        vim.lsp.completion.get()
      end, "Available completions")

      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if client and client:supports_method("textDocument/completion", bufnr) then
        vim.lsp.completion.enable(true, client.id, bufnr, {
          autotrigger = true,
        })
      end

      if client and client:supports_method("textDocument/documentHighlight", bufnr) then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = bufnr,
          group = lsp_highlight_group,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = bufnr,
          group = lsp_highlight_group,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
          buffer = bufnr,
          group = vim.api.nvim_create_augroup("osl-lsp-detach", { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({
              group = lsp_highlight_group,
              buffer = event2.buf,
            })
          end,
        })
      end

      if client and client:supports_method("textDocument/inlayHint", bufnr) then
        map("<leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), {
            bufnr = bufnr,
          })
        end, "[T]oggle Inlay [H]ints")
      end
    end,
  })
end

setup()
