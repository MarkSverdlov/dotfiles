" Helper Functions ---------------{{{

function! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

command! Bclose call <SID>BufcloseCloseIt()


function! s:TexFocusVim() abort
    " Give window manage time to recognize focus moved to Zathura
    sleep 200m

    " Refocus Vim and redraw the screen
    silent execute "!xdotool windowfocus " . expand(g:vim_window_id)
    redraw!
endfunction


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
set title  " Show file title
set guifont=hack_nerd_font:h11
set ttyfast  " Speed up scrolling on vim
set history=500
set scrolloff=7  " Set the minimal number of screen lines to keep above and below the cursor
set langmenu=en
set wildmenu
set wildignore=*.o,*~,*.pyc
set ruler
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
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
set shortmess+=I
set number
set relativenumber
set switchbuf=useopen,usetab,newtab
set showtabline=2
set foldlevelstart=0  " Make sure a buffer starts with all folds closed
" }}}


" Autocommands ---------------{{{

" Vimscript File Settings --------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

augroup filetype_html
    autocmd!
    autocmd Filetype html setlocal nowrap norelativenumber
augroup END

augroup filetype_markdown
    autocmd!
    autocmd Filetype markdown onoremap <buffer> ah :<c-u>execute "normal! ?^\\(-\\\|=\\)\\{2,}$\r:nohlsearch\rg_vk0"<cr>
    autocmd Filetype markdown onoremap <buffer> ih :<c-u>execute "normal! ?^\\(-\\\|=\\)\\{2,}$\r:nohlsearch\rk0vg_"<cr>
augroup END

augroup filetype_python
    autocmd!
    autocmd Filetype python setlocal wrap number relativenumber
    autocmd Filetype python iabbrev <buffer> ret return
    autocmd Filetype python iabbrev <buffer> return NOPENOPENOPE
    autocmd Filetype python setlocal foldmethod=indent foldlevel=99
augroup END

augroup filetype_org
    autocmd!
    autocmd FileType org setlocal conceallevel=2
    autocmd FileType org setlocal concealcursor=nc
augroup END

" Return to last edit position when opening files (You want this!)
augroup returntolasteditposition
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

augroup cleantrailingspaces
    autocmd!
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
augroup END

augroup ctags_options
    autocmd!
    autocmd BufWritePost * if &filetype != 'help' && &filetype != 'gitcommit' && filereadable("tags") | silent! !ctags -R --exclude=.git --exclude=node_modules . | endif
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


" YouCompleteMe Options

if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif

if !has('win32')
    augroup YCM_options
        autocmd!
        autocmd FileType python,tex packadd YouCompleteMe
        autocmd VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme
    augroup END
endif


" Copilot Option.

if !has('win32')
    augroup copilot_options
        autocmd!
        autocmd FileType python,vim packadd copilot.vim
        autocmd FileType python,vim inoremap <silent><script><expr> <Tab> copilot#Accept("\<Tab>") " Use tab to accept suggestions from Copilot
    augroup END
endif

" Airline Options
if !has('nvim')
    packadd vim-airline
    packadd vim-airline-themes
    let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " f/p/file-name.js

    if !has('win32')
        let g:airline_powerline_fonts = 1
    endif

    if !has('win32')
        if !exists('g:airline_symbols')
            let g:airline_symbols = {}
        endif

        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''
        let g:airline_symbols.branch = ''
        let g:airline_symbols.readonly = ''
        let g:airline_symbols.linenr = '☰'
        let g:airline_symbols.maxlinenr = ''
        let g:airline_symbols.dirty='⚡'
    endif
endif

" UltiSnips options
let g:UltiSnipsExpandTrigger="<c-s>" |  " s for 'snippet'
let g:UltiSnipsJumpForwardTrigger="<c-f>" |
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
nnoremap <silent> <leader>sn :<c-u>call UltiSnips#RefreshSnippets()<CR>

" vimtex options
let g:vimtex_view_method = 'zathura'
" This autocommand make sure vim's focus is regained after forward search via vimtex.
augroup vimtex_event_focus
    autocmd!
    autocmd User VimtexEventView call s:TexFocusVim()
augroup END

" Tabular options
" mnemonic for align
nnoremap <silent> <leader>a :Tabularize /<c-r>=input('Pattern: ')<cr><cr>
" }}}


" Color Schemes ---------------{{{
let g:gruvbox_guisp_fallback = 'bg'
colorscheme gruvbox
" }}}


" Infrastructure Configuration ---------------{{{
    if empty(v:servername) && exists('*remote_startserver') && !has('win32') && $TERM != 'linux'
       call remote_startserver('VIM')
    endif

    if !exists("g:vim_window_id") && !has('win32')
       let g:vim_window_id = system("xdotool getactivewindow")
    endif
" }}}
