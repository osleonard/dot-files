local setup = function()
 require("nvim-treesitter.configs").setup{
   ensure_installed = {"markdown", "vimdoc", "lua", "rust", "toml", "scala", "cmake", "c"},
   highlight = {
    enable = true
  }
 } 
end

return {
  setup = setup
}
