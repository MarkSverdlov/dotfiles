" vim-the-hard-way stuff
set nocompatible
let mapleader = "\<space>"
let maplocalleader = "\\"

augroup filetype_options
    autocmd!
    autocmd Filetype html setlocal nowrap norelativenumber
    autocmd Filetype markdown onoremap <buffer> ah :<c-u>execute "normal! ?^\\(-\\\|=\\)\\{2,}$\r:nohlsearch\rg_vk0"<cr>
    autocmd Filetype markdown onoremap <buffer> ih :<c-u>execute "normal! ?^\\(-\\\|=\\)\\{2,}$\r:nohlsearch\rk0vg_"<cr>
    autocmd Filetype python setlocal wrap number relativenumber
augroup END

inoremap <c-u> <esc>gUiwea
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
iabbrev adn and
iabbrev tehn then
iabbrev @@ marksve039@gmail.com
iabbrev ssig Mark Sverdlov<cr>marksve039@gmail.com
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>
inoremap jk <esc>
"Temporary binding until I learn jk binding.
inoremap <esc> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <down> <nop>
inoremap <up> <nop>

" Mine
" Make Y be consistent with C, etc...
nnoremap Y y$

nnoremap <silent> <leader>v :vsplit<cr>
nnoremap <silent> <leader><leader> :split<cr>

set textwidth=72

set completeopt=noinsert,menuone,noselect " Modifies the auto-complete menu
set cursorline  " Highlights the current line in the editor.

set splitbelow splitright  " Change the split screen behavior
set title  " Show file title
set guifont=hack_nerd_font:h11
set ttyfast  " Speed up scrolling on vim

let g:kite_supported_langauges = ['python', 'javascript']

" enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <silent> <leader>a za

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
" so=scrolloff = minimum number of lines visible around cursor.
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set regular expression engine automatically
set regexpengine=0

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme grubvox-matrial
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
" make sure that the shifting is rounded to number spaces divided by 4 when possible.
set shiftround
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
noremap <silent> <leader><cr> :nohl<cr>
"
" Might want to change it to <M-j> etc for compatibiliyy with tmux
" bindings
" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Close the current pane
noremap <silent> <leader>c :close<cr>

" Close the current buffer
noremap <silent> <leader>bd :Bclose<cr>

" Close all the buffers
noremap <silent> <leader>ba :bufdo bd<cr>

noremap <silent> <leader>l :bnext<cr>
noremap <silent> <leader>h :bprevious<cr>

" Useful mappings for managing tabs
noremap <silent> <leader>tn :tabnew<cr>
noremap <silent> <leader>to :tabonly<cr>
noremap <silent> <leader>tc :tabclose<cr>
noremap <silent> <leader>tm :tabmove
noremap <silent> <leader>tl :tabnext<cr>
noremap <silent> <leader>th :tabprevious<cr>

" Let 'tt' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <silent> <leader>tt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    augroup cleantrailingspaces
        autocmd!
        autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
    augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
noremap <silent> <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
noremap <silent> <leader>sn ]s
noremap <silent> <leader>sp [s
noremap <silent> <leader>sa zg
noremap <silent> <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Packages Settings and Binding
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup NERDTree_options
    autocmd!
    autocmd vimenter * NERDTree
    " TODO: check why it makes error on quitting NERDTree sometimes.
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q! | endif
augroup END

let NERDTreeQuitOnOpen=1
nnoremap <silent> <leader>f :NERDTreeToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

command! Bclose call <SID>BufcloseCloseIt()
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
 
" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Unbind some useless/annoying default key bindings.
nnoremap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

