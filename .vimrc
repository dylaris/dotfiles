"==============================================
" Util Functions
"==============================================
function! ReverseLines()
    let lines = getline("'<", "'>")
    call setline("'<", reverse(lines))
endfunction

function! CreateTempBuffer()
    botright vnew
    let buf = bufnr('%')
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal filetype=text
    call setline(1, [
        \ 'This is a temporary buffer...',
        \ 'You can write anything here...',
        \ ''
    \ ])
    return buf
endfunction

function! CloseOtherBuffers()
    let current_buf = bufnr('%')
    for buf in getbufinfo({'buflisted': 1})
        if buf.bufnr != current_buf && buf.loaded
            execute 'bdelete' buf.bufnr
        endif
    endfor
endfunction

function! ProxyUrl(repo)
    let url_format = "https://gh.bugdey.us.kg/https://github.com/%s.git"
    return printf(url_format, a:repo)
endfunction

"==============================================
" Plugin Configuration
"==============================================
if !exists('g:load_plugins')
    let g:load_plugins = 1
endif

if g:load_plugins
    if has('win32') || has('win64')
        " Windows system
        let s:plug_dir = '$VIM/vimfiles/plugged'
    else
        " Linux/Unix system
        let s:plug_dir = '~/.vim/plugged'
    endif

    " Plug install
    call plug#begin(s:plug_dir)
        Plug ProxyUrl('NLKNguyen/papercolor-theme')
        Plug ProxyUrl('junegunn/vim-easy-align')
        Plug ProxyUrl('easymotion/vim-easymotion')
        Plug ProxyUrl('tpope/vim-commentary')
        Plug ProxyUrl('skywind3000/asyncrun.vim')
    call plug#end()
endif

"==============================================
" Plugin Settings
"==============================================
if g:load_plugins
    " netrw
    let g:netrw_banner       = 0  " Hide banner (the top directory info)
    let g:netrw_liststyle    = 3  " Tree-style listing
    let g:netrw_browse_split = 4  " Open file in previous window
    let g:netrw_winsize      = 25 " Set window width to 25%

    " asyncrun
    let g:asyncrun_encs = 'gbk'
endif

"==============================================
" GUI-specific Settings
"==============================================
if has('gui_running')
    " Language settings
    let $LANG = 'en_US'
    set langmenu=en_US
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    " Workspace setup
    let $VIM_WORKSPACE = 'D:/Vim/workspace'
    cd $VIM_WORKSPACE
    set cdpath=,,

    " GUI options
    set guioptions-=m               " Hide menu bar
    set guioptions-=T               " Hide tool bar
    set guioptions-=r               " Hide scroll bar

    " Toggle GUI elements with F2
    map <silent> <F2> :if &guioptions =~# 'T' <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=m <Bar>
            \set guioptions-=r <Bar>
        \else <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=m <Bar>
            \set guioptions+=r <Bar>
        \endif<CR>
endif

"==============================================
" Settings
"==============================================
" Basic setttings configuration
set nocompatible                    " Vi compatibility mode
syntax on                           " Syntax highlighting
filetype on                         " Filetype detection
filetype indent on                  " Uuto indentation
if has('win32') || has('win64')
    set fileformats=dos
else
    set fileformats=unix
endif

" Appearance and interface settings
set background=dark                 " Background color
set termguicolors                   " True color support
set laststatus=2                    " Show status line or not
colorscheme PaperColor
highlight CursorLine guibg=NONE
highlight CursorLineNr guibg=NONE
set guifont=Inconsolata_LGC_Nerd_Font:h9:b:cANSI:qDRAFT
set guicursor=n-v-sm:block,i-c-ci-ve:hor20,r-cr-o:hor20
" default: set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20

" Clipboard and autocompletion settings
set clipboard=unnamedplus           " Set clipboard to use the system clipboard
set complete+=d                     " Enable auto completion for C/C++ macros

" Tab and indentation settings
set tabstop=4                       " Visual spaces per tab
set softtabstop=4                   " Spaces in edit operation
set expandtab                       " Convert tab to spaces
set smarttab                        " Smart tabbing
set shiftwidth=4                    " Autoindent width
set autoindent                      " Auto indentation
set cindent                         " C style auto indentation

" Search settings
set hls                             " Highlight search matches
set ignorecase                      " Case insensitive search
set smartcase                       " Smart case search (case-sensitive if uppercase is used)
set showmatch                       " Highlight matching brackets

" File management settings
set nobackup                        " Backup files
set noswapfile                      " Swap files
set nowritebackup                   " Write backup
set noundofile                      " Undo files

" Search path for builtin-command find
set path=.

" Line Numbers
set number                          " Show absolute line numbers
set relativenumber                  " Show relative line numbers
set cursorline                      " Highlight current line

" Other settings
set belloff=all                     " Disable bell
set mouse=a                         " Mouse support in all modes
set updatetime=300                  " Shorter update time for better responsiveness
set showmode                        " Show current mode

"==============================================
" Autocommands
"==============================================
" Set compiler for language: c3, python
autocmd FileType c3 compiler c3c
autocmd FileType python compiler pyunit

" Set errorfmt for javascript / typescript
autocmd FileType javascript setlocal errorformat=%\s%\++at\ %f:%l:%c,%f:%l
autocmd FileType typescript setlocal errorformat=%\s%\++at\ %f:%l:%c,%f:%l

" Set filetype=c for C header file (*.h)
autocmd BufNewFile,BufRead *.h setlocal filetype=c

