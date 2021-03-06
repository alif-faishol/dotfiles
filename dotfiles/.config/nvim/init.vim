" ---------------------------------------------------------------------
"  Vim-Plug
" ---------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'KabbAmine/vCoolor.vim'
Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'yuttie/comfortable-motion.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-obsession'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'shime/vim-livedown'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'flazz/vim-colorschemes'
Plug 'crater2150/vim-theme-chroma'
Plug 'connorholyday/vim-snazzy'

" Snippets
Plug 'honza/vim-snippets'

" Syntax
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'sheerun/vim-polyglot'


call plug#end()

" ---------------------------------------------------------------------
" Vim config
" ---------------------------------------------------------------------
set number
set rnu                                                 " relative number
syntax on
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
au BufEnter *.* :syntax sync fromstart

" tab
" ---
set tabstop=2                                           " show existing tab with 4 spaces width
set shiftwidth=2                                        " when indenting with '>', use 4 spaces width
set expandtab                                           " On pressing tab, insert 4 spaces

" fold
" ----
set foldmethod=indent
set nofoldenable                                        " don't auto fold at start

" remap
" ----
let mapleader      = ','
let maplocalleader = ','
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

nnoremap <C-g> :TmuxNavigateLeft<CR>

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

" Neovim python
" -------------
let g:python3_host_prog = '/usr/local/opt/python3/bin/python3'

" ---------------------------------------------------------------------
"  Plugin Config
" ---------------------------------------------------------------------

" NERDTree
" --------
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['.DS_Store']


" " ALE
" " ---------
" let g:ale_lint_delay = 3000
" let g:ale_lint_on_insert_leave = 0
" " Fix files automatically on save
" let g:ale_fix_on_save = 1


" vim-airline
" -----------
set laststatus=2
let g:airline_powerline_fonts = 0
let g:airline_theme='kolor'
let g:airline#extensions#tabline#enabled = 1


" vCoolor
" -------
let g:vcoolor_lowercase = 1
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<leader>#'
let g:vcool_ins_rgba_map = '<leader>rgba'
let g:vcool_ins_rgb_map = '<leader>rgb'
let g:vcool_ins_hsl_map = '<leader>hsl'

" coc
" ---


" supertab
" --------
let g:SuperTabDefaultCompletionType = "<c-n>"


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
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--color=hl:#8a8a8a,hl+:#00afff --delimiter : --nth 4..'}, <bang>0)
nnoremap <silent> <Leader>c :Ag<CR>

" indentLine
" ----------
let g:indentLine_color_term = 237
let g:indentLine_char = '│'


" emmet-vim
" ---------
let g:user_emmet_leader_key='<leader>,'


" editorconfig
" ------------
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


" vim-latex-live-preview
let g:livepreview_previewer = 'open -a Preview'
autocmd Filetype tex setl updatetime=1

let g:comfortable_motion_interval = 1000.0 / 24

let g:vim_markdown_conceal = 0
