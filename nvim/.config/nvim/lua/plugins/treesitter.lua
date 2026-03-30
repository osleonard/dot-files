local setup = function()
 require("nvim-treesitter.configs").setup{
<<<<<<< HEAD
   ensure_installed = {"markdown", "vimdoc", "lua", "rust", "toml", "scala" },
=======
   ensure_installed = {"markdown", "vimdoc", "lua", "rust", "toml", "scala", "cmake", "c", "kotlin", "go"},
>>>>>>> 1d768fc (Clean up configs)
   highlight = {
    enable = true
  }
 } 
end

return {
  setup = setup
}
