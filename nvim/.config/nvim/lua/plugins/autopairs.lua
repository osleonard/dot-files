vim.pack.add({
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/windwp/nvim-autopairs" },
}, { load = true })

local function setup_autopairs()
  require("nvim-autopairs").setup({})

  local ok_cmp, cmp = pcall(require, "cmp")
  if ok_cmp then
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
end

vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = setup_autopairs,
})
