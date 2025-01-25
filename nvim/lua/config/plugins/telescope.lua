return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim', build = 'make'
			},
		},
		config = function()
			require('telescope').setup {
				pickers = {
					find_files = {
						theme = "ivy", -- Use Ivy theme
					}
				},
				extensions = {
					fzf = {}
				}
			}

			require('telescope').load_extension('fzf')

			vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)


			local open_file_finder = function()
				require('telescope.builtin').find_files {
					no_ignore = true,
					cwd = vim.fn.getcwd(),
				}
			end

			local open_nvim_config = function()
				require('telescope.builtin').find_files {
					no_ignore = true,
					cwd = vim.fn.stdpath("config"),
				}
			end

			local search_lazy_folder = function()
				require('telescope.builtin').find_files({
					no_ignore = true,
					cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
				})
			end

			vim.keymap.set("n", "<space>fd", open_file_finder)

			vim.keymap.set("n", "<space>en", open_nvim_config)

			vim.keymap.set("n", "<space>ep", search_lazy_folder)

			require "config.telescope.multigrep".setup()
		end
	}
}
