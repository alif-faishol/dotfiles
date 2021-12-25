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
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'sainnhe/sonokai'
Plug 'norcalli/nvim-colorizer.lua'
" Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'

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

" Neovim providers
let $PATH = '/Users/alifaishol/.nvm/versions/node/v14.17.0/bin:' . $PATH
let g:python3_host_prog = '/usr/local/opt/python3/bin/python3'


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
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> gd   :call CocAction('jumpDefinition', v:false)<CR>
nmap <silent> gy   :call CocAction('jumpTypeDefinition', v:false)<CR>
nmap <silent> gi   :call CocAction('jumpImplementation', v:false)<CR>
nmap <silent> gr   :call CocAction('jumpReferences', v:false)<CR>

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

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

