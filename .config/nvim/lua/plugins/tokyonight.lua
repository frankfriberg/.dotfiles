return {
  "folke/tokyonight.nvim",
  init = function()
    vim.cmd("colorscheme tokyonight")
  end,
  opts = {
    style = "storm",
    sidebars = { "Telescope" },
    on_highlights = function(hl, c)
      local added = { fg = c.green1 }
      local deleted = { fg = c.red }
      local changed = { fg = c.blue }
      hl.GitSignsAdd = added
      hl.GitSignsDelet = deleted
      hl.GitSignsChange = changed
      hl.NeoTreeGitAdded = added
      hl.NeoTreeGitDeleted = deleted
      hl.NeoTreeGitModified = changed
      hl.NeoTreeGitUntracked = { fg = c.yellow }
      hl.NeoTreeDirectoryIcon = { fg = c.fg_dark }
      hl.NeoTreeDirectoryName = { fg = c.fg_dark }
    end,
    on_colors = function(colors)
      colors.bg_sidebar = colors.black
    end,
  }
}
