local wezterm = require("wezterm")

local colors = {
  fg = "#a9b1d6",
  bg = "#24283b",
  bg_dark = "#1a1b26",
  red = "#f7768e",
  orange = "#ff9e64",
  yellow = "#e0af68",
  green = "#9ece6a",
  cyan = "#73daca",
  skyblue = "#7dcfff",
  blue = "#7aa2f7",
  pink = "#bb9af7",
  purple = "#565f89",
  terminal_black = "#414868",
}

local function get_process(tab)
  local process_icons = {
    ["docker"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["docker-compose"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["nvim"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.custom_vim },
    },
    ["vim"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.dev_vim },
    },
    ["node"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.mdi_hexagon },
    },
    ["zsh"] = {
      { Foreground = { Color = colors.purple } },
      { Text = wezterm.nerdfonts.dev_terminal },
    },
    ["fish"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.dev_terminal },
    },
    ["bash"] = {
      { Foreground = { Color = colors.fg } },
      { Text = wezterm.nerdfonts.cod_terminal_bash },
    },
    ["cargo"] = {
      { Foreground = { Color = colors.purple } },
      { Text = wezterm.nerdfonts.dev_rust },
    },
    ["go"] = {
      { Foreground = { Color = colors.cyan } },
      { Text = wezterm.nerdfonts.mdi_language_go },
    },
    ["lazydocker"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["git"] = {
      { Foreground = { Color = colors.purple } },
      { Text = wezterm.nerdfonts.dev_git },
    },
    ["lazygit"] = {
      { Foreground = { Color = colors.purple } },
      { Text = wezterm.nerdfonts.dev_git },
    },
    ["lua"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.seti_lua },
    },
    ["wget"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_arrow_down_box },
    },
    ["ruby"] = {
      { Foreground = { Color = colors.red } },
      { Text = wezterm.nerdfonts.oct_ruby },
    },
    ["curl"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_flattr },
    },
    ["gh"] = {
      { Foreground = { Color = colors.skyblue } },
      { Text = wezterm.nerdfonts.dev_github_badge },
    },
  }

  local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

  return wezterm.format(
    process_icons[process_name]
    or { { Foreground = { Color = colors.skyblue } }, { Text = string.format("[%s]", process_name) } }
  )
end

wezterm.on("format-tab-title", function(tab)
  local title = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')

  return wezterm.format({
    { Attribute = { Intensity = "Half" } },
    { Text = string.format(" %s  ", tab.tab_index + 1) },
    "ResetAttributes",
    { Text = get_process(tab) },
    { Text = " " },
    { Text = title },
    { Foreground = { Color = colors.bg } },
    { Text = "  ▕" },
  })
end)

wezterm.on("update-right-status", function(window)
  local date = wezterm.strftime("%b %-d %H:%M:%S ")

  window:set_right_status(wezterm.format({
    { Text = date },
  }))
end)

local config = {
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  audible_bell = "Disabled",
  send_composed_key_when_left_alt_is_pressed = true,
  term = "wezterm",
  window_decorations = "RESIZE",
  color_scheme = "tokyonight-storm",
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  font = wezterm.font("JetBrainsMonoNL Nerd Font"),
  show_new_tab_button_in_tab_bar = false,
  underline_position = "-6px",
  underline_thickness = 2,
  font_size = 14,
  tab_max_width = 50,
  colors = {
    tab_bar = {
      background = colors.bg_dark,
      active_tab = {
        fg_color = colors.fg,
        bg_color = colors.bg,
      },
      inactive_tab = {
        fg_color = colors.purple,
        bg_color = colors.bg_dark,
      },
      inactive_tab_edge = colors.red,
    },
  },
}

return config
