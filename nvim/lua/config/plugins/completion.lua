return {
	{
		'saghen/blink.cmp',
		dependencies = 'rafamadriz/friendly-snippets',
		build = vim.g.lazyvim_blink_main and "cargo build --release",
		version = '*',

		opts = {
			keymap = { preset = 'default' },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},

			signature = { enabled = true }
		},
	},
}
