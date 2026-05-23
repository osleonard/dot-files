vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main'  },
}, { load = true })


local ts = require("nvim-treesitter")

local parsers = {
  "bash",
  "c",
  "diff",
  "html",
  "lua",
  "luadoc",
  "markdown",
  "vim",
  "vimdoc",
  "scala",
  "go",
}

ts.install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  -- Check if a parser exists and load it
  if not vim.treesitter.language.add(language) then
    return
  end

  -- Enable Treesitter highlighting
  vim.treesitter.start(buf, language)

  -- Optional: enable Treesitter folds
  -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  -- vim.wo.foldmethod = "expr"

  -- Enable Treesitter indentation if an indent query exists
  local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

  if has_indent_query then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local available_parsers = ts.get_available()

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter-auto-attach", { clear = true }),

  callback = function(args)
    local buf = args.buf
    local filetype = args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then
      return
    end

    local installed_parsers = ts.get_installed("parsers")

    if vim.tbl_contains(installed_parsers, language) then
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      ts.install(language):await(function()
        treesitter_try_attach(buf, language)
      end)
    else
      treesitter_try_attach(buf, language)
    end
  end,
})
