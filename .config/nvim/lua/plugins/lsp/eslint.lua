local _ = {}

_.setup = function(on_attach, capabilities)
  local lspconfig = require("lspconfig")

  lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    settings = {
      format = {
        enable = false,
      },
    },
    handlers = {
      ["window/showMessageRequest"] = function(_, result)
        if result.message:find("ENOENT") then
          return vim.NIL
        end

        return vim.lsp.handlers["window/showMessageRequest"](nil, result)
      end,
    },
  })
end

return _
