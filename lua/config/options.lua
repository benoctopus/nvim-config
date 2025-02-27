vim.g.root_spec = { "lsp", "tsconfig.json", "jsconfig.json", "package.json", { ".git", "lua" }, "cwd" }

vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.opt.grepprg = "rg --ignore-file .gitignore --color never --no-heading --line-number --hidden --follow --smart-case"

vim.diagnostic.config({
  virtual_text = {
    source = false, -- or "if_many"
    -- If you prefer a custom format, you can do:
    -- format = function(diagnostic)
    --   return string.format("%s: %s", diagnostic.source, diagnostic.message)
    -- end
  },
  float = {
    source = true,
  },
})

vim.g.snacks_animate = false
vim.g.ranger_map_keys = 0

vim.opt.rtp:append("~/.config/nvim/snippets")
