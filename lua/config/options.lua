-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.g.root_spec = { "lsp", "tsconfig.json", "jsconfig.json", "package.json", { ".git", "lua" }, "cwd" }
-- colorscheme overrides
--
vim.api.nvim_set_hl(0, "@tag.tsx", { link = "dark_red" })
vim.api.nvim_set_hl(0, "link", { link = "dark_red" })

-- local package_path_str =
--   "/opt/homebrew/Cellar/luarocks/3.11.0/share/lua/5.4/?.lua;/opt/homebrew/share/lua/5.4/?.lua;/opt/homebrew/share/lua/5.4/?/init.lua;/opt/homebrew/lib/lua/5.4/?.lua;/opt/homebrew/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/Users/b/.luarocks/share/lua/5.4/?.lua;/Users/b/.luarocks/share/lua/5.4/?/init.lua;/?.lua;/?/init.lua;"
-- local package_cpath_str =
--   "/opt/homebrew/lib/lua/5.4/?.so;/opt/homebrew/lib/lua/5.4/loadall.so;./?.so;/Users/b/.luarocks/lib/lua/5.4/?.so;/?.so;"
--
-- package.path = package.path .. ";" .. package_path_str
-- package.cpath = package.cpath .. ";" .. package_cpath_str

vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.opt.grepprg = "rg --ignore-file .gitignore --color never --no-heading --line-number --hidden --follow --smart-case"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({
      bufnr = args.buf,
      timeout_ms = 10000,
      lsp_fallback = true,
    })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function(args)
    vim.api.nvim_create_augroup("LazyFormat", { clear = true })
    vim.api.nvim_create_augroup("plugin-clang-format-auto-format", { clear = true })
    vim.api.nvim_create_augroup("lazyvim_auto_create_dir", { clear = true })
  end,
})
