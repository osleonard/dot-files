local setup = function()
 require("nvim-treesitter.configs").setup{
   ensure_installed = {"markdown", "vimdoc", "lua", "rust", "toml", "scala" },
   highlight = {
    enable = true
  }
 } 
end

return {
  setup = setup
}
