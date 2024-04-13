
" :set listchars=trail:~,tab:\ \
:set listchars=trail:~,tab:\ \ ,space:⋅
:set list

" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
call plug#begin("~/nvim/plugged")

Plug 'nvim-lua/plenary.nvim',
Plug 'mracos/mermaid.vim'
Plug 'nvim-telescope/telescope.nvim',
Plug 'BurntSushi/ripgrep' " I think this is required by something else
Plug 'nvim-tree/nvim-web-devicons',
Plug 'brooth/far.vim'
Plug 'MunifTanjim/nui.nvim'
Plug 'easymotion/vim-easymotion'
Plug 'tomasr/molokai'
Plug 'fmoralesc/molokayo'
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'rhysd/vim-clang-format'
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw);
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'mfussenegger/nvim-dap' " Debugging
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'jose-elias-alvarez/null-ls.nvim' " Not sure what this is for
Plug 'sharkdp/fd'
Plug 'ThePrimeagen/harpoon'
Plug 'rking/ag.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
Plug 'ruifm/gitlinker.nvim'
Plug 'mattn/emmet-vim'
Plug 'rmagatti/auto-session'
Plug 'Mofiqul/vscode.nvim'
Plug 'kdheepak/tabline.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'rcarriga/nvim-dap-ui'
Plug 'projekt0n/github-nvim-theme'
Plug 'tpope/vim-fugitive'
Plug 'ellisonleao/glow.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'benoctopus/vim-github-link'
Plug 'github/copilot.vim'
Plug 'vuciv/vim-bujo'
Plug 'leoluz/nvim-dap-go'
Plug 'mxsdev/nvim-dap-vscode-js'
Plug 'microsoft/vscode-js-debug'
Plug 'Joakker/lua-json5'
Plug 'windwp/nvim-autopairs'
Plug 'neovim/nvim-lspconfig'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

lua << EOF
require("nvim-autopairs").setup {}
EOF

command -nargs=? -bar Gdl call setqflist(map(systemlist("git diff --pretty='' --name-only <args>"), '{"filename": v:val, "lnum": 1}'))

let g:NERDTreeHijackNetrw = 0
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1
let g:far#enable_undo = 1
let g:far#source = 'rgnvim'
set gp=rg\ --ignore-file\ .gitignore\ --color\ never\ --no-heading\ --line-number\ --hidden\ --follow\ --smart-case

let g:go_fmt_autosave = 0

" Auto session setup

lua << EOF
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
    if  not vim.api.nvim_buf_is_loaded(buf) or not is_visible(buf) then
      vim.api.nvim_buf_delete(buf, {force = true})
    end
  end
end

vim.api.nvim_create_user_command('Bdi', close_inactive_bufs, {})

EOF

let g:go_fmt_command = "golines"
let g:go_fmt_options = {
    \ 'golines': '-m 100',
    \ }

lua << EOF
-- harpoon bindings
require("harpoon").setup({
	tabline = true
})


vim.keymap.set('n', '<space>ha', function() require("harpoon.mark").add_file() end)
vim.keymap.set('n', '<space>hf', function() require("harpoon.ui").toggle_quick_menu() end)
vim.keymap.set('n', '<space>hj', function() require("harpoon.ui").nav_next() end)
vim.keymap.set('n', '<space>hk', function() require("harpoon.ui").nav_prev() end)
vim.keymap.set('n', '<space>h1', function() require("harpoon.ui").nav_file(1) end)
vim.keymap.set('n', '<space>h2', function() require("harpoon.ui").nav_file(2) end)
vim.keymap.set('n', '<space>h3', function() require("harpoon.ui").nav_file(3) end)
vim.keymap.set('n', '<space>h4', function() require("harpoon.ui").nav_file(4) end)
vim.keymap.set('n', '<space>h5', function() require("harpoon.ui").nav_file(5) end)
vim.keymap.set('n', '<space>h6', function() require("harpoon.ui").nav_file(6) end)
vim.keymap.set('n', '<space>h7', function() require("harpoon.ui").nav_file(7) end)
vim.keymap.set('n', '<space>h8', function() require("harpoon.ui").nav_file(8) end)
vim.keymap.set('n', '<space>h9', function() require("harpoon.ui").nav_file(9) end)

