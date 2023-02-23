local _ = {}

_.setup = function(on_attach, capabilities)
  require("neodev").setup()
  require("lspconfig").lua_ls.setup({
    on_attach = on_attach,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          workspaceWord = true,
          callSnippet = "Both",
        },
        misc = {
          parameters = {
            "--log-level=trace",
          },
        },
        diagnostics = {
          globals = { "vim" },
        },
        format = {
          enable = false,
        },
      },
    },
    capabilities = capabilities,
  })
end

return _
