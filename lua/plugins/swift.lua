return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {},
      },
    },
  },
   {
     "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.swift = vim.list_extend(opts.formatters_by_ft.swift or {}, { "swiftformat" })
    end,
  },
}