EOF

lua << EOF

-- dap config
-- require('dap-vscode-js').setup({
--    debugger_path = '/Users/b/nvim/plugged/vscode-js-debug',
--    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' },
--})

local dap = require('dap')

require('dap-go').setup()
dap.adapters.go = function(callback, config)
  -- This tells nvim-dap where to find the remote debugging adapter
  -- Adjust the port and host as necessary to match your setup
	local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local host = '127.0.0.1'
  local port = config.port or 38697

	local opts = {
    stdio = {nil, stdout},
    args = {"dap", "-l", "127.0.0.1:" .. port, "--api-version=2", "--accept-multiclient"},
    detached = true
  }
  handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print("dlv exited with code", code)
    end
  end)

  assert(handle, "Error running dlv: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require('dap.repl').append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(function()
    callback({type = "server", host = "127.0.0.1", port = port})
  end, 100)
end

-- require("dap.ext.vscode").load_launchjs(nil, {})

require("nvim-dap-virtual-text").setup()
require("dapui").setup()



vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<Leader>dd', function() require("dapui").toggle() end)
vim.keymap.set('n', '<Leader>dc', function() require'dap'.clear_breakpoints() end)


EOF
" local js_based_languages = { "typescript", "javascript", "typescriptreact" }

" for _, language in ipairs(js_based_languages) do
"   dap.configurations[language] = {
"     {
"       type = "pwa-node",
"       request = "launch",
"       name = "Launch file",
"       program = "${file}",
"       cwd = "${workspaceFolder}",
"     },
"     {
"       type = "pwa-node",
"       request = "attach",
"       name = "Attach",
"       processId = require 'dap.utils'.pick_process,
"       cwd = "${workspaceFolder}",
"     },
"     {
"       type = "pwa-chrome",
"       request = "launch",
"       name = "Chrome Build Marketplace",
"       url = "http://localhost:4200",
"       webRoot = "${workspaceFolder}",
"       userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
"     }
"   }
" end

" for _, language in ipairs({  "typescript", "javascript", "typescriptreact", "javascriptreact"  }) do
"     dap.configurations[language] = {
"         {
"             name = 'Launch',
"             type = 'pwa-node',
"             request = 'launch',
"             program = '${file}',
"             rootPath = '${workspaceFolder}',
"             cwd = '${workspaceFolder}',
"             sourceMaps = true,
"             skipFiles = { '<node_internals>/**' },
"             protocol = 'inspector',
"             console = 'integratedTerminal',
"         },
"         {
"             name = 'Attach to node process',
"             type = 'pwa-node',
"             request = 'attach',
"             rootPath = '${workspaceFolder}',
"             processId = require('dap.utils').pick_process,
"         },
"         {
"             name = 'Debug Main Process (Electron)',
"             type = 'pwa-node',
"             request = 'launch',
"             program = '${workspaceFolder}/node_modules/.bin/electron',
"             args = {
"                 '${workspaceFolder}/dist/index.js',
"             },
"             outFiles = {
"                 '${workspaceFolder}/dist/*.js',
"             },
"             resolveSourceMapLocations = {
"                 '${workspaceFolder}/dist/**/*.js',
"                 '${workspaceFolder}/dist/*.js',
"             },
"             rootPath = '${workspaceFolder}',
"             cwd = '${workspaceFolder}',
"             sourceMaps = true,
"             skipFiles = { '<node_internals>/**' },
"             protocol = 'inspector',
"             console = 'integratedTerminal',
"         },
"         {
"             name = 'Compile & Debug Main Process (Electron)',
"             type = custom_adapter,
"             request = 'launch',
"             preLaunchTask = 'npm run build-ts',
"             program = '${workspaceFolder}/node_modules/.bin/electron',
"             args = {
"                 '${workspaceFolder}/dist/index.js',
"             },
"             outFiles = {
"                 '${workspaceFolder}/dist/*.js',
"             },
"             resolveSourceMapLocations = {
"                 '${workspaceFolder}/dist/**/*.js',
"                 '${workspaceFolder}/dist/*.js',
"             },
"             rootPath = '${workspaceFolder}',
"             cwd = '${workspaceFolder}',
"             sourceMaps = true,
"             skipFiles = { '<node_internals>/**' },
"             protocol = 'inspector',
"             console = 'integratedTerminal',
"         },
"     }
" end


