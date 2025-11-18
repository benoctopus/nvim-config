return {
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
  {
    "nanotee/sqls.nvim",
    config = function()
      local function get_config()
        local config_path = vim.fs.find(".sqlsrc.json", { upward = true })[1]
        if config_path and vim.fn.filereadable(config_path) == 1 then
          local content = vim.fn.readfile(config_path)
          if content and #content > 0 then
            local ok, config = pcall(vim.fn.json_decode, table.concat(content, "\n"))
            if ok and config then
              return config
            end
          end
        end
      end

      require("lspconfig").sqls.setup({
        on_attach = function(client, bufnr)
          require("sqls").on_attach(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        settings = {
          sqls = get_config(),
        },
      })
    end,
  },
  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim", -- (optional) to show previews
      "nvim-tree/nvim-tree.lua", -- (optional) to manage project files
      "stevearc/oil.nvim", -- (optional) to manage project files
      "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
    },
    config = function()
      require("xcodebuild").setup({
        filetype = "swift",
      })
    end,
  },

  -- ------------------------------------------ golangcilint --------------------------------------
  -- {
  --   "neovim/nvim-lspconfig",
  --   -- Adding a custom server configuration
  --   opts = {
  --     servers = {
  --       golangci_lint_ls = {
  --         cmd = { "golangci-lint-langserver" },
  --         filetypes = { "go", "gomod" }, -- Specify the file types for this server
  --         root_dir = function(fname)
  --           -- Find the project root using a .git directory or go.mod file
  --           local lspconfig = require("lspconfig")
  --           return lspconfig.util.root_pattern(".git", "go.mod")(fname)
  --         end,
  --         init_options = {
  --           command = {
  --             "golangci-lint",
  --             "run",
  --             "--output.json.path", -- For golangci-lint v2+
  --             "stdout",
  --             "--show-stats=false",
  --             "--issues-exit-code=1",
  --           },
  --         },
  --       },
  --     },
  --     -- setup = {
  --     --   golangcilsp = function(_, opts)
  --     --     local lspconfig = require("lspconfig")
  --     --     local configs = require("lspconfig/configs")
  --     --
  --     --     if not configs.golangcilsp then
  --     --       configs.golangcilsp = {
  --     --         default_config = {
  --     --           cmd = { "golangci-lint-langserver" },
  --     --           root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
  --     --           init_options = {
  --     --             command = {
  --     --               "golangci-lint",
  --     --               "run",
  --     --               "--output.json.path",
  --     --               "stdout",
  --     --               "--show-stats=false",
  --     --               "--issues-exit-code=1",
  --     --             },
  --     --           },
  --     --         },
  --     --       }
  --     --     end
  --     --     lspconfig.golangci_lint_ls.setup({
  --     --       filetypes = { "go", "gomod" },
  --     --     })
  --     --   end,
  --     -- },
  --   },
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     --     -- make sure mason installs the server
  --     servers = {
  --       sqlls = {
  --         -- Set the root directory to the git repository root
  --         root_dir = function(fname)
  --           return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
  --         end,
  --         filetypes = { "sql" },
  --         settings = {
  --           sqlLanguageServer = (function()
  --             -- Try to read the sqlls config file from repo root, cwd, or home dir
  --             local possible_paths = {
  --               vim.fs.find(".sqllsrc.json", { upward = true })[1], -- repo root
  --               vim.fn.getcwd() .. "/.sqllsrc.json", -- current working dir
  --               vim.fn.expand("~/.sqllsrc.json"), -- user's home dir
  --             }
  --             for _, path in ipairs(possible_paths) do
  --               if path and vim.fn.filereadable(path) == 1 then
  --                 local content = vim.fn.readfile(path)
  --                 if content and #content > 0 then
  --                   local ok, config = pcall(vim.fn.json_decode, table.concat(content, "\n"))
  --                   if ok and config then
  --                     return config
  --                   end
  --                 end
  --               end
  --             end
  --             -- Return empty table if no config file found or couldn't be parsed
  --             return {}
  --           end)(),
  --         },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --   "neovim/nvim-lspconfig",
  --     "hrsh7th/cmp-nvim-lsp",
  --     { "antosha417/nvim-lsp-file-operations", config = true },
  --   },
  --   config = function()
  --     local lspconfig = require("lspconfig")
  --     local cmp_nvim_lsp = require("cmp_nvim_lsp")
  --     local keymap = vim.keymap -- for conciseness
  --     local opts = { noremap = true, silent = true }
  --
  --     local capabilities = cmp_nvim_lsp.default_capabilities()
  --     local defaultLSPs = {
  --       "sourcekit",
  --     }
  --
  --     for _, lsp in ipairs(defaultLSPs) do
  --       lspconfig[lsp].setup({
  --         capabilities = capabilities,
  --         -- on_attach = on_attach,
  --         cmd = lsp == "sourcekit" and { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) } or nil,
  --       })
  --     end
  --
  --     opts.desc = "Show line diagnostics"
  --     keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
  --   end,
  -- },
}
