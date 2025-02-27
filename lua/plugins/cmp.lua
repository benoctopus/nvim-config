return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "saghen/blink.cmp",
    version = not vim.g.lazyvim_blink_main and "*",
    build = vim.g.lazyvim_blink_main and "cargo build --release",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- add blink.compat to dependencies
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = not vim.g.lazyvim_blink_main and "*",
      },
    },
    event = "InsertEnter",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = {
        expand = function(snippet, _)
          return LazyVim.cmp.expand(snippet)
        end,
      },
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = false,
        },
      },

      -- experimental signature help support
      -- signature = { enabled = true },

      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {},
        default = { "lsp", "path", "snippets", "buffer" },
        cmdline = {},
      },

      keymap = {
        preset = "super-tab",
      },
    },
    ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
    config = function(_, opts)
      -- setup compat sources
      local enabled = opts.sources.default
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend(
          "force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end

      -- add ai_accept to <Tab> key
      if not opts.keymap["<Tab>"] then
        if opts.keymap.preset == "super-tab" then -- super-tab
          opts.keymap["<Tab>"] = {
            require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
            LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
            "fallback",
          }
        else -- other presets
          opts.keymap["<Tab>"] = {
            LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
            "fallback",
          }
        end
      end

      -- Unset custom prop to pass blink.cmp validation
      opts.sources.compat = nil

      -- check if we need to override symbol kinds
      for _, provider in pairs(opts.sources.providers or {}) do
        ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
        if provider.kind then
          local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
          local kind_idx = #CompletionItemKind + 1

          CompletionItemKind[kind_idx] = provider.kind
          ---@diagnostic disable-next-line: no-unknown
          CompletionItemKind[provider.kind] = kind_idx

          ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
          local transform_items = provider.transform_items
          ---@param ctx blink.cmp.Context
          ---@param items blink.cmp.CompletionItem[]
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = kind_idx or item.kind
            end
            return items
          end

          -- Unset custom prop to pass blink.cmp validation
          provider.kind = nil
        end
      end

      require("blink.cmp").setup(opts)
    end,
  },
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  --
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function()
  --     require("luasnip.loaders.from_vscode").lazy_load()
  --   end,
  --   keys = function()
  --     return {}
  --   end,
  -- },
  -- -- then: setup supertab in cmp
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-emoji",
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-nvim-lua",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "L3MON4D3/LuaSnip",
  --     "dcampos/cmp-emmet-vim",
  --     "mattn/emmet-vim",
  --     "hrsh7th/cmp-nvim-lua",
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     opts.experimental = { ghost_text = false }
  --
  --     cmp.config.sources({
  --       { name = "emmet_vim", priority = 1000 },
  --       { name = "luasnip" },
  --       { name = "nvim_lsp" },
  --       { name = "nvim_lua" },
  --       { name = "buffer" },
  --       { name = "emoji" },
  --     })
  --     -- `:` cmdline setup.
  --     -- opts.sources = {
  --     --   { name = "nvim_lsp" },
  --     --   { name = "emmet_vim" },
  --     --   { name = "nvim_lua" },
  --     --   { name = "path" },
  --     --   -- { name = "luasnip" },
  --     --   -- { name = "buffer" },
  --     --   -- { name = "emoji" },
  --     -- }
  --
  --     -- local luasnip = require("luasnip")
  --     -- opts.snippet = {
  --     --   expand = function(args)
  --     --     require("luasnip").lsp_expand(args.body)
  --     --   end,
  --     -- }
  --     --
  --     opts.mapping = cmp.mapping.preset.insert({
  --       ["<C-J>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --       ["<C-K>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --       -- ["<S-TAB>"] = cmp.mapping(function(fallback)
  --       --   if luasnip.expand_or_jumpable() then
  --       --     luasnip.expand_or_jump()
  --       --   else
  --       --     fallback()
  --       --   end
  --       -- end, { "i", "s" }),
  --       ["<Tab>"] = cmp.mapping.confirm({ select = true }),
  --       --   ["<Tab>"] = cmp.mapping(function(fallback)
  --       --     if cmp.visible() then
  --       --       cmp.confirm({ select = true })
  --       --     else
  --       --       fallback()
  --       --     end
  --       --   end, { "i", "s" }),
  --     })
  --   end,
  -- },
}