set encoding=UTF-8

lua << EOF
require('glow').setup()
EOF


lua << END
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 500,
        tabline = 500,
        winbar = 500,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {{'filename', path=1}},
      lualine_x = {},
      lualine_y = {'encoding'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {{'filename', path=1}},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
    inactive_winbar = {},
    extensions = {}
  }
END


lua << EOF
require'tabline'.setup {
  -- Defaults configuration options
  enable = false,
  options = {
  -- If lualine is installed tabline will use separators configured in lualine by default.
  -- These options can be used to override those settings.
  section_separators = {'', ''},
  component_separators = {'', ''},
  max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
  show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
  show_devicons = true, -- this shows devicons in buffer section
  show_bufnr = false, -- this appends [bufnr] to buffer section,
  show_filename_only = false, -- shows base filename only instead of relative path in filename
  modified_icon = "+ ", -- change the default modified icon
  modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
  show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
  }
}
vim.cmd[[
  set guioptions-=e " Use showtabline in gui vim
  set sessionoptions+=tabpages,globals " store tabpages and globals in session
]]
EOF

lua << EOF
require"gitlinker".setup()
EOF

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
  -- `false` will disable the whole extension
  enable = true,

  -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
  -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
  -- the name of the parser)
  -- list of language that will be disabled
  -- disable = { "c", "rust" },
  -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  -- Using this option may slow down your editor, and you may see some duplicate highlights.
  -- Instead of true it can also be a list of languages
  additional_vim_regex_highlighting = false,
  },

}

-- require this lua file somewhere in your `init.vim`, or use `:lua`
vim.opt.list = true
vim.treesitter.language.register('markdown', 'octo')

EOF

lua << EOF
local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  vim.api.nvim_set_hl(0, "White", { fg = "#FFFFFF" })
end)

require("ibl").setup {
  indent = { highlight = highlight },
  scope = { highlight = "White"},
  exclude = {
    filetypes = {
      "lspinfo",
      "packer",
      "checkhealth",
      "help",
      "man",
      "gitcommit",
      "TelescopePrompt",
      "TelescopeResults",
      "nerdtree",
      "''",
    },
  },
}

EOF

nnoremap <space>ff <cmd>Clap files<CR>
nnoremap <space>fg <cmd>Clap grep<CR>
nnoremap <space>fb <cmd>Clap buffers<CR>
nnoremap <space>fy <cmd>Clap yanks<CR>
nnoremap <space>fc <cmd>Clap commits<CR>



" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
  call CocActionAsync('doHover')
  else
  call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
nmap <leader>f :CocCommand editor.action.formatDocument<CR>

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
vmap <leader>ac  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call   CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call   CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that

nnoremap <silent><nowait> <space>d  :<C-u>CocDiagnostics<cr>

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
  execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
  call CocActionAsync('doHover')
  else
  execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>


nmap <F8> :TagbarToggle<CR>



inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

imap <silent><script><expr> <leader><tab> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

function! ToggleCaseSensitivity()
  if &ignorecase
    set noignorecase
    echo "Case sensitivity: ON"
  else
    set ignorecase
		echo "Case sensitivity: OFF"
	endif
