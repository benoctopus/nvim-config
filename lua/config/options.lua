-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.ranger_map_keys = 0
vim.g.fugitive_gitlab_domains = { ["ssh.gitlab.1password.io"] = "https://gitlab.1password.io" }
vim.g.snacks_animate = false
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.opt.grepprg = "rg --ignore-file .gitignore --color never --no-heading --line-number --hidden --follow --smart-case"
vim.g.root_spec = { "lsp", "tsconfig.json", "jsconfig.json", "package.json", { ".git", "lua" }, "cwd" }

vim.treesitter.language.register("starlark", "tiltfile")

vim.api.nvim_set_keymap(
  "i",
  "<localleader><Tab>",
  'copilot#Accept("\\<CR>")',
  { expr = true, noremap = true, silent = true }
)

vim.g.copilot_no_tab_map = vim.v["true"]
