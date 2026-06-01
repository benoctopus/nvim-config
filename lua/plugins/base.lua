return {
  {
    "LazyVim/LazyVim",
    opts = {
      defaults = {
        plugins = false, -- do not load LazyVim's default extra plugins
      },
    },
  },
  {
    "LazyVim/LazyVim",
    dependencies = {
      "vague-theme/vague.nvim",
      opts = {
        transparent = false, -- If true, background is not set
        bold = true, -- Disable bold globally
        italic = true, -- Disable italic globally
        on_highlights = function(hl, colors) end,
        colors = {
          bg = "#000000",
          inactiveBg = "#1c1c24",
          fg = "#cdcdcd",
          floatBorder = "#878787",
          line = "#252530",
          comment = "#606079",
          builtin = "#b4d4cf",
          func = "#c48282",
          string = "#e8b589",
          number = "#e0a363",
          property = "#c3c3d5",
          constant = "#aeaed1",
          parameter = "#bb9dbd",
          visual = "#333738",
          error = "#d8647e",
          warning = "#f3be7c",
          hint = "#7e98e8",
          operator = "#90a0b5",
          keyword = "#6e94b2",
          type = "#9bb4bc",
          search = "#405065",
          plus = "#7fa563",
          delta = "#f3be7c",
        },
      },
    },
    opts = {
      colorscheme = "vague",
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    config = function()
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
    },
  },
  {
    "ellisonleao/glow.nvim",
  },
  {
    "github/copilot.vim",
    enabled = true,
  },
}
