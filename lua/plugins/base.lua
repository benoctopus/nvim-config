-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

return {
  -- {
  --   dir = "~/code/vim-plugins/bdi.nvim"
  -- },
  {
    "echasnovski/mini.animate",
    enabled = false,
    event = "VeryLazy",
    opts = function()
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      }
    end,
  },
  -- { "akinsho/bufferline.nvim", enabled = false },
  { 'rafi/awesome-vim-colorschemes' },
  {
    "LazyVim/LazyVim",
    dependencies = {'rafi/awesome-vim-colorschemes'},
    opts = {
      colorscheme = "alduin",
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
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    opts = function(_, opts)
      vim.tbl_deep_extend("force", opts.defaults or {}, {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      })
      opts.defaults.mappings = opts.defaults.mappings or {}
      vim.tbl_deep_extend("force", opts.defaults.mappings.i or {}, {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous"
      })
    end,
    config = function()
      require("telescope").load_extension("fzf")
    end,
    keys = {
      {"<leader>/", false},
      -- change a keymap
      { "<leader>ff",
        function () require('telescope.builtin').find_files({ hidden = true }) end,
        desc = "Find Files"
      },
      { "<leader>fg", function() require('telescope.builtin').live_grep() end, desc = "Find Files" },
      -- add a keymap to browse plugin files
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
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
    'BurntSushi/ripgrep'
  },
  {
    'brooth/far.vim'
  },
  {
    'easymotion/vim-easymotion',
    enabled = false

  },
  {
    'rhysd/vim-clang-format'
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
