return {
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
      "dcampos/cmp-emmet-vim",
      "mattn/emmet-vim",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.experimental = { ghost_text = false }

      vim.tbl_extend("force", opts.sources, {
        { name = "luasnip" },
      })

      -- opts.sources = {
      --   { name = "nvim_lsp" },
      --   { name = "emmet_vim" },
      --   { name = "nvim_lua" },
      --   { name = "path" },
      --   -- { name = "luasnip" },
      --   -- { name = "buffer" },
      --   -- { name = "emoji" },
      -- }

      -- local luasnip = require("luasnip")
      -- opts.snippet = {
      --   expand = function(args)
      --     require("luasnip").lsp_expand(args.body)
      --   end,
      -- }
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-J>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-K>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        -- ["<S-TAB>"] = cmp.mapping(function(fallback)
        --   if luasnip.expand_or_jumpable() then
        --     luasnip.expand_or_jump()
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
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
