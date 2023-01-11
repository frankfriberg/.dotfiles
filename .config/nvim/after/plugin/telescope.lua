local telescope = require("telescope")
local icons = require("nvim-nonicons")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser <cr>", {})
vim.keymap.set("n", "<leader>fg", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

telescope.load_extension("media_files")
telescope.load_extension("file_browser")
telescope.setup({
	defaults = {
		prompt_prefix = "  " .. icons.get("telescope") .. "  ",
		entry_prefix = "   ",
		path_display = { "smart" },
		layout_config = {
			anchor = "CENTER",
		},
	},
	extensions = {
		media_files = {
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg",
		},
		file_browser = {
			hijack_netrw = true,
		},
	},
})
