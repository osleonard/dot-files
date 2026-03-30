local setup = function()
 require("mason").setup{
   ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
   ensure_installed = { "lua_ls", "ts_ls", "kotlin_lsp" },
 } 
end

return {
  setup = setup
}

