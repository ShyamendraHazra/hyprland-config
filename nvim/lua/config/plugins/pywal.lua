return {
	{
		'uZer/pywal16.nvim',
		-- for local dev replace with:
		-- dir = '~/your/path/pywal16.nvim',
		config = function()
			-- Load the pywal16 colorscheme
			vim.cmd.colorscheme("pywal16")
			local pywal16 = require('pywal16')
			pywal16.setup()

			-- Get the colors from pywal16
			local colors = require("pywal16.core").get_colors()

			-- Variable to track the background state
			local is_bg_set = false

			-- Function to toggle the background color
			local function toggle_bg_color()
				if is_bg_set then
					-- Unset the background color and revert to original background
					vim.cmd("highlight Normal guibg=NONE")
					is_bg_set = false
				else
					-- Set the background color to the Pywal color (color0 in this case)
					local bg_color = colors.color0 -- You can change this to any color you like
					vim.cmd("highlight Normal guibg=" .. bg_color)
					is_bg_set = true
				end
			end

			-- Create a custom command to toggle the background color
			vim.api.nvim_create_user_command('ToggleBg', toggle_bg_color, { nargs = 0 })
		end
	}
}
