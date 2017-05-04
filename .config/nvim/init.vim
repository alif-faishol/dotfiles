" ---------------------------------------------------------------------
"  Vim-Plug
" ---------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/syntastic'
Plug 'KabbAmine/vCoolor.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rizzatti/dash.vim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'atelierbram/Base2Tone-vim'

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
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=2                     " blinking cursor on insert mode
set termguicolors
set timeoutlen=500 ttimeoutlen=0
set mouse=a                                             " enable mouse support
set nowrap
" tab
set tabstop=4                                           " show existing tab with 4 spaces width
set shiftwidth=4                                        " when indenting with '>', use 4 spaces width
set expandtab                                           " On pressing tab, insert 4 spaces
" fold
set foldmethod=indent                                   " folding based on indent
set nofoldenable                                        " don't auto fold at start
" search
set nohlsearch
set incsearch
set ignorecase
set smartcase

colorscheme Base2Tone_EveningDark
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
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove<cr>

" mapping to split window for 1 file, good for long file
noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

"miring2
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
map <C-n> :NERDTreeToggle<CR>

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-airline
set laststatus=2
let g:airline_powerline_fonts = 0
let g:airline_theme='kolor'
let g:airline#extensions#tabline#enabled = 1

" deoplete
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup omnifuncs
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
    if exists('g:plugs["tern_for_vim"]')
        let g:tern_show_argument_hints = 'on_hold'
        let g:tern_show_signature_in_pum = 1
        autocmd FileType javascript setlocal omnifunc=tern#Complete
    endif
    inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>" 

    " vCoolor
    let g:vcoolor_lowercase = 1
    let g:vcoolor_disable_mappings = 1
    let g:vcoolor_map = '<leader>vc'

    " fzf
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

    " indentLine
    let g:indentLine_color_term = 237
    let g:indentLine_char = '.'
