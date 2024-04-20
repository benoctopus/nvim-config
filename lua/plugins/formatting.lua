return {

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "markdownlint" },
        graphql = { "prettier" },
      },
      format = {
        timeout_ms = 5000,
        lsp_fallback = true,
      },
    },
    keys = {
      {
        "n",
        "<leader>cf",
        function()
          require("conform").format({
            bufnr = args.buf,
            timeout_ms = 10000,
            lsp_fallback = true,
          })
        end,
      },
    },
  },
}
