return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- prevent LazyVim from auto-installing any mason package for servers
      servers = {
        zls = {
          mason = false, -- don't auto-install zls via mason; use system zls
          settings = {
            zls = {
              -- Re-run the build runner on save so newly added build.zig
              -- dependencies (e.g. `@import("zglfw")`) resolve without a
              -- manual `:LspRestart`.
              zig_exe_path = vim.fn.exepath("zig"),
            },
          },
        },
      },
    },
  },
}
