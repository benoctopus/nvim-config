-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

return {
  -- {
  --   "LazyVim/LazyVim",
  --   dependencies = {"rebelot/kanagawa.nvim"},
  --   opts = {
  --     colorscheme = "kanagawa-dragon",
  --   },
  -- },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   enabled = false,
  --   opts = {
  --     overrides = function()
  --       return {
  --         -- Change the color of strings
  --         String = { fg = '#916546' }, -- Change this hex color to your preferred string color
  --         -- You can also customize other syntax elements if needed
  --         -- Add gray borders between splits
  --         VertSplit = { fg = '#555555' }, -- Medium gray for vertical split borders
  --         WinSeparator = { fg = '#555555' }, -- Same color for window separators
  --       }
  --     end,
  --   },
  -- },
  {
    "LazyVim/LazyVim",
   dependencies = {'rafi/awesome-vim-colorschemes'},
    opts = {
      colorscheme = "alduin",
    },
  },
  {
      "salkin-mada/openscad.nvim",
      config = function()
          vim.g.openscad_load_snippets = true
          require("openscad")
      end,
      dependencies = { "L3MON4D3/LuaSnip", "junegunn/fzf.vim" },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Add the OpenSCAD server configuration
        openscad_ls = {
          cmd = { "openscad-lsp", "--stdio" },
          filetypes = { "openscad", "scad" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(".git")(fname) or vim.loop.cwd()
          end,
        },
      },
    },
  },
  {
    "francoiscabrol/ranger.vim",
    cmd = {
      "Ranger",
      "RangerWorkingDirectory",
    },
    dependencies = {
      "rbgrouleff/bclose.vim",
    },
    keys = {
      { "<leader>tt", "<cmd>RangerWorkingDirectory<cr>" },
      { "<leader>ft", "<cmd>Ranger<cr>" },
    }
  },
  {
    "christoomey/vim-tmux-navigator",
    config = function ()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_no_wrap = 1
    end,

    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<M-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<M-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<M-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<M-l>", "<cmd>TmuxNavigateRight<cr>" },
      { "<M-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    'easymotion/vim-easymotion',
    enabled = false

  },
  {
    'http://github.com/tpope/vim-surround'
  },
  {
    'rmagatti/auto-session'
  },
  {
    'ellisonleao/glow.nvim'
  },
  {
    'github/copilot.vim',
    enabled = true,
    config = function()
      vim.api.nvim_set_keymap(
        "i",
        "<localleader><Tab>",
        'copilot#Accept("\\<CR>")',
        { expr = true, noremap = true, silent = true }
      )

      vim.g.copilot_no_tab_map = vim.v["true"]
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
}
