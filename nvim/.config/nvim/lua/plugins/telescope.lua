local fn = require("functions")
local map = fn.map

local setup =  function()

  map("n", "<space>c", [[<cmd>lua require("telescope").extensions.metals.commands()<CR>]])
  map("n", "<leader>ff", [[<cmd>lua require("telescope.builtin").find_files({layout_strategy="vertical"})<CR>]])  
  map("n", "<leader>lg", [[<cmd>lua require("telescope.builtin").live_grep({layout_strategy="vertical"})<CR>]])
  map("n", "<leader>fb", [[<cmd>lua require("telescope.builtin").buffers()<CR>]])

  local actions = require("telescope.actions")
    require("telescope").setup{
      defaults = {
        file_ignore_patterns = { "target", "node_modules" }
      }
    }
  end

return {
  setup = setup,
}
