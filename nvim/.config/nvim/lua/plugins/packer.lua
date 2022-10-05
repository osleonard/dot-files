local setup = function()
  local packer = require("packer")
    packer.init {
      ensure_dependencies   = true, -- Should packer install plugin dependencies?
      display = {
        non_interactive = false, -- If true, disable display windows for all operations
        compact = false, -- If true, fold updates results by default
        open_fn  = require('packer.util').float, -- An optional function to open a window for packer's display
        open_cmd = '65vnew \\[packer\\]', -- An optional command to open a window for packer's display
        working_sym = '⟳', -- The symbol for a plugin being installed/updated
        error_sym = '✗', -- The symbol for a plugin with an error in installation/updating
        done_sym = '✓', -- The symbol for a plugin which has completed installation/updating
        removed_sym = '-', -- The symbol for an unused plugin which was removed
        moved_sym = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
        header_sym = '━', -- The symbol for the header line in packer's display
        show_all_info = true, -- Should packer show all update details automatically?
        prompt_border = 'double', -- Border style of prompt popups.
        keybindings = { -- Keybindings for the display window
          quit = 'q',
          toggle_update = 'u', -- only in preview
          continue = 'c', -- only in preview
          toggle_info = '<CR>',
          diff = 'd',
          prompt_revert = 'r',
        }
      }
    }
end

return {
  setup = setup
}



