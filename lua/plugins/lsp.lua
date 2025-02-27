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
  {
    "neovim/nvim-lspconfig",
    opts = {
      --     -- make sure mason installs the server
      servers = {
        sqlls = {
          -- Set the root directory to the git repository root
          command = "sql-language-server",
          args = { "up", "--method", "stdio" },
          root_dir = function(fname)
            return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
          end,
          filetypes = { "sql" },
          settings = {
            sqlLanguageServer = (function()
              -- Try to read the sqlls config file from repo root, cwd, or home dir
              local possible_paths =
                vim.fs.find(".sqllsrc.json", { upward = true, stop = vim.fn.expand("~/"), limit = 10 })

              local config = { connections = {} }

              for _, path in ipairs(possible_paths) do
                local content = vim.fn.readfile(path)
                if content and #content > 0 then
                  local ok, parsed = pcall(vim.fn.json_decode, table.concat(content, "\n"))
                  if ok and parsed then
                    -- Special handling for connections array
                    if parsed.connections then
                      for _, conn in ipairs(parsed.connections) do
                        if conn.projectPaths then
                          for _, pp in ipairs(conn.projectPaths) do
                            if pp == "." then
                              conn.projectPaths = { vim.fs.dirname(path) }
                              break
                            end
                          end
                          table.insert(config.connections, conn)
                        end
                      end
                      parsed.connections = nil
                    end
                    -- Merge the rest of the config normally
                    config = vim.tbl_deep_extend("force", config, parsed)
                  end
                end
              end
              return config
            end)(),
          },
        },
      },
    },
  },
}
