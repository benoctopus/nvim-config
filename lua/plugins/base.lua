-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

return {
  {
    dir = "~/code/vim-plugins/bdi.nvim"
  },
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
  { "akinsho/bufferline.nvim", enabled = false },
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
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      local function updateTabline()
        local marks = harpoon:list().items

        local tabline = ""
        for i, mark in ipairs(marks) do
          tabline = tabline .. " " .. i .. ":" .. mark.value
        end
        print(tabline)
        -- Set the Neovim tabline
        vim.o.tabline = tabline
        vim.o.showtabline = 2
      end

      harpoon:setup({
        default = {
          add = function(_)
            updateTabline()
          end
        },
        settings = {
          save_on_toggle = false,
          sync_on_ui_close = false,
        }
      })

      vim.keymap.set("n", "<localleader>hd", updateTabline, { noremap = true })

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():append()
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
    end,
  },
  {
    'BurntSushi/ripgrep'
  },
  {
    'brooth/far.vim'
  },
  {
    'easymotion/vim-easymotion'
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
    'github/copilot.vim'
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.experimental = { ghost_text = false }
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      opts.sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "path" },
        { name = "emoji" },
      }

      local luasnip = require("luasnip")
      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-J>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-K>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<S-TAB>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
             luasnip.expand_or_jump()
          else fallback()
          end
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then cmp.confirm({select = true})
          else fallback()
          -- if cmp.visible() then
          --   cmp.confirm({select = true})
          -- elseif luasnip.expand_or_jumpable() then
          --   luasnip.expand_or_jump()
          --   cmp.select_next_item()
          -- elseif has_words_before() then
          --   cmp.complete()
          -- else
          --   fallback()
          -- end
          end
        end, { "i", "s" }),
      })
    end,
  },
}
