return {
  "rebelot/heirline.nvim",
  event = "VeryLazy",
  lazy = true,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
    "moll/vim-bbye"
  },
  init = function()
    vim.o.showtabline = 2
    vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
  end,
  opts = function()
    local statusLines = require("plugins.ui.statusline")
    local tabLine = require("plugins.ui.tabline")
    local utils = require("heirline.utils")

    local colors = {
      fg = utils.get_highlight("Normal").fg,
      bg = utils.get_highlight("Normal").bg,
      dark_bg = utils.get_highlight("ColorColumn").bg,
      bright_bg = utils.get_highlight("Folded").bg,
      bright_fg = utils.get_highlight("Folded").fg,
      red = utils.get_highlight("DiagnosticError").fg,
      dark_red = utils.get_highlight("DiffDelete").bg,
      green = utils.get_highlight("healthSuccess").fg,
      blue = utils.get_highlight("Function").fg,
      gray = utils.get_highlight("NonText").fg,
      orange = utils.get_highlight("Constant").fg,
      purple = utils.get_highlight("Statement").fg,
      cyan = utils.get_highlight("Special").fg,
      diag_warn = utils.get_highlight("DiagnosticWarn").fg,
      diag_error = utils.get_highlight("DiagnosticError").fg,
      diag_hint = utils.get_highlight("DiagnosticHint").fg,
      diag_info = utils.get_highlight("DiagnosticInfo").fg,
      git_del = utils.get_highlight("GitSignsDelete").fg,
      git_add = utils.get_highlight("GitSignsAdd").fg,
      git_change = utils.get_highlight("GitSignsChange").fg,
    }

    require("heirline").load_colors(colors)
    return { statusline = statusLines, tabline = tabLine }
  end,
}