" Set filetype=fasm for asm/inc
autocmd BufNewFile,BufRead *.asm,*.inc setlocal filetype=fasm

" Auto remove trailing whitespace & ^M (Windows newline) on save
function! s:TrimWhitespace()
    let cursor_pos = getpos('.')
    %s/\s\+$//e
    %s/\r//e
    call setpos('.', cursor_pos)
endfunction
autocmd BufWritePre * call s:TrimWhitespace()

" Disable auto comment on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Comment format
autocmd FileType c,cpp,cs,java,javascript,typescript,rust,go setlocal commentstring=//\ %s
autocmd FileType python,bash,zsh,ruby setlocal commentstring=#\ %s
autocmd FileType html setlocal commentstring=<!--\ %s\ -->
autocmd FileType css setlocal commentstring=/*\ %s\ */
autocmd FileType asm,fasm,nasm,inc setlocal commentstring=;\ %s
autocmd FileType lua setlocal commentstring=--\ %s
autocmd FileType vim setlocal commentstring=\"\ %s

"==============================================
" Key Map
"==============================================
let mapleader = "\<Space>"          " Leader key

"----------------------------------------------
" core
"----------------------------------------------
" Exit insert mode
inoremap jk <Esc>
" Run command
cnoremap jk <Esc>
" Discard command
cnoremap jj <C-c>
" Exit terminal mode
tnoremap <Esc> <C-\><C-n>
" Reversed operation 'u'
nnoremap U <C-r>
" Save file
nnoremap <Leader>s :w<CR>
" Quit file
nnoremap <Leader>q :q<CR>
" Clear search highlight
nnoremap <Leader>nh :nohl<CR>
" Run macro 'a'
vnoremap <Tab> :normal @a<CR>
" Paste from system clipboard
nnoremap <Leader>p "+p
nnoremap p ""p
" Yank to system clipboard
vnoremap <Leader>y "+y
" Open file explorer
nnoremap <Leader>e :Lexplore<CR>

"----------------------------------------------
" line operations
"----------------------------------------------
" Split line
nnoremap <Enter> i<CR><Esc>
" Delete to line start
nnoremap du d^
" Reverse selected lines
vnoremap <leader>rl :call ReverseLines()<CR>

"----------------------------------------------
" quickfix
"----------------------------------------------
" Open quickfix window
nnoremap <Leader>co :copen<CR>
" Close quickfix window
nnoremap <Leader>cc :cclose<CR>
" Jump to next fix
nnoremap <Leader>cn :cnext<CR>
" Jump to previous fix
nnoremap <Leader>cp :cprev<CR>
" Jump to first fix
nnoremap <Leader>cf :cfirst<CR>
" Jump to last fix
nnoremap <Leader>cl :clast<CR>

"----------------------------------------------
" buffer operations
"----------------------------------------------
" Close buffer
nnoremap <Leader>bd :bd<CR>
" Unload buffer
nnoremap <Leader>bu :bun<CR>
" Switch to last visited buffer
nnoremap <Leader>bv :b#<CR>
" Close other buffers
nnoremap <Leader>bo :call CloseOtherBuffers()<CR>
" Show buffer path
nnoremap <leader>bp :redir @+ <bar> echo expand('%:p') <bar> redir END<CR>
" Create a tmp buffer
nnoremap <Leader>bt :call CreateTempBuffer()<CR>
" Edit vimrc
nnoremap <Leader>br :e! $MYVIMRC<CR>

"----------------------------------------------
" window operations
"----------------------------------------------
" Horizontal split window
nnoremap <Leader>wh :split<CR>
" Vertical split window
nnoremap <Leader>wv :vsplit<CR>
" Close window
nnoremap <Leader>wd :close<CR>
" Close other windows
nnoremap <Leader>wo :only<CR>

"----------------------------------------------
" tab operations
"----------------------------------------------
" Create a new tab
nnoremap <Leader>tn :tabnew<CR>
" Close window
nnoremap <Leader>td :tabclose<CR>
" Close other abs
nnoremap <Leader>to :tabonly<CR>

"----------------------------------------------
" navigation
"----------------------------------------------
" Go to left window
nnoremap <A-h> <C-w>h
" Go to right window
nnoremap <A-l> <C-w>l
" Go to bottom window
nnoremap <A-j> <C-w>j
" Go to top window
nnoremap <A-k> <C-w>k
" Go to line start
nnoremap <C-h> ^
vnoremap <C-h> ^
" Go to line end
nnoremap <C-l> $
" Go to line end (no newline)
vnoremap <C-l> $h
" Go to previous function/class
nnoremap <C-p> [[
vnoremap <C-p> [[
" Go to next function/class
nnoremap <C-n> ]]
vnoremap <C-n> ]]
" Go to previous paragraph
nnoremap <C-k> {
vnoremap <C-k> {
" Go to next paragraph
nnoremap <C-j> }
vnoremap <C-j> }
" Go to matching bracket
nnoremap <Leader><Leader> %
vnoremap <Leader><Leader> %
" s{char}{char} to move to {char}{char}
if g:load_plugins
    nnoremap gs <Plug>(easymotion-overwin-f2)
endif

"----------------------------------------------
" plugin key map
"----------------------------------------------
if g:load_plugins
    " vim-easy-align
    nnoremap ga <Plug>(EasyAlign)
    vnoremap ga <Plug>(EasyAlign)

    " AsyncRun
    nnoremap <Leader>r :AsyncRun<Space>
endif
