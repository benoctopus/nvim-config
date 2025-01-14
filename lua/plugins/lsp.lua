return {
  {
    "folke/neodev.nvim",
    opts = {
      library = { plugins = { "neotest" }, types = true },
    },
  },
  {
    "nvim-neotest/neotest-plenary",
    enabled = true,
    {
      "neovim/nvim-lspconfig",
      opts = {
        inlay_hints = { enabled = false },
      },
    },
  },
  -- {
  --   "folke/trouble.nvim",
  --   branch = "dev", -- IMPORTANT!
  --   keys = {
  --     {
  --       "<leader>xx",
  --       "<cmd>Trouble diagnostics toggle<cr>",
  --       desc = "Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>xX",
  --       "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  --       desc = "Buffer Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>cs",
  --       "<cmd>Trouble symbols toggle focus=false<cr>",
  --       desc = "Symbols (Trouble)",
  --     },
  --     {
  --       "<leader>cl",
  --       "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  --       desc = "LSP Definitions / references / ... (Trouble)",
  --     },
  --     {
  --       "<leader>xL",
  --       "<cmd>Trouble loclist toggle<cr>",
  --       desc = "Location List (Trouble)",
  --     },
  --     {
  --       "<leader>xQ",
  --       "<cmd>Trouble qflist toggle<cr>",
  --       desc = "Quickfix List (Trouble)",
  --     },
  --   },
  --   opts = {}, -- for default options, refer to the configuration section for custom setup.
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      --     -- make sure mason installs the server
      servers = {
        --       terraformls = {
        --         on_attach = function(client, bufnr)
        --           -- Optional: Add your custom on_attach functions here
        --         end,
        --         filetypes = { "terraform", "tf" },
        --         -- Adjust settings to your liking:
        --         settings = {
        --           terraform = {
        --             index = {
        --               module = true,
        --               provider = true,
        --             },
        --           },
        --         },
        --       },
        --       -- yamlls = {
        --       --   filetypes = { "yaml", "yml" },
        --       --   settings = {
        --       --     yaml = {
        --       --       schemas = {
        --       --         ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        --       --         ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/*docker-compose*",
        --       --       },
        --       --     },
        --       --   },
        --       -- },
      },
      --       gopls = {
      --         keys = {
      --           -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
      --           { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
      --         },
      --         settings = {
      --           gopls = {
      --             gofumpt = true,
      --             codelenses = {
      --               gc_details = false,
      --               generate = true,
      --               regenerate_cgo = true,
      --               run_govulncheck = true,
      --               test = true,
      --               tidy = true,
      --               upgrade_dependency = true,
      --               vendor = true,
      --             },
      --             hints = {
      --               assignVariableTypes = true,
      --               compositeLiteralFields = true,
      --               compositeLiteralTypes = true,
      --               constantValues = true,
      --               functionTypeParameters = true,
      --               parameterNames = true,
      --               rangeVariableTypes = true,
      --             },
      --             analyses = {
      --               fieldalignment = true,
      --               nilness = true,
      --               unusedparams = true,
      --               unusedwrite = true,
      --               useany = true,
      --             },
      --             usePlaceholders = true,
      --             completeUnimported = true,
      --             staticcheck = true,
      --             directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      --             semanticTokens = true,
      --           },
      --         },
      --       },
      --       ---@type lspconfig.options.tsserver
      --       -- tsserver = {
      --       --   keys = {
      --       --     {
      --       --       "<leader>co",
      --       --       function()
      --       --         vim.lsp.buf.code_action({
      --       --           apply = true,
      --       --           context = {
      --       --             only = { "source.organizeImports.ts" },
      --       --             diagnostics = {},
      --       --           },
      --       --         })
      --       --       end,
      --       --       desc = "Organize Imports",
      --       --     },
      --       --     {
      --       --       "<leader>cR",
      --       --       function()
      --       --         vim.lsp.buf.code_action({
      --       --           apply = true,
      --       --           context = {
      --       --             only = { "source.removeUnused.ts" },
      --       --             diagnostics = {},
      --       --           },
      --       --         })
      --       --       end,
      --       --       desc = "Remove Unused Imports",
      --       --     },
      --       --   },
      --       --   ---@diagnostic disable-next-line: missing-fields
      --       --   settings = {
      --       --     completions = {
      --       --       completeFunctionCalls = true,
      --       --       completeUnimported = true,
      --       --
      --       --     },
      --       --   },
      --       -- },
      --     },
      --   },
      -- },
      -- {
      --   "neovim/nvim-lspconfig",
      --   opts = {
      --     -- make sure mason installs the server
      --     servers = {
      --       ---@type lspconfig.options.tsserver
      --       tsserver = {
      --         keys = {
      --           {
      --             "<leader>co",
      --             function()
      --               vim.lsp.buf.code_action({
      --                 apply = true,
      --                 context = {
      --                   only = { "source.organizeImports.ts" },
      --                   diagnostics = {},
      --                 },
      --               })
      --             end,
      --             desc = "Organize Imports",
      --           },
      --           {
      --             "<leader>cR",
      --             function()
      --               vim.lsp.buf.code_action({
      --                 apply = true,
      --                 context = {
      --                   only = { "source.removeUnused.ts" },
      --                   diagnostics = {},
      --                 },
      --               })
      --             end,
      --             desc = "Remove Unused Imports",
      --           },
      --         },
      --         ---@diagnostic disable-next-line: missing-fields
      --         settings = {
      --           completions = {
      --             completeFunctionCalls = true,
      --             completeUnimported = true,
      --           },
      --         },
      --       },
      --     },
    },
  },
}
