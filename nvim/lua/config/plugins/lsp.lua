return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			'saghen/blink.cmp',
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local capabilities = require('blink.cmp').get_lsp_capabilities()

			local function setup_server(server_name, config)
				config = config or {}
				config.capabilities = capabilities
				require("lspconfig")[server_name].setup(config)
			end

			-- Setup LSP servers
			setup_server("lua_ls")
			setup_server("clangd")
			setup_server("neocmake")
			setup_server("intelephense")
			setup_server("html", {
				cmd = { "vscode-html-languageserver", "--stdio" },
			})
			setup_server("cssls", {
				cmd = { "vscode-css-languageserver", "--stdio" },
			})
			setup_server("ts_ls", {
				cmd = { "typescript-language-server", "--stdio" },
			})
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end
					if client.supports_method('textDocument/references') then
						-- Map `gr` to go to references in normal mode
						vim.api.nvim_buf_set_keymap(args.buf, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>',
							{ noremap = true, silent = true })
					end

					if client.supports_method('textDocument/formatting') then
						vim.api.nvim_create_autocmd('BufWritePre', {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
							end
						})
					end
				end
			})
		end,
	}
}
