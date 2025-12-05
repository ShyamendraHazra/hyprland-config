
-- Lua file for setting up LSPs using neovim/nvim-lspconfig and blink.cmp
-- This config is designed for modern LSP usage with custom capabilities and
-- multiple server configurations, each optionally accepting settings.

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Blink for enhanced LSP capabilities (completion, etc.)
			'saghen/blink.cmp',

			-- Lazydev adds support for dev library introspection (optional usage)
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
			-- Get extended capabilities from blink.cmp
			local capabilities = require('blink.cmp').get_lsp_capabilities()

			-- General-purpose function to setup LSP servers with optional overrides
			local function setup_server(server_name, config)
				config = config or {}
				config.capabilities = capabilities
				require("lspconfig")[server_name].setup(config)
			end

			-- Lua
			setup_server("lua_ls")

			-- C/C++
			setup_server("clangd", {
				cmd = { "clangd" },
			})

			-- CMake
			setup_server("neocmake")

			-- PHP
			setup_server("intelephense")

			-- HTML
			setup_server("html", {
				cmd = { "vscode-html-languageserver", "--stdio" },
			})

			-- CSS
			setup_server("cssls", {
				cmd = { "vscode-css-languageserver", "--stdio" },
			})

			-- TypeScript / JavaScript
			setup_server("ts_ls", {
				cmd = { "typescript-language-server", "--stdio" },
			})

			-- Emmet
			setup_server("emmet_language_server", {
				filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
				-- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
				-- **Note:** only the options listed in the table are supported.
				init_options = {
					---@type table<string, string>
					includeLanguages = {},
					--- @type string[]
					excludeLanguages = {},
					--- @type string[]
					extensionsPath = {},
					--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
					preferences = {},
					--- @type boolean Defaults to `true`
					showAbbreviationSuggestions = true,
					--- @type "always" | "never" Defaults to `"always"`
					showExpandedAbbreviation = "always",
					--- @type boolean Defaults to `false`
					showSuggestionsAsSnippets = false,
					--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
					syntaxProfiles = {},
					--- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
					variables = {},
				},
			})

			-- Python
			setup_server("pylsp")

			-- Nushell (nu shell config)
			setup_server("nushell", {
				cmd = { "nu", "--lsp" },
				filetypes = { "nu" },
				root_dir = function(fname)
					return vim.fs.root(fname, { ".git" }) or vim.fs.dirname(fname)
				end,
			})

			-- Optional: Attach behavior and mappings when LSP attaches to buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end

					-- Map `gr` to list references via telescope (or default UI)
					if client.supports_method('textDocument/references') then
						vim.api.nvim_buf_set_keymap(args.buf, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>',
							{ noremap = true, silent = true })
					end

					-- Uncomment below block to enable formatting on save
					--[[
					if client.supports_method('textDocument/formatting') then
						vim.api.nvim_create_autocmd('BufWritePre', {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
							end
						})
					end
					]]
				end
			})
		end,
	}
}

