return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    cmd = "CopilotChat",
    opts = {
      mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "gar",
          insert = "<C-l>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-m>",
        },
        accept_diff = {
          normal = "gaa",
          insert = "<C-y>",
        },
        yank_diff = {
          normal = "gay",
        },
        show_diff = {
          normal = "gad",
        },
        show_system_prompt = {
          normal = "gap",
        },
        show_user_selection = {
          normal = "gas",
        },
      },
    },
    --   keys = {
    --     { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
    --     { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    --     {
    --       "<leader>aa",
    --       function()
    --         return require("CopilotChat").toggle()
    --       end,
    --       desc = "Toggle (CopilotChat)",
    --       mode = { "n", "v" },
    --     },
    --     {
    --       "<leader>ax",
    --       function()
    --         return require("CopilotChat").reset()
    --       end,
    --       desc = "Clear (CopilotChat)",
    --       mode = { "n", "v" },
    --     },
    --     {
    --       "<leader>aq",
    --       function()
    --         local input = vim.fn.input("Quick Chat: ")
    --         if input ~= "" then
    --           require("CopilotChat").ask(input)
    --         end
    --       end,
    --       desc = "Quick Chat (CopilotChat)",
    --       mode = { "n", "v" },
    --     },
    --     -- Show help actions with telescope
    --     { "<leader>ad", M.pick("help"), desc = "Diagnostic Help (CopilotChat)", mode = { "n", "v" } },
    --     -- Show prompts actions with telescope
    --     { "<leader>ap", M.pick("prompt"), desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
    --   },
    --   config = function(_, opts)
    --     local chat = require("CopilotChat")
    --     require("CopilotChat.integrations.cmp").setup()
    --
    --     vim.api.nvim_create_autocmd("BufEnter", {
    --       pattern = "copilot-chat",
    --       callback = function()
    --         vim.opt_local.relativenumber = false
    --         vim.opt_local.number = false
    --       end,
    --     })
    --
    --     chat.setup(opts)
    --   end,
    -- },
  },
}
