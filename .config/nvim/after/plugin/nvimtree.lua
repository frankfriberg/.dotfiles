local tree = require("nvim-tree")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.keymap.set("n", "<leader><leader>", ":NvimTreeToggle <cr>", {})
local gheight = vim.api.nvim_list_uis()[1].height
local gwidth = vim.api.nvim_list_uis()[1].width
local width = 60
local height = 30

tree.setup({
	view = {
		mappings = {
			list = {
				{ key = "<esc>", action = "close" },
			},
		},
		float = {
			enable = true,
			open_win_config = {
				border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
				width = width,
				height = height,
				row = (gheight - height) * 0.5,
				col = (gwidth - width) * 0.5,
			},
		},
	},
})
