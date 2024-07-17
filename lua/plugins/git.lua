return {
  {
    "tpope/vim-fugitive",
    dependencies = {
      { "tpope/vim-rhubarb" },
    },
    lazy = false,
    keys = {
      {
        "<localleader>gl",
        "<cmd>GBrowse!<cr>",
        desc = "Copy git link to file to clipboard",
        mode = { "n" },
      },
      {
        "<localleader>gl",
        "<cmd>'<,'>GBrowse!<cr>",
        desc = "Copy git link to lines to clipboard",
        mode = { "v" },
      },
      {
        "<localleader>gb",
        "<cmd>GBrowse<cr>",
        desc = "Copy git link to file to clipboard",
        mode = { "n" },
      },
      {
        "<localleader>gb",
        "<cmd>'<,'>GBrowse<cr>",
        desc = "Copy git link to lines to clipboard",
        mode = { "v" },
      },
      {
        "<localleader>gpd",
        "<cmd>G pull origin dev --no-rebase<cr>",
        desc = "git pull origin dev --no-rebase",
      },
    },
  },
  {
    "pwntester/octo.nvim",
    keys = {
      { "<localleader>gi", "<cmd>Octo issue list<CR>", desc = "List Issues (Octo)" },
      { "<localleader>gI", "<cmd>Octo issue search<CR>", desc = "Search Issues (Octo)" },
      { "<localleader>gp", "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
      { "<localleader>gP", "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
      { "<localleader>gr", "<cmd>Octo repo list<CR>", desc = "List Repos (Octo)" },
      { "<localleader>gS", "<cmd>Octo search<CR>", desc = "Search (Octo)" },

      { "<localleader>a", "", desc = "+assignee (Octo)", ft = "octo" },
      { "<localleader>c", "", desc = "+comment/code (Octo)", ft = "octo" },
      { "<localleader>l", "", desc = "+label (Octo)", ft = "octo" },
      { "<localleader>i", "", desc = "+issue (Octo)", ft = "octo" },
      { "<localleader>r", "", desc = "+react (Octo)", ft = "octo" },
      { "<localleader>p", "", desc = "+pr (Octo)", ft = "octo" },
      { "<localleader>v", "", desc = "+review (Octo)", ft = "octo" },
      { "@", "@<C-x><C-o>", mode = "i", ft = "octo", silent = true },
      { "#", "#<C-x><C-o>", mode = "i", ft = "octo", silent = true },
    },
  },
}
