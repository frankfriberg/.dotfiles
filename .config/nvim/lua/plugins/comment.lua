return {
  "terrortylor/nvim-comment",
  name = "nvim_comment",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  init = function()
    require("nvim-treesitter.configs").setup({
      context_commentstring = {
        enable = true,
      },
    })
  end,
  opts = {
    hook = function()
      if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
        require("ts_context_commentstring.internal").update_commentstring()
      end
    end,
  },
}
