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
  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-tree.lua", -- (optional) to manage project files
      "stevearc/oil.nvim", -- (optional) to manage project files
      "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
    },
    config = function()
      require("xcodebuild").setup({
        -- put some options here or leave it empty to use default settings
      })
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
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
        sqlls = {
          -- Set the root directory to the git repository root
          root_dir = function(fname)
            return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
          end,
          filetypes = { "sql" },
          settings = {
            sqlLanguageServer = function()
              -- Try to read the sqlls config file from repo root, cwd, or home dir
              local possible_paths = {
                vim.fs.find(".sqllsrc.json", { upward = true })[1], -- repo root
                vim.fn.getcwd() .. "/.sqllsrc.json", -- current working dir
                vim.fn.expand("~/.sqllsrc.json") -- user's home dir
              }
              
              for _, path in ipairs(possible_paths) do
                if path and vim.fn.filereadable(path) == 1 then
                  local content = vim.fn.readfile(path)
                  if content and #content > 0 then
                    local ok, config = pcall(vim.fn.json_decode, table.concat(content, "\n"))
                    if ok and config then
                      return config
                    end
                  end
                end
              end
              
              -- Return empty table if no config file found or couldn't be parsed
              return {}
            end(),
          },
        },
      },
    },
  },
}
