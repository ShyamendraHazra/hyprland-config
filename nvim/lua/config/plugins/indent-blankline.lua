return {
	{
		'lukas-reineke/indent-blankline.nvim',
		config = function()
			local highlight = {
				"IndentBG",
			}

			local highlight_WS = {
				"WhitespaceBG",
			}

			local Pywal = require("pywal16.core")
			local Pywal_colors = Pywal.get_colors()

			local hooks = require "ibl.hooks"
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "IndentBG", { fg = Pywal_colors.foreground })
				vim.api.nvim_set_hl(0, "WhitespaceBG", { fg = Pywal_colors.background })
			end)
			require("ibl").setup {
				indent = {
					char = '▏',
					highlight = highlight,
				},
				whitespace = {
					highlight = highlight_WS,
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
				}
			}
		end
	}
}
