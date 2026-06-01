-- ~/.config/nvim/lua/plugins/mason-tilt.lua
return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        -- mason will try to install tilt_ls if mason-lspconfig knows about it
        -- otherwise this just configures lspconfig.tilt_ls
        ---@type vim.lsp.Config
        tilt_ls = {
          cmd = { "tilt", "lsp", "start" },
          filetypes = { "tiltfile" },
          root_markers = { ".git" },
          -- settings = { ... }, -- if Tilt LS exposes any custom settings
        },
      },
    },
  },
}
