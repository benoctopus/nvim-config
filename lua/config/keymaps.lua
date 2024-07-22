-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--

-- copilot

-- lsp

local lspconfig = require("lspconfig")

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<leader>T", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<localleader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<localleader>ac", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<localleader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-- bdi

local is_visible = function(bufnr)
  for _, tabid in ipairs(vim.api.nvim_list_tabpages()) do
    for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabid)) do
      local winbufnr = vim.api.nvim_win_get_buf(winid)
      local winvalid = vim.api.nvim_win_is_valid(winid)

      if winvalid and winbufnr == bufnr then
        return true
      end
    end
  end

  return false
end
local function close_inactive_bufs()
  local bufs = vim.api.nvim_list_bufs()

  for _, buf in ipairs(bufs) do
    if not vim.api.nvim_buf_is_loaded(buf) or not is_visible(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

vim.api.nvim_create_user_command("Bdi", close_inactive_bufs, {})
vim.api.nvim_set_keymap(
  "i",
  "<C-e>",
  'cmp#complete({config = {sources = {{name = "emmet_language_server"}}}})',
  { noremap = true, silent = true, expr = true }
)

--------------------------------------------- Title Comment -------------------------------------

local function create_titile_comment(title)
  local total_len = 100
  local line = "// "

  if title == nil or string.len(title) == 0 then
    return line .. string.rep("-", total_len - string.len(line))
  end

  local content_len = total_len - string.len(line)
  local title_len = string.len(title)

  line = line .. string.rep("-", (content_len / 2) - (title_len / 2)) .. " " .. title .. " "
  return line .. string.rep("-", content_len - string.len(line))
end

vim.api.nvim_create_user_command("TitleComment", function(args)
  local title = args.args
  vim.print("Title: " .. title)
  local title_comment = create_titile_comment(title)
  vim.api.nvim_put({ title_comment }, "l", true, true)
end, { nargs = "?" })

vim.api.nvim_set_keymap("n", "<leader>tc", ":TitleComment ", { noremap = true, silent = true })
