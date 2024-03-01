-- Modify this table to configure LSP servers (useful setting: filetypes = {})
-- LSP servers configuration: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- Language specific plugins: https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins


local servers = {
  pyright = {},
  r_language_server = {},
  clangd = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  bashls = {},
}

-- Setup neovim lua configuration
require('neodev').setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Set pretty icons next to number lines
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Mason settings
require('mason').setup({
  ui = {
    border = 'rounded', -- same values as nvim_open_win()
    icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
    },
  },
})

local mason_lspconfig = require('mason-lspconfig')

-- Ensure the servers above are installed
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true,
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = require('user.keymaps').lsp_on_attach, -- Keymaps are set in keymaps.lua file
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}


-- Set how diagnostics is to be displayed
-- only for LSP
-- vim.lsp.handlers['textDocument/publishDiagnostics'] =
--   vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = false,
--     -- virtual_text = false,
--     signs = true,
--     -- unpdate_in_insert = true  -- Enables automatic updating of diagnostics while in insert mode. Default: false
--   })

-- more general (not only LSP)
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = false,
})
