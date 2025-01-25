return {
	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		opts = {
			indent = {
				char = '▏',
			},
			scope = {
				show_start = false,
				show_end = false,
				show_exact_scope = false,
			},
			exclude = {
				filetypes = {
					'help',
					'startify',
					'dashboard',
					'packer',
					'neogitstatus',
					'NvimTree',
					'Trouble',
				},
			},
		},
		config = function()
			-- Set custom background color for indent characters
			local bgc = require("pywal16.core").get_colors().background
			vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { bg = bgc }) -- Replace with your colors
		end,
	}
}
