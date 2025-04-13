return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "benfowler/telescope-luasnip.nvim",
        config = function()
          require("telescope").load_extension("luasnip")
        end,
      },
    },
    keys = function()
      return {
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
          desc = "FIND",
          mode = { "n", "v" },
        },
        {
          "<leader>fg",
          function()
            require("telescope.builtin").live_grep()
          end,
          desc = "Live Grep",
          mode = { "n", "v" },
        },
        -- Alternative keybinding for live grep in case of conflicts
        {
          "<leader>fl",
          function()
            require("telescope.builtin").live_grep()
          end,
          desc = "Live Grep (alt)",
          mode = { "n", "v" },
        },
        -- add a keymap to browse plugin files
        {
          "<leader>fp",
          function()
            require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
          end,
          desc = "Find Plugin File",
          mode = { "n", "v" },
        },
      }
    end,
  },
}