endfunction

set ignorecase
set relativenumber
set autoindent
set tabstop=2
set shiftwidth=2
set nowrap
set smarttab
set softtabstop=2
set mouse=a
set smartcase
set colorcolumn=100
set termguicolors
set clipboard=unnamedplus
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=1000
set signcolumn=yes


map <F9> :call ToggleCaseSensitivity()<CR>

autocmd filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd filetype rust setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd filetype javascriptreact setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd filetype typescriptreact setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd filetype lua setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd filetype go setlocal noexpandtab tabstop=2 shiftwidth=2 softtabstop=0 indentexpr=
autocmd filetype markdown setlocal autoindent expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd filetype markdown setlocal nolist
autocmd filetype markdown setlocal wrap
autocmd filetype markdown setlocal linebreak
autocmd filetype dap-repl setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd filetype dap-repl setlocal nolist
autocmd filetype dap-repl setlocal wrap
autocmd filetype dap-repl setlocal linebreak

autocmd FileType cpp autocmd BufWritePre <buffer> ClangFormat
autocmd FileType c autocmd BufWritePre <buffer> ClangFormat
autocmd FileType prisma autocmd BufWritePre <buffer> silent call CocAction('runCommand', 'editor.action.formatDocument')

autocmd FileType typescript autocmd BufWritePre <buffer> silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd FileType typescriptreact autocmd BufWritePre <buffer> silent call CocAction('runCommand', 'editor.action.organizeImport')

autocmd FileType terraform autocmd BufWritePre <buffer> silent call CocAction('runCommand', 'editor.action.formatDocument')


" autoshift mode remaps
" noremap <silent> <nowait> J j
" noremap <silent> <nowait> K k
" noremap <silent> <nowait> H h
" noremap <silent> <nowait> L l

nnoremap <silent> <space>k :call ShowDocumentation()<CR>


" lua require('vscode').load('dark')
colorscheme alduin
lua vim.api.nvim_set_hl(0, "@tag.tsx", { link = "dark_red"})
hi Conceal guibg=#121212


lua << EOF
local opts = {
  log_level = 'info',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vm.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = false,
  auto_restore_enabled = false,
  auto_session_suppress_dirs = nil,
  auto_session_use_git_branch = true,
  -- the configs below are lua only
  bypass_session_save_file_types = nil
}

require('auto-session').setup(opts)
EOF

nmap <silent> <space><space>s :SessionSave<CR>
nmap <silent> <space><space>r :SessionRestore<CR>

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_no_wrap = 1

noremap <silent> <M-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <M-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <M-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <M-l> :<C-U>TmuxNavigateRight<cr>
noremap <silent> <M-\> :<C-U>TmuxNavigatePrevious<cr>

noremap <silent> <space>tt :<C-U>RangerWorkingDirectory<cr>
noremap <silent> <space>ft :<C-U>Ranger<cr>

if !empty($COLEMAK)
	nnoremap n j	
	nnoremap j n	

	nnoremap m h
	nnoremap h m

	nnoremap i l
	nnoremap l i

	nnoremap e k
	nnoremap k e
endif

" <Leader>f{char} to move to {char}
nnoremap <Leader>s <Plug>(easymotion-bd-s)
xnoremap <Leader>s <Plug>(easymotion-overwin-s)

" s{char}{char} to move to {char}{char}
nnoremap s <Plug>(easymotion-overwin-f2)
xnoremap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader><Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader><Leader>L <Plug>(easymotion-overwin-line)
xmap <Leader><Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader><Leader>w <Plug>(easymotion-bd-w)
nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)
xmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

vmap <Leader>g "ty:<C-U>grep <C-R>t<CR>
nmap <Leader>gw "tyiw:<C-U>grep <C-R>t<CR>

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
command -nargs=* Fl :grep --files --iglob '<args>'

command Gl silent !golines -w % -m 80 

