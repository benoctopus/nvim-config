return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        sqlfluff = {
          command = "sqlfluff",
          cwd = require("conform.util").root_file({ ".editorconfig", "package.json", ".sqlsrc", ".git" }),
          args = {
            "fix",
            "--dialect=postgres",
            "-",
          },
        },
      },
      formatters_by_ft = {
        markdown = { "markdownlint" },
        graphql = { "prettier" },
        sql = { "sqlfluff" },
      },
      default_format_opts = {
        format = {
          timeout_ms = 5000,
          lsp_fallback = true,
        },
      },
    },
    keys = {
      {
        "n",
        "<leader>cf",
        function()
          require("conform").format({
            timeout_ms = 10000,
            lsp_fallback = true,
          })
        end,
      },
    },
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   opts = {
  --     linters = {
  --       sqlfluff = {
  --         args = {
  --           "lint",
  --           "--format=json",
  --           -- note: users will have to replace the --dialect argument accordingly
  --           "--dialect=postgres",
  --         },
  --       },
  --     },
  --   },
  -- },
}
