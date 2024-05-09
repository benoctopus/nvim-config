-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--#region

local unmapped = false

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
  callback = function()
    if not unmapped then
      unmapped = true
      vim.cmd("unmap n")
    end

    -- TODO: figure out how to disable this without hack
    vim.api.nvim_create_augroup("LazyFormat", { clear = true })
    vim.api.nvim_create_augroup("plugin-clang-format-auto-format", { clear = true })
    vim.api.nvim_create_augroup("lazyvim_auto_create_dir", { clear = true })
  end,
})
