local setup = function()
 require("mason").setup{
   ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
   ensure_installed = { "lua_ls" },
 } 
end

return {
  setup = setup
}

