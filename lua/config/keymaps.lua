-- Yank current buffer's relative path
vim.keymap.set("n", "<leader><leader>y", function()
  local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
  vim.fn.setreg("+", relative_path)
  vim.notify('Copied "' .. relative_path .. '" to clipboard')
end, { desc = "Yank relative path" })

-- Yank current buffer's absolute path
vim.keymap.set("n", "<leader><leader>Y", function()
  local absolute_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":p")
  vim.fn.setreg("+", absolute_path)
  vim.notify('Copied "' .. absolute_path .. '" to clipboard')
end, { desc = "Yank absolute path" })

-- LSP Keybinds

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

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
  local comment_string = vim.bo.commentstring or "// %s"
  local line = vim.split(comment_string, "%%s")[1]

  if title == nil or string.len(title) == 0 then
    return line .. string.rep("-", total_len - string.len(line))
  end

  local content_len = total_len - string.len(line)
  local title_len = string.len(title)

  line = line .. string.rep("-", math.floor((content_len / 2) - (title_len / 2))) .. " " .. title .. " "
  return line .. string.rep("-", content_len - string.len(line))
end

vim.api.nvim_create_user_command("TitleComment", function(args)
  local title = args.args
  vim.print("Title: " .. title)
  local title_comment = create_titile_comment(title)
  vim.api.nvim_put({ title_comment }, "l", true, true)
end, { nargs = "?" })

vim.api.nvim_set_keymap("n", "<leader>tc", ":TitleComment ", { noremap = true, silent = true })

--------------------------------------------- cmux -------------------------------------
local function smart_pane_navigate(direction)
  -- Map vim directions to cmux directions
  local direction_map = {
    h = "left",
    j = "down",
    k = "up",
    l = "right",
  }

  local cmux_direction = direction_map[direction]
  if not cmux_direction then
    return
  end

  -- Get current window number
  local current_win = vim.fn.winnr()

  -- Try to move within neovim first
  vim.cmd("wincmd " .. direction)

  -- Check if we actually moved
  local new_win = vim.fn.winnr()

  -- If we didn't move, we're at the edge - try to switch CMUX pane
  if current_win == new_win then
    local cmux_cmd = string.format("cmux focus-pane --direction %s", cmux_direction)
    vim.fn.system(cmux_cmd)
  end
end

-- Map Opt+h/j/k/l (using the escape sequences from Ghostty)
vim.keymap.set("n", "<M-h>", function()
  smart_pane_navigate("h")
end, { silent = true, desc = "Navigate left (neovim/cmux)" })
vim.keymap.set("n", "<M-j>", function()
  smart_pane_navigate("j")
end, { silent = true, desc = "Navigate down (neovim/cmux)" })
vim.keymap.set("n", "<M-k>", function()
  smart_pane_navigate("k")
end, { silent = true, desc = "Navigate up (neovim/cmux)" })
vim.keymap.set("n", "<M-l>", function()
  smart_pane_navigate("l")
end, { silent = true, desc = "Navigate right (neovim/cmux)" })
