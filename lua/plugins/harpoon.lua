return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-lualine/lualine.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<leader>hh", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set("n", "<leader>h1", function()
        harpoon:list():select(1)
      end)

      vim.keymap.set("n", "<leader>h2", function()
        harpoon:list():select(2)
      end)

      vim.keymap.set("n", "<leader>h3", function()
        harpoon:list():select(3)
      end)

      vim.keymap.set("n", "<leader>h4", function()
        harpoon:list():select(4)
      end)

      vim.keymap.set("n", "<leader>h5", function()
        harpoon:list():select(5)
      end)

      vim.keymap.set("n", "<leader>h6", function()
        harpoon:list():select(6)
      end)

      vim.keymap.set("n", "<leader>h7", function()
        harpoon:list():select(7)
      end)

      vim.keymap.set("n", "<leader>h8", function()
        harpoon:list():select(8)
      end)

      vim.keymap.set("n", "<leader>h9", function()
        harpoon:list():select(9)
      end)

      vim.cmd([[highlight HarpoonActive guifg=#ffffff guibg=#1e222a]])
      vim.cmd([[highlight HarpoonNumberActive guifg=#ffffff guibg=#1e222a]])

      function Harpoon_files()
        local contents = {}
        local marks_length = harpoon:list():length()
        local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
        for index = 1, marks_length do
          local harpoon_file_path = harpoon:list():get(index).value
          local file_name = harpoon_file_path == "" and "(empty)" or vim.fn.fnamemodify(harpoon_file_path, ":t")

          if current_file_path == harpoon_file_path then
            contents[index] =
              string.format("%%#HarpoonNumberActive# %s %%#HarpoonActive#%s ", index, "-- " .. file_name .. " --")
          else
            contents[index] = string.format("%%#HarpoonNumberInactive# %s %%#HarpoonInactive#%s ", index, file_name)
          end
        end

        return table.concat(contents)
      end

      vim.opt.showtabline = 2
      vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "User" }, {
        callback = function(ev)
          vim.o.tabline = Harpoon_files()
        end,
      })

      vim.o.tabline = Harpoon_files()
    end,
  },
}
