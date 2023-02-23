return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = true,
  event = "BufEnter",
  opts = {
    char = "▏",
    context_char = "▏",
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    show_current_context_start_on_current_line = true,
  },
  config = function(_, opts)
    require("indent_blankline").setup(opts)
  end
}
