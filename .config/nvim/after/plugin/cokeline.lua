local config = require("tokyonight.config")
local colors = require("tokyonight.colors")
local theme = {
	config = config.options,
	colors = colors.setup(),
}
local c = theme.colors
local mappings = require("cokeline/mappings")

local red = c.red1
local yellow = c.orange

vim.api.nvim_set_keymap("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
vim.api.nvim_set_keymap("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })

for i = 1, 9 do
	vim.keymap.set("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
end

local function getColor(buffer)
	return (buffer.diagnostics.errors ~= 0 and red)
		or (buffer.diagnostics.warnings ~= 0 and yellow)
		or (buffer.diagnostics.hints ~= 0 and c.blue0)
		or (buffer.diagnostics.infos ~= 0 and c.green)
		or (buffer.is_focused and c.bg)
		or c.green1
end

local components = {
	space = {
		text = " ",
		truncation = { priority = 1 },
	},

	two_spaces = {
		text = "  ",
		truncation = { priority = 1 },
	},

	devicon = {
		text = function(buffer)
			return
				(mappings.is_picking_focus() or mappings.is_picking_close()) and buffer.pick_letter .. " "
					or buffer.devicon.icon
		end,
		fg = function(buffer)
			return (mappings.is_picking_focus() and yellow) or (mappings.is_picking_close() and red) or getColor(buffer)
		end,
		style = function(_)
			return (mappings.is_picking_focus() or mappings.is_picking_close()) and "bold" or nil
		end,
		truncation = { priority = 1 },
	},

	unique_prefix = {
		text = function(buffer)
			return buffer.unique_prefix
		end,
		truncation = {
			priority = 3,
			direction = "left",
		},
	},

	filename = {
		text = function(buffer)
			return buffer.filename
		end,
		style = function(buffer)
			return (buffer.is_focused and "bold") or nil
		end,
		truncation = {
			priority = 2,
			direction = "left",
		},
	},

	diagnostics = {
		text = function(buffer)
			return
				(buffer.diagnostics.errors ~= 0 and "  " .. buffer.diagnostics.errors)
					or (buffer.diagnostics.warnings ~= 0 and "  " .. buffer.diagnostics.warnings)
					or (buffer.diagnostics.infos ~= 0 and "  " .. buffer.diagnostics.infos)
					or (buffer.diagnostics.hints ~= 0 and "  " .. buffer.diagnostics.hints)
					or ""
		end,
		truncation = { priority = 1 },
	},

	unsaved = {
		text = function(buffer)
			return buffer.is_modified and "+" or " "
		end,
		truncation = { priority = 1 },
	},
}

require("cokeline").setup({
	show_if_buffers_are_at_least = 1,

	buffers = {
		-- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
		-- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
		new_buffers_position = "next",
	},

	rendering = {
		max_buffer_width = 30,
	},

	default_hl = {
		fg = function(buffer)
			return getColor(buffer)
		end,
		bg = function(buffer)
			return buffer.is_focused and c.green1 or c.bg
		end,
	},

	components = {
		components.two_spaces,
		components.space,
		components.devicon,
		components.space,
		components.unique_prefix,
		components.filename,
		components.space,
		components.unsaved,
		components.diagnostics,
		components.space,
	},
})
