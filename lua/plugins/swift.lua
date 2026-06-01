return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {
          cmd = { "sourcekit-lsp" },
          filetypes = { "swift" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "buildServer.json",
              "Package.swift",
              "*.xcodeproj",
              "*.xcworkspace",
              ".git"
            )(fname)
          end,
          capabilities = {
            workspace = {
              didChangeWatchedFiles = { dynamicRegistration = true },
            },
          },
        },
      },
    },
  },
}
