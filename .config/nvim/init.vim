" ---------------------------------------------------------------------
"  Vim-Plug
" ---------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'KabbAmine/vCoolor.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-obsession'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-smooth-scroll'

" Display
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'flazz/vim-colorschemes'
Plug 'crater2150/vim-theme-chroma'
Plug 'airblade/vim-gitgutter'
Plug 'hachy/eva01.vim'

" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" Syntax
Plug 'fleischie/vim-styled-components'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/syntastic'

call plug#end()

" ---------------------------------------------------------------------
" Vim config
" ---------------------------------------------------------------------
set number
set rnu                                                 " relative number
syntax on
set clipboard=unnamed                                   " clipboard yanking
filetype plugin indent on
set showcmd
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175
set termguicolors
set timeoutlen=1000 ttimeoutlen=0
set mouse=a                                             " enable mouse support
set wrap
set cursorline
set showbreak=↪\ \ 

" tab
" ---
set tabstop=2                                           " show existing tab with 4 spaces width
set shiftwidth=2                                        " when indenting with '>', use 4 spaces width
set expandtab                                           " On pressing tab, insert 4 spaces

" fold
" ----
set foldmethod=indent
set nofoldenable                                        " don't auto fold at start
nnoremap <space> za

" search
" ------
set hlsearch
noremap <silent> <Leader><space> :noh<cr>
set incsearch
set ignorecase
set smartcase

set ttyfast
set lazyredraw

colorscheme chroma
set background=dark
set splitbelow
set splitright
set omnifunc=syntaxcomplete#Complete
let mapleader      = ','
let maplocalleader = ','
map <leader>bp :bp<cr>
map <leader>bn :bn<cr>

map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tj :tabnext<cr>
map <leader>tk :tabprevious<cr>
map <leader>th :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove<cr>

nnoremap n nzzzv
nnoremap N Nzzzv

" mapping to split window for 1 file, good for long file
noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" uses italic for some cases
" --------------------------
hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

" ---------------------------------------------------------------------
"  Plugin Config
" ---------------------------------------------------------------------

" NERDTree
" --------
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['.DS_Store']


" Syntastic
" ---------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = "PATH=$(npm bin):$PATH eslint"


" vim-airline
" -----------
set laststatus=2
let g:airline_powerline_fonts = 0
let g:airline_theme='kolor'
let g:airline#extensions#tabline#enabled = 1


" deoplete
" --------
let g:deoplete#enable_at_startup = 1

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete'
\]

let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']

" Use deoplete.
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'

" move selection from top to bottom when press tab
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

"Add extra filetypes
let g:tern#filetypes = [
      \ 'jsx',
      \ 'javascript.jsx',
      \ 'vue',
      \ '...'
      \ ]

" if also uses tern_for_vim
" let g:tern#command = ['tern']
" let g:tern#arguments = ['--persistent']


" let g:deoplete#enable_at_startup = 1
" if !exists('g:deoplete#omni#input_patterns')
"   let g:deoplete#omni#input_patterns = {}
" endif
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" augroup omnifuncs
"   autocmd!
"   autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"   autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" augroup end
" if exists('g:plugs["tern_for_vim"]')
"   let g:tern_show_argument_hints = 'on_hold'
"   let g:tern_show_signature_in_pum = 1
"   autocmd FileType javascript setlocal omnifunc=tern#Complete
" endif
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>" 
" let g:deoplete#file#enable_buffer_path=1


" vCoolor
" -------
let g:vcoolor_lowercase = 1
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<leader>#'
let g:vcool_ins_rgba_map = '<leader>rgba'
let g:vcool_ins_rgb_map = '<leader>rgb'
let g:vcool_ins_hsl_map = '<leader>hsl'


" fzf
" ---
" This is the default extra key bindings
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
nnoremap <silent> <Leader>f :FZF<CR>


" indentLine
" ----------
let g:indentLine_color_term = 237
let g:indentLine_char = '│'


" emmet-vim
" ---------
let g:user_emmet_leader_key='<leader>,'


" UltiSnip
" --------
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader>l"
let g:UltiSnipsJumpBackwardTrigger="<leader>h"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" editorconfig
" ------------
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


" gitgutter
set updatetime=250

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
