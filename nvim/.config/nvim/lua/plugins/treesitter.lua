local setup = function()
 require("nvim-treesitter.configs").setup{
   ensure_installed = {"markdown", "vimdoc", "lua", "rust", "toml", "scala", "cmake", "c", "kotlin", "go"},
   highlight = {
    enable = true
  }
 } 
end

return {
  setup = setup
}
