return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = {
    "MunifTanjim/prettier.nvim",
  },
  opts = function()
    local null_ls = require("null-ls")
    local prettier = require("prettier")

    prettier.setup({
      bin = "prettierd",
      filetypes = {
        "css",
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "json",
        "scss",
        "less",
        "sass",
        "scss",
      },
      cli_options = {
        arrow_parens = "always",
        bracket_spacing = true,
        bracket_same_line = false,
        embedded_language_formatting = "auto",
        end_of_line = "lf",
        html_whitespace_sensitivity = "css",
        -- jsx_bracket_same_line = false,
        jsx_single_quote = false,
        print_width = 80,
        prose_wrap = "preserve",
        quote_props = "as-needed",
        semi = true,
        single_attribute_per_line = false,
        single_quote = false,
        tab_width = 2,
        trailing_comma = "es5",
        use_tabs = false,
        vue_indent_script_and_style = false,
      },
    })

    return {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.gitsigns
      },
    }
  end,
}
