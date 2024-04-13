return {
  {
    "nanotee/sqls.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function(_)
      require("lspconfig").sqls.setup({
        on_attach = function(client, bufnr)
          require("sqls").on_attach(client, bufnr)
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "sqlfluff" })
        end,
      },
    },
    opts = {
      formatters_by_ft = {
        sql = { "sqlfluff" },
      },
    },
  },
}
