return {
	"williamboman/mason.nvim",
	event = "BufReadPre",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"folke/which-key.nvim",
		"jose-elias-alvarez/typescript.nvim",
		"folke/neodev.nvim",
		"b0o/schemastore.nvim",
	},
	config = function()
		local servers = {
			"lua_ls",
			"tsserver",
			"tailwindcss",
			"bashls",
			"jsonls",
			"prismals",
			"html",
		}

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_installation = true,
		})
		local wk = require("which-key")

		local on_attach = function(client, bufnr)
			wk.register({
				["gD"] = { vim.lsp.buf.declaration, "[LSP] Goto Declaration" },
				["gd"] = { vim.lsp.buf.definition, "[LSP] Goto Definition" },
				["K"] = { vim.lsp.buf.hover, "[LSP] Hover" },
				["gi"] = { vim.lsp.buf.implementation, "[LSP] Goto Implementation" },
				["gr"] = { vim.lsp.buf.references, "[LSP] References" },
				["<leader>l"] = {
					["s"] = { vim.lsp.buf.signature_help, "[LSP] Signature Help" },
					["D"] = { vim.lsp.buf.type_definition, "[LSP] Show Type Definition" },
					["r"] = { vim.lsp.buf.rename, "[LSP] Rename" },
					["c"] = { vim.lsp.buf.code_action, "[LSP] Open Code Actions Menu" },
					["f"] = {
						function()
							vim.lsp.buf.format({ async = true, timeout = 5000 })
						end,
						"[LSP] Format",
					},
				},
			}, {
				buffer = bufnr,
				mode = "n",
				prefix = "",
				silent = true,
				noremap = true,
				nowait = true,
			})
			vim.api.nvim_create_autocmd("CursorHold", {
				buffer = bufnr,
				callback = function()
					local opts = {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always",
						prefix = " ",
						scope = "cursor",
					}
					vim.diagnostic.open_float(nil, opts)
				end,
			})
		end

		local cmp = require("cmp_nvim_lsp")

		local capabilities = cmp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({ on_attach, capabilities })
			end,
			["tsserver"] = function()
				require("plugins.lsp.tsserver").setup(on_attach, capabilities)
			end,
			["lua_ls"] = function()
				require("plugins.lsp.lua_ls").setup(on_attach, capabilities)
			end,
			["jsonls"] = function()
				require("plugins.lsp.jsonls").setup(on_attach, capabilities)
			end,
			["html"] = function()
				require("plugins.lsp.html").setup(on_attach, capabilities)
			end,
			-- ["eslint"] = function()
			--   require("plugins.lsp.eslint").setup(on_attach, capabilities)
			-- end
		})
	end,
}
