local feline = require("feline")
local colors = require("tokyonight.colors").setup()
local theme = {
	aqua = colors.blue,
	bg = colors.bg,
	blue = colors.blue,
	cyan = colors.teal,
	darkred = colors.red1,
	fg = colors.fg,
	gray = colors.bg,
	green = colors.green1,
	lime = colors.cyan,
	orange = colors.orange,
	pink = colors.magenta,
	purple = colors.purple,
	red = colors.red,
	yellow = colors.yellow,
}

local mode_theme = {
	["NORMAL"] = theme.green,
	["OP"] = theme.aqua,
	["INSERT"] = theme.magenta,
	["VISUAL"] = theme.yellow,
	["LINES"] = theme.darkred,
	["BLOCK"] = theme.orange,
	["REPLACE"] = theme.purple,
	["V-REPLACE"] = theme.pink,
	["ENTER"] = theme.pink,
	["MORE"] = theme.pink,
	["SELECT"] = theme.darkred,
	["SHELL"] = theme.cyan,
	["TERM"] = theme.lime,
	["NONE"] = theme.gray,
	["COMMAND"] = theme.blue,
}

local component = {}

component.vim_mode = {
	provider = "vi_mode",
	hl = function()
		return {
			fg = "bg",
			bg = require("feline.providers.vi_mode").get_mode_color(),
			name = require("feline.providers.vi_mode").get_mode_highlight_name(),
			style = "bold",
		}
	end,
	icon = "",
	left_sep = "block",
	right_sep = "block",
}

component.file_name = {
	provider = {
		icon = "",
		name = "file_info",
		opts = {
			file_modified_icon = "+",
			file_readonly_icon = "",
			type = "relative",
		},
	},
	left_sep = " ",
	right_sep = " ",
}

component.git_branch = {
	provider = "git_branch",
	left_sep = "block",
	right_sep = "",
	hl = {

		style = "bold",
	},
}

component.git_add = {
	provider = "git_diff_added",
	hl = {
		fg = "green",
		style = "bold",
	},
	left_sep = "",
	right_sep = "",
}

component.git_delete = {
	provider = "git_diff_removed",
	hl = {
		fg = "red",
		style = "bold",
	},
	left_sep = "",
	right_sep = "",
}

component.git_change = {
	provider = "git_diff_changed",
	hl = {
		fg = "purple",
		style = "bold",
	},
	left_sep = "",
	right_sep = "",
}

component.separator = {
	provider = "",
	hl = {
		fg = "bg",
	},
}

component.diagnostic_errors = {
	provider = "diagnostic_errors",
	hl = {
		fg = "darkred",
		style = "bold",
	},
}

component.diagnostic_warnings = {
	provider = "diagnostic_warnings",
	hl = {
		fg = "orange",
		style = "bold",
	},
}

component.diagnostic_hints = {
	provider = "diagnostic_hints",
	hl = {
		fg = "green",
		style = "bold",
	},
}

component.diagnostic_info = {
	provider = "diagnostic_info",
	style = "bold",
}

component.lsp = {
	provider = function()
		if not rawget(vim, "lsp") then
			return ""
		end

		local progress = vim.lsp.util.get_progress_messages()[1]
		if vim.o.columns < 120 then
			return ""
		end

		local clients = vim.lsp.get_active_clients({ bufnr = 0 })
		if #clients ~= 0 then
			if progress then
				local spinners = {
					"◜ ",
					"◠ ",
					"◝ ",
					"◞ ",
					"◡ ",
					"◟ ",
				}
				local ms = vim.loop.hrtime() / 1000000
				local frame = math.floor(ms / 120) % #spinners
				local content = string.format("%%<%s", spinners[frame + 1])
				return content or ""
			else
				return "לּ LSP"
			end
		end
		return ""
	end,
	hl = function()
		return {
			fg = "bg",
			bg = "yellow",
			style = "bold",
		}
	end,
	left_sep = "block",
	right_sep = "block",
}

component.file_type = {
	provider = {
		name = "file_type",
		opts = {
			filetype_icon = true,
			colored_icon = false,
		},
	},
	hl = {
		fg = "bg",
		bg = "aqua",
		style = "bold",
	},
	left_sep = "block",
	right_sep = "block",
}

component.scroll_bar = {
	provider = function()
		local chars = {
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
		}
		local line_ratio = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
		local position = math.floor(line_ratio * 100)
		local position_string = tostring(position)

		if position <= 5 then
			position_string = " TOP"
		elseif position >= 95 then
			position_string = " BOT"
		else
			position_string = chars[math.floor(line_ratio * #chars)] .. position
		end
		return position_string
	end,
	hl = function()
		return {
			fg = "bg",
			bg = "purple",
			style = "bold",
		}
	end,
	left_sep = "block",
	right_sep = "block",
}

local left = {
	component.vim_mode,
}
local middle = {
	component.file_name,
	component.diagnostic_hints,
	component.diagnostic_info,
	component.diagnostic_warnings,
	component.diagnostic_errors,
}
local right = {
	component.file_type,
	component.lsp,
	component.git_branch,
	component.git_add,
	component.git_delete,
	component.git_change,
	component.separator,
	component.scroll_bar,
}

local components = {
	active = {
		left,
		middle,
		right,
	},
}

feline.setup({
	components = components,
	theme = theme,
	vi_mode_colors = mode_theme,
})
