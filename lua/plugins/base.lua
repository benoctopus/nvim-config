-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

return {
{
    "LazyVim/LazyVim",
    dependencies = {"rebelot/kanagawa.nvim"},
    opts = {
      colorscheme = "kanagawa-dragon",
    },
  },
  {
      "rebelot/kanagawa.nvim",
      opts = {
        overrides = function()
          return {
            -- Change the color of strings
            String = { fg = '#916546' }, -- Change this hex color to your preferred string color
            -- You can also customize other syntax elements if needed
            -- Add gray borders between splits
            VertSplit = { fg = '#555555' }, -- Medium gray for vertical split borders
            WinSeparator = { fg = '#555555' }, -- Same color for window separators
          }
        end,
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
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   dependencies = {
  --     {
  --       "nvim-telescope/telescope-fzf-native.nvim",
  --       build = "make",
  --     },
  --     {
  --       "benfowler/telescope-luasnip.nvim"
  --     }
  --   },
  --   config = function()
  --     require("telescope").load_extension("fzf")
  --     require("telescope").load_extension("luasnip")
  --   end,
  --   keys = {
  --     {"<leader>/", false},
  --     -- change a keymap
  --     { "<leader>ff",
  --       function()
  --         local opts = { hidden = true }
  --         if vim.fn.finddir(".git", ".;") ~= "" then
  --           require('telescope.builtin').git_files(opts)
  --         else
  --           opts.file_ignore_patterns = { ".git/" }
  --           require('telescope.builtin').find_files(opts)
  --         end
  --       end,
  --       desc = "Find Files",
  --       silent = true,
  --       noremap = true,
  --     },
  --     { 
  --       "<leader>fg", 
  --       function() require('telescope.builtin').live_grep() end, 
  --       desc = "Live Grep",
  --       silent = true,
  --       noremap = true,
  --     },
  --     -- add a keymap to browse plugin files
  --     {
  --       "<leader>fp",
  --       function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
  --       desc = "Find Plugin File",
  --     },
  --   }
  -- },
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
