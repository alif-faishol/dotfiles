call plug#begin('~/.vim/plugged')

Plug 'crater2150/vim-theme-chroma'
Plug 'scrooloose/nerdtree'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim', {'branch': 'lua'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'sainnhe/sonokai'
Plug 'norcalli/nvim-colorizer.lua'
" Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'antoinemadec/FixCursorHold.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'RishabhRD/popfix'
Plug 'hood/popui.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'lewis6991/gitsigns.nvim'

call plug#end()

set number
set rnu
set termguicolors
set signcolumn=yes:1
let g:sonokai_style = 'shusia'
let g:sonokai_enable_italic = 1
let g:sonokai_transparent_background = 1
colorscheme sonokai
set mouse=a
set cursorline
set wrap
set splitbelow
set splitright

set tabstop=2
set shiftwidth=2
set expandtab

set ignorecase
set smartcase

set lazyredraw

set splitbelow
set splitright
set shortmess+=c

" uses italic for some cases
" --------------------------
" hi htmlArg gui=italic
" hi Comment gui=italic
" hi Type    gui=italic
" hi htmlArg cterm=italic
" hi Comment cterm=italic
" hi Type    cterm=italic


let mapleader      = ','
let maplocalleader = ','

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let $PATH = '/Users/alifaishol/.fnm/node-versions/v16.13.1/installation/bin:' . $PATH

let g:cursorhold_updatetime = 1000

autocmd CursorHold * lua vim.lsp.diagnostic.show_position_diagnostics()
"autocmd BufWritePre * lua vim.lsp.buf.formatting_seq_sync()
lua <<EOF
local lsp_installer = require("nvim-lsp-installer")
vim.ui.select = require"popui.ui-overrider"

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		underline = true,
		signs = true,
	}
)

require('gitsigns').setup({
  current_line_blame = true
})

local signs = {
    Error = "! ",
    Warning = "⚠ ",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

-- Setup nvim-cmp.
local cmp = require'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
      capabilities = capabilities
    }

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    if server.name == "tsserver" then
      opts.on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
      end
    end

    if server.name == "eslint" then
      opts.on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
      end
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

require'colorizer'.setup()
EOF

nnoremap  <silent> K  <cmd>lua vim.lsp.buf.hover()<CR>
nmap      <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nmap      <leader>ac  <cmd>lua vim.lsp.buf.code_action()<CR>
nmap      <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap  <C-f>  <cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>


"===========================================================
" vim-airline
"===========================================================
let g:airline_theme='sonokai'


"===========================================================
" tmuxline
"===========================================================
let g:tmuxline_powerline_separators = 0


"===========================================================
" NERDTree
"===========================================================
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['.DS_Store']


"===========================================================
" editorconfig
" "===========================================================
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


"===========================================================
" nvim-treesitter
"===========================================================
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}
EOF
"local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
"parser_config.tsx.used_by = "typescriptreact"


"===========================================================
" Telescope.nvim
"===========================================================
nnoremap <silent> <Leader>f :Telescope find_files previewer=false theme=get_dropdown hidden=true<CR>
nnoremap <silent> <Leader>c :Telescope live_grep<CR>
lua <<EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
EOF


"===========================================================
" indentLine
"===========================================================
let g:indentLine_color_term = 237
let g:indentLine_char_list = ['│', '¦']


"===========================================================
" coc.nvim
"===========================================================
set hidden
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" 
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" 
" " Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif
" 
" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" " position. Coc only does snippet and additional edit on confirm.
" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif
" 
" nmap <silent> gd   :call CocAction('jumpDefinition', v:false)<CR>
" nmap <silent> gy   :call CocAction('jumpTypeDefinition', v:false)<CR>
" nmap <silent> gi   :call CocAction('jumpImplementation', v:false)<CR>
" nmap <silent> gr   :call CocAction('jumpReferences', v:false)<CR>
" 
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" 
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction
" 
" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Symbol renaming
" nmap <leader>rn <Plug>(coc-rename)
" 
" " Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)

