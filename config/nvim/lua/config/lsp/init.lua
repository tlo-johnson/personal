local lspconfig = require('lspconfig')

local M = {}

local servers = {
  jdtls = { },
  tsserver = { },
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
        },
      },
    },
  },
  terraformls = { },
  solargraph = { },
  intelephense = { }
}

-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup()
  for server_name, server_config in pairs(servers) do
    lspconfig[server_name].setup(server_config)
  end
end

return M
