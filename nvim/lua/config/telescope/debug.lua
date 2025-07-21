local M = {}

local utils = require("config.debug.utils")

M.setup = function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')

  telescope.setup {
    extensions = {
      debug = {
        {} -- Additional specific setup can be added here
      }
    }
  }

  telescope.load_extension('debug')

  -- Binding for selecting executable
  vim.keymap.set("n", "<leader>de", function()
    local executables = utils.find_project_executables()
    utils.select_executable_with_telescope(executables, "Select Executable to Debug", function(selection)
      print("Selected executable: " .. selection)
    end)
  end, { noremap = true, desc = "Select Debug Executable" })

end

return M

