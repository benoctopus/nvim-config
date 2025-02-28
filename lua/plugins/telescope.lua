return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      {
        "benfowler/telescope-luasnip.nvim",
      },
    },
    opts = function(opts)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("luasnip")
      return opts
    end,
    keys = {
      {
        "<leader>ff",
        function()
          local opts = { hidden = true }
          if vim.fn.finddir(".git", ".;") ~= "" then
            require("telescope.builtin").git_files(opts)
          else
            opts.file_ignore_patterns = { ".git/" }
            require("telescope.builtin").find_files(opts)
          end
        end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep",
      },
      -- add a keymap to browse plugin files
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
  },
}
