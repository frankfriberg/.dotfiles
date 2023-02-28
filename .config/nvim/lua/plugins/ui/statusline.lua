local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local ViMode = {
	init = function(self)
		self.mode = vim.fn.mode(1)

		if not self.once then
			vim.api.nvim_create_autocmd("ModeChanged", {
				pattern = "*:*o",
				command = "redrawstatus",
			})
			self.once = true
		end
	end,
	static = {
		mode_names = {
			n = "N",
			no = "N?",
			nov = "N?",
			noV = "N?",
			["no\22"] = "N?",
			niI = "Ni",
			niR = "Nr",
			niV = "Nv",
			nt = "Nt",
			v = "V",
			vs = "Vs",
			V = "V_",
			Vs = "Vs",
			["\22"] = "^V",
			["\22s"] = "^V",
			s = "S",
			S = "S_",
			["\19"] = "^S",
			i = "I",
			ic = "Ic",
			ix = "Ix",
			R = "R",
			Rc = "Rc",
			Rx = "Rx",
			Rv = "Rv",
			Rvc = "Rv",
			Rvx = "Rv",
			c = "C",
			cv = "Ex",
			r = "...",
			rm = "M",
			["r?"] = "?",
			["!"] = "!",
			t = "T",
		},
		mode_colors = {
			n = "green",
			i = "green",
			v = "blue",
			V = "blue",
			["\22"] = "blue",
			c = "fg",
			s = "purple",
			S = "purple",
			["\19"] = "purple",
			R = "orange",
			r = "orange",
			["!"] = "red",
			t = "red",
		},
	},
	provider = function(self)
		return "%2( " .. self.mode_names[self.mode] .. " %)"
	end,
	hl = function(self)
		local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { fg = "dark_bg", bg = self.mode_colors[mode] }
	end,
	update = {
		"ModeChanged",
	},
}

local FileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

local FileIcon = {
	init = function(self)
		local filename = vim.api.nvim_buf_get_name(0)
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
}

local WorkDir = {
	provider = function()
		local cwd = vim.fn.getcwd(0)
		cwd = vim.fn.fnamemodify(cwd, ":~")
		if not conditions.width_percent_below(#cwd, 0.25) then
			cwd = vim.fn.pathshorten(cwd)
		end
		local trail = cwd:sub(-1) == "/" and "" or "/"
		return cwd .. trail
	end,
	hl = { fg = "blue", bold = true },
}

local FileName = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
	provider = function(self)
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return "[No Name]"
		end
		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end
		return filename
	end,
	hl = { fg = "fg" },
}

local FileType = {
	provider = function(self)
		local filename = vim.api.nvim_buf_get_name(0)
		local extension = vim.bo.filetype
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
		return extension:gsub("^%l", string.upper)
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
}

local HelpFileName = {
	condition = function()
		return vim.bo.filetype == "help"
	end,
	provider = function()
		local filename = vim.api.nvim_buf_get_name(0)
		return vim.fn.fnamemodify(filename, ":t")
	end,
	hl = { fg = "blue" },
}

local FileFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = " ",
		hl = { fg = "green" },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = " ",
		hl = { fg = "orange" },
	},
}

local Diagnostics = {
	condition = conditions.has_diagnostics,
	update = { "DiagnosticChanged", "BufEnter" },
	static = {
		error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
		warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
		info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
		hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
	},
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	{
		provider = function(self)
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = { fg = "diag_error" },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = "diag_warn" },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = { fg = "diag_info" },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = { fg = "diag_hint" },
	},
}

FileNameBlock = utils.insert(FileNameBlock, FileName, FileFlags, { provider = "%<" })

local Lsp = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },
	provider = function()
		local names = {}
		for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return " " .. table.concat(names, " ")
	end,
	hl = { fg = "green" },
}

local Git = {
	condition = conditions.is_git_repo,
	init = function(self)
		---@diagnostic disable-next-line: undefined-field
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,
	hl = { fg = "fg" },
	{
		provider = function()
			return "󰘬 " .. vim.b.branch_name
		end,
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and (" 󰐙 " .. count)
		end,
    hl = { fg = "git_add" }
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and (" 󱨧 " .. count)
		end,
    hl = { fg = "git_change"}
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and (" 󰍷 " .. count)
		end,
    hl = { fg = "git_del" }
	},
}

local Align = { provider = "%=" }
local Space = { provider = " " }
local Spacer = function(condition)
  return {
    condition = condition,
    provider = " · "
}
end

local DefaultStatusline = {
	ViMode,
	Space,
	FileNameBlock,
	Space,
	Space,
	Diagnostics,
	Align,
	Align,
	Git,
	Spacer(conditions.is_git_repo),
	Lsp,
	Spacer(conditions.lsp_attached),
	FileIcon,
	FileType,
	Space,
}

local TerminalStatusline = {
	condition = function()
		return conditions.buffer_matches({ buftype = { "terminal" } })
	end,
	{ condition = conditions.is_active, ViMode, Space },
	Space,
	Align,
}

local InactiveStatusline = {
	condition = conditions.is_not_active,
	Space,
	FileName,
	Align,
	Git,
	Spacer(conditions.is_git_repo),
	FileIcon,
	FileType,
	Space,
}

local SpecialStatusline = {
	condition = function()
		return conditions.buffer_matches({
			buftype = { "nofile", "prompt", "help", "quickfix" },
			filetype = { "^git.*", "fugitive" },
		})
	end,
	HelpFileName,
	Space,
	Align,
	FileIcon,
	FileType,
	Space,
}

return {
	hl = "ColorColumn",
	fallthrough = false,
	SpecialStatusline,
	TerminalStatusline,
	InactiveStatusline,
	DefaultStatusline,
}
