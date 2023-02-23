local utils = require("heirline.utils")
local tn = require("tokyonight.util")

local function padding(self, text, number)
  local width = vim.api.nvim_win_get_width(self.winid)
  local pad = math.ceil((width - #text) / number)
  return string.rep(" ", pad) .. text .. string.rep(" ", pad)
end

local Space = { provider = " " }

local TablineFileName = {
  provider = function(self)
    local filename = self.filename
    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
    return filename
  end,
  hl = function(self)
    if self.is_active then
      return { fg = "fg" }
    else
      return { fg = tn.darken("#FFFFFF", 0.4) }
    end
  end,
}

local TablineFileFlags = {
  {
    provider = function(self)
      if vim.api.nvim_buf_get_option(self.bufnr, "modified") then
        return " "
      else
        return "  "
      end
    end,
    hl = { fg = "green" },
  },
  {
    condition = function(self)
      return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
          or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
    end,
    provider = function()
      return " "
    end,
    hl = { fg = "orange" },
  },
}

local TabFileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color =
    require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
      return ""
    else
      return self.icon and (self.icon .. " ")
    end
  end,
  hl = function(self)
    if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
      return { fg = "orange" }
    elseif self.is_active then
      return { fg = self.icon_color }
    else
      return { fg = tn.darken(self.icon_color, 0.4) }
    end
  end,
}

local TablineFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  hl = function(self)
    if self.is_active then
      return { bg = "bg" }
    else
      return { bg = "dark_bg" }
    end
  end,
  Space,
  Space,
  Space,
  TabFileIcon,
  TablineFileName,
  TablineFileFlags,
  Space,
  Space,
}

local BufferLine = utils.make_buflist(
  TablineFileNameBlock,
  { provider = "←", hl = { fg = "green" } },
  { provider = "→", hl = { fg = "green" } }
)

local TabLineOffset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win

    if vim.bo[bufnr].filetype == "neo-tree" then
      self.title = ""
      return true
    end
  end,
  provider = function(self)
    return padding(self, self.title, 2)
  end,
  hl = "ColorColumn",
}

return { TabLineOffset, BufferLine }
