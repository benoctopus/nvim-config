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
  },
}
