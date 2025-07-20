return {
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
    },
    keys = {
      {
        "<leader>mr", -- Key sequence (leader key followed by 'g' then 'c')
        function()
          require("gitlab").choose_merge_request()
        end,
        mode = "n", -- Normal mode
        desc = "Gitlab: Choose Merge Request", -- Description for which-key/help
      },
    },
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    config = function()
      require("gitlab").setup()
    end,
  },
}
