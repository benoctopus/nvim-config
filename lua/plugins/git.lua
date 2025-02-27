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
}
