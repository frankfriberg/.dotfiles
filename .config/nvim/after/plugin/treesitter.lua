local ok, configs = pcall(require, "nvim-treesitter/nvim-treesitter")

if not ok then
	return
end

configs.setup({
	ensure_installed = { "help", "javascript", "typescript", "lua", "bash" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	autopairs = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		config = {
			javascript = {
				__default = "// %s",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = "// %s",
				comment = "// %s",
			},
		},
	},
	indent = { enable = true, disable = { "yaml" } },
})
