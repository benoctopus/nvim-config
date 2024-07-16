return {
  {
    "thinca/vim-quickrun",
    keys = {
      { "<localleader>sr", "<cmd>QuickRun<cr>" },
      {
        "<localleader>sh",
        function()
          local h = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_option(h, "filetype", "sh")
          vim.api.nvim_set_current_buf(h)
        end,
      },
    },
  },
}
