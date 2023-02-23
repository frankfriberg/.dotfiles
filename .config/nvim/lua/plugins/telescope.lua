return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "debugloop/telescope-undo.nvim",
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope Find Files" },
    { "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "Telescope File Browser" },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
      end,
      desc = "Telescope Grep",
    },
    { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Telescope Undo" },
    { "<leader>fc", "<cmd>Telescope neoclip<cr>", desc = "Telescope Neoclip" },
    { "<leader>fs", "<cmd>Telescope session-lens search_session<cr>", desc = "Telescope Sessions" }
  },
  config = function()
    local telescope = require("telescope")

    telescope.load_extension("media_files")
    telescope.load_extension("file_browser")
    telescope.load_extension("harpoon")
    telescope.load_extension("undo")
    telescope.load_extension("session-lens")
    telescope.setup({
      defaults = {
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
      dynamic_preview_title = true,
    })
  end,
}
