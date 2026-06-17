local go_format_group = vim.api.nvim_create_augroup("golsp-format", { clear = false })
local go_ft_group = vim.api.nvim_create_augroup("osl-go-filetype", { clear = true })

local function organize_imports(bufnr)
  local clients = vim.lsp.get_clients({
    bufnr = bufnr,
    name = "gopls",
  })

  if #clients == 0 then
    return
  end

  local client = clients[1]
  local encoding = client.offset_encoding or "utf-16"
  local params = vim.lsp.util.make_range_params(0, encoding)
  params.context = {
    only = { "source.organizeImports" },
  }

  local result = vim.lsp.buf_request_sync(
    bufnr,
    "textDocument/codeAction",
    params,
    3000
  )

  for client_id, res in pairs(result or {}) do
    for _, action in pairs(res.result or {}) do
      if action.edit then
        local action_client = vim.lsp.get_client_by_id(client_id)
        local action_encoding = action_client and action_client.offset_encoding or encoding

        vim.lsp.util.apply_workspace_edit(action.edit, action_encoding)
      end
    end
  end
end

local function setup_go_buffer(bufnr)
  vim.api.nvim_clear_autocmds({
    group = go_format_group,
    buffer = bufnr,
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = go_format_group,
    buffer = bufnr,
    callback = function(args)
      organize_imports(args.buf)

      vim.lsp.buf.format({
        bufnr = args.buf,
        async = false,
        timeout_ms = 3000,
        filter = function(client)
          return client.name == "gopls"
        end,
      })
    end,
  })
end

vim.api.nvim_create_autocmd("FileType", {
  group = go_ft_group,
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function(args)
    setup_go_buffer(args.buf)
  end,
})
