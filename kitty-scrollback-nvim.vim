
" Helper Functions ---------------{{{
func! VisualSelection(direction, extra_filter) range
	let l:saved_reg = @"
	exe "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		exe "normal ?" . l:pattern . "^M"
	elseif a:direction == 'gv'
		call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
	elseif a:direction == 'replace'
		call CmdLine("%s" . '/'. l:pattern . '/')
	elseif a:direction == 'f'
		exe "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endf
" }}}


" General Options And Customization ---------------{{{
filetype on
filetype plugin on
filetype indent on
let $LANG='en'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
syntax enable
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
" }}}


" Leader Keys ---------------{{{
let mapleader = "\<space>"
let maplocalleader = "\\"
" }}}


" Options ---------------{{{
set nocompatible
set textwidth=72
set completeopt=noinsert,menuone,noselect " Modifies the auto-complete menu
set cursorline  " Highlights the current line in the editor.
set splitbelow splitright  " Change the split screen behavior
set guifont=hack_nerd_font:h11
set ttyfast  " Speed up scrolling on vim
set history=500
set scrolloff=7  " Set the minimal number of screen lines to keep above and below the cursor
set langmenu=en
set wildmenu
set wildignore=*.o,*~,*.pyc
set cmdheight=1
set hidden  " Let a buffer be hidden and not unloaded when abandoned
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set matchtime=2 " Time in tenths of second for parenthesis match ()
set foldcolumn=1
set regexpengine=0
set background=dark
set encoding=utf8
set ffs=unix,dos,mac
set nobackup
set nowritebackup
set noswapfile
set expandtab
set smarttab
set shiftwidth=4
set shiftround
set tabstop=4
set linebreak
set textwidth=500
set autoindent
set smartindent "Smart indent
set wrap "Wrap lines
set laststatus=2
set shortmess+=I
set number
set relativenumber
set switchbuf=useopen,usetab,newtab
set foldlevelstart=0  " Make sure a buffer starts with all folds closed
" }}}


" Remappings ---------------{{{
onoremap in@ :<c-u>execute "normal! /\\<\\([a-zA-Z0-9]\\+\\)@[a-zA-Z]\\+\\.\\([a-zA-Z]\\.\\)\\?[a-zA-Z]\\+\\>\r:nohlsearch\rvE"<cr>
inoremap <c-u> <esc>gUiwea
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>
inoremap jk <esc>
inoremap <esc> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <down> <nop>
inoremap <up> <nop>
nnoremap Y y$
nnoremap <silent> <leader>v :vsplit<cr>
nnoremap <silent> <leader>h :split<cr>
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
noremap <silent> <leader><leader> :nohl<cr>
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <silent> <leader>c :close<cr>
noremap <silent> <leader>bd :Bclose<cr>
noremap <silent> <leader>ba :bufdo bd<cr>
" list mapping: b - bufferlist, t - taglist, a - argumentlist, c - quickfix list, l - location list.
nnoremap <silent> ]b :bnext<cr>
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]B :blast<cr>
nnoremap <silent> [B :bfirst<cr>
nnoremap <silent> ]t :tnext<cr>
nnoremap <silent> [t :tprevious<cr>
nnoremap <silent> ]T :tlast<cr>
nnoremap <silent> [T :tfirst<cr>
nnoremap <silent> ]a :next<cr>
nnoremap <silent> [a :previous<cr>
nnoremap <silent> ]A :last<cr>
nnoremap <silent> [A :first<cr>
nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprevious<cr>
nnoremap <silent> ]Q :clast<cr>
nnoremap <silent> [Q :cfirst<cr>
nnoremap <silent> ]l :lnext<cr>
nnoremap <silent> [l :lprevious<cr>
nnoremap <silent> ]L :llast<cr>
nnoremap <silent> [L :lfirst<cr>

noremap <silent> <leader>ss :setlocal spell!<cr>
nnoremap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.
nnoremap <leader>t :!ctags -R --exclude=.git --exclude=node_module --exclude=site-packages .<cr><cr>
" }}}


" Variable Settings ---------------{{{

let g:lasttab = 1 " Useful for initialization of lasttab binding
let g:python3_host_prog = '/home/mark/.venv/bin/python3' " Useful to set a Python3 program for neovim without relying on environment variables
" }}}


" Iabbrevations ---------------{{{
iabbrev adn and
iabbrev tehn then
iabbrev @@ marksve039@gmail.com
iabbrev ssig Mark Sverdlov<cr>marksve039@gmail.com
" }}}


" Package Options ---------------{{{
" NERDTree Options
augroup NERDTree_options
    autocmd!
    " TODO: check why it makes error on quitting NERDTree sometimes.
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q! | endif
augroup END

nnoremap <silent> <leader>f :NERDTreeToggle<cr>

let NERDTreeQuitOnOpen = 1  " NERDTree option


" UltiSnips options
let g:UltiSnipsExpandTrigger="<c-s>" |  " s for 'snippet'
let g:UltiSnipsJumpForwardTrigger="<c-f>" |
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.local/share/nvim/site/UltiSnips']
nnoremap <silent> <leader>sn :<c-u>call UltiSnips#RefreshSnippets()<CR>


" Tabular options
" mnemonic for align
nnoremap <silent> <leader>a :Tabularize /<c-r>=input('Pattern: ')<cr><cr>

" Ctrl-P options
nnoremap <silent> <c-w> :CtrlP<cr>
nnoremap <silent> <c-p> :CtrlPBuffer<cr>
" }}}


" Color Schemes ---------------{{{
set termguicolors

colorscheme duckbones
" }}}

