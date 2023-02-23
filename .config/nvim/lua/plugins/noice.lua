return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		cmdline = {
			format = {
				conceal = false,
				cmdline = { pattern = "^:", icon = "󰘳", lang = "vim" },
			},
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		views = {
			cmdline_popup = {
				border = {
					style = "none",
					padding = { 1, 3 },
				},
				filter_options = {},
				position = "50%",
				relative = "editor",
				win_options = {
					winhighlight = "ColorColumn:ColorColumn,ColorColumn:ColorColumn",
				},
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
				opts = { skip = true },
			},
		},
	},
}
