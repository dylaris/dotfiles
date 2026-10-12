"      _       _            _
"   __| |_   _| | __ _ _ __(_)___
"  / _` | | | | |/ _` | '__| / __|
" | (_| | |_| | | (_| | |  | \__ \
"  \__,_|\__, |_|\__,_|_|  |_|___/
"        |___/
"
"  https://github.com/dylaris/dotfiles
"
"  Sections:
"    01. Utilities        - Helper functions
"    02. Plugins          - Plugin manager & list
"    03. Plugin Settings  - Per-plugin configuration
"    04. GUI              - gVim-specific settings
"    05. Editor           - Core editing behaviour
"    06. Appearance       - Colors, statusline, UI
"    07. Autocommands     - Filetype & event automation
"    08. Keymaps          - Custom key bindings
"

" ============================================================
"  01. UTILITIES
" ============================================================
"  Helper functions used across the config.
" ------------------------------------------------------------

" Reverse the currently selected lines
function! ReverseLines()
    let lines = getline("'<", "'>")
    call setline("'<", reverse(lines))
endfunction

" Open a scratch buffer next to the current window
" Usage: :call CreateTempBuffer()           -> aboveleft vnew (left of current)
"        :call CreateTempBuffer('belowright') -> belowright vnew (right of current)
function! CreateTempBuffer(...)
    let pos = a:0 >= 1 ? a:1 : 'aboveleft'
    execute pos . ' new'
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

" Close all buffers except the current one
function! CloseOtherBuffers()
    let current_buf = bufnr('%')
    let targets = []
    for buf in getbufinfo({'buflisted': 1})
        if buf.bufnr != current_buf
            call add(targets, buf.bufnr)
        endif
    endfor

    for bufnr in targets
        try
            execute 'bdelete' bufnr
        catch
            echo 'Could not delete buffer ' . bufnr
        endtry
    endfor
endfunction

function! s:SetCursorLine()
    set cursorline
    highlight CursorLine   guibg=NONE
    highlight CursorLineNr guibg=NONE
endfunction

" ============================================================
"  02. PLUGINS
" ============================================================
"  Managed by vim-plug. Set g:load_plugins = 0 to disable.
" ------------------------------------------------------------
if !exists('g:load_plugins')
    let g:load_plugins = 1
endif

if g:load_plugins
    if has('win32') || has('win64')
        let s:plug_dir = '$VIM/vimfiles/plugged'
    else
        let s:plug_dir = '~/.vim/plugged'
    endif

    call plug#begin(s:plug_dir)
        Plug 'sheerun/vim-polyglot'
        Plug 'junegunn/vim-easy-align'
        Plug 'easymotion/vim-easymotion'
        Plug 'tpope/vim-commentary'
        Plug 'vim-airline/vim-airline'
        Plug 'preservim/nerdtree'
        Plug 'wellle/targets.vim'
        Plug 'tpope/vim-surround'
        Plug 'mhinz/vim-startify'
        Plug 'romainl/vim-qf'
        Plug 'skywind3000/asyncrun.vim'
        Plug 'skywind3000/vim-auto-popmenu'
        Plug 'skywind3000/vim-dict'
        Plug 'rakr/vim-two-firewatch'
    call plug#end()
endif

" ============================================================
"  03. PLUGIN SETTINGS
" ============================================================
if g:load_plugins
    " vim-auto-popmenu
    let g:apc_enable_ft = {'*':1}

    " airline
    let g:airline_theme='twofirewatch'
    let g:airline#extensions#tabline#enabled = 1

    " nerdtree
    let NERDTreeShowLineNumbers=1
    let NERDTreeShowHidden=1
    let NERDTreeWinSize=40
    let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$']
    let NERDTreeShowBookmarks=1

    " everforest
    let g:everforest_background = 'hard'
    let g:everforest_better_performance = 1
    let g:everforest_ui_contrast = 'high'
endif

" ============================================================
"  04. GUI (gVim only)
" ============================================================
if has('gui_running')
    " Force English menus
    let $LANG = 'en_US'
    set langmenu=en_US
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    " Minimal chrome
    set guioptions-=m   " no menu bar
    set guioptions-=T   " no tool bar
    set guioptions-=r   " no scroll bar
    set guioptions-=l   " no scroll bar
    set guioptions-=L   " no scroll bar

    " F2 toggles menu / toolbar / scrollbar
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

" ============================================================
"  05. EDITOR
" ============================================================
"  Core editing behaviour: indentation, search, files.
" ------------------------------------------------------------

set grepprg=rg\ --vimgrep\ --smart-case\ --hidden

" --- Compatibility & filetype ---
set nocompatible
syntax on
filetype on
filetype indent on
if has('win32') || has('win64')
    set fileformats=dos
else
    set fileformats=unix
endif

" --- Tabs & indentation ---
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set shiftwidth=4
set autoindent
set cindent

" --- Search ---
set hls
set ignorecase
set smartcase
set showmatch

" --- Files ---
set nobackup
set noswapfile
set nowritebackup
set path=.
set wrap linebreak breakindent
set undofile
if has('win32') || has('win64')
    set undodir=$VIM/vimfiles/undo//
else
    set undodir=~/.vim/undo//
endif
set nospell spelllang=en,cjk

" --- Clipboard & completion ---
set clipboard=unnamed
set cpt=.,k,w,b
set completeopt=menu,menuone,noselect
set shortmess+=c

" --- Netrw
"   gn  - Set the directory under the cursor as root
"   mf  - Mark file(s) for copy / move
"   mt  - Mark target directory
"   mc  - Copy marked file(s) to target
"   mm  - Move marked file(s) to target
"   R   - Rename file under cursor
"   D   - Delete file under cursor
"   %   - Create new file
"   d   - Create new directory
"   i   - Cycle listing style (thin / long / wide / tree)
let g:netrw_banner       = 0   " Hide banner
let g:netrw_liststyle    = 3   " Tree-style listing
let g:netrw_browse_split = 4   " Open in previous window
let g:netrw_winsize      = 25  " Window width: 25%
let g:netrw_keepdir      = 0
hi! link netrwMarkFile Search  " Highlight marked files the same way search matches are highlighted.

" --- Misc ---
set belloff=all
set mouse=a
set updatetime=300
set showmode

" ============================================================
"  06. APPEARANCE
" ============================================================

set background=light
set termguicolors
set laststatus=2
if g:load_plugins
    colorscheme two-firewatch
    highlight Function guifg=#1A1A1A
    let matchparen_disable_cursor_hl = 1
    hi MatchParen cterm=bold ctermfg=243 ctermbg=253 gui=bold guifg=#6C6C6C guibg=#E8E4DD
else
    colorscheme quiet
endif

" set guifont=Fixedsys_Core:h11
set guifont=Consolas:h11:b
" set guifont=VictorMono_NFM:h11

" --- Line numbers ---
set number
set relativenumber
set cursorline

highlight CursorLine   guibg=NONE
highlight CursorLineNr guibg=NONE

" ============================================================
"  07. AUTOCOMMANDS
" ============================================================

" --- Compilers ---
autocmd FileType python  compiler pyunit

" --- Error formats for JS/TS ---
autocmd FileType javascript setlocal errorformat=%\s%\++at\ %f:%l:%c,%f:%l
autocmd FileType typescript setlocal errorformat=%\s%\++at\ %f:%l:%c,%f:%l

" --- Filetype overrides ---
autocmd BufNewFile,BufRead *.h          setlocal filetype=c
autocmd BufNewFile,BufRead *.asm,*.inc  setlocal filetype=fasm

" --- Trim trailing whitespace & CR on save ---
function! s:TrimWhitespace()
    let cursor_pos = getpos('.')
    %s/\s\+$//e
    %s/\r//e
    call setpos('.', cursor_pos)
endfunction
autocmd BufWritePre * call s:TrimWhitespace()

" --- Disable auto-comment on newline ---
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" --- Comment strings per filetype ---
autocmd FileType c,cpp,cs,java,javascript,typescript,rust,go
    \ setlocal commentstring=//\ %s
autocmd FileType python,bash,zsh,ruby
    \ setlocal commentstring=#\ %s
autocmd FileType html
    \ setlocal commentstring=<!--\ %s\ -->
autocmd FileType css
    \ setlocal commentstring=/*\ %s\ */
autocmd FileType asm,fasm,nasm,inc
    \ setlocal commentstring=;\ %s
autocmd FileType lua
    \ setlocal commentstring=--\ %s
autocmd FileType vim
    \ setlocal commentstring=\"\ %s

autocmd! ColorScheme * call <SID>SetCursorLine()

" ============================================================
"  08. KEYMAPS
" ============================================================
let mapleader = "\<Space>"

" --- Core ---
inoremap jk <Esc>
cnoremap jk <Esc>
cnoremap jj <C-c>
tnoremap <Esc> <C-\><C-n>
nnoremap U <C-r>
nnoremap <Leader>s  :w<CR>
nnoremap <Leader>q  :q<CR>
nnoremap <Leader>nh :nohl<CR>
vnoremap <Tab>      :normal @a<CR>

" --- Line operations ---
nnoremap <expr> <Enter> (&buftype == '' && &modifiable && !&readonly) ? 'i<CR><Esc>' : '<Enter>'
nnoremap dh :<C-U>normal! dg^<CR>
nnoremap dl :<C-U>normal! dg$<CR>
nnoremap ch :<C-U>normal! cg^<CR>
nnoremap cl :<C-U>normal! cg$<CR>
nnoremap yh :<C-U>normal! yg^<CR>
nnoremap yl :<C-U>normal! yg$<CR>
vnoremap <leader>rl :call ReverseLines()<CR>

" --- Quickfix ---
nnoremap <Leader>co :copen<CR>
nnoremap <Leader>cc :cclose<CR>
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprev<CR>
nnoremap <Leader>cf :cfirst<CR>
nnoremap <Leader>cl :clast<CR>

" --- Buffers ---
nnoremap <Leader>bd :bd<CR>
nnoremap <Leader>bv :b#<CR>
nnoremap <Leader>bo :call CloseOtherBuffers()<CR>
nnoremap <leader>bp  :redir @+ <bar> echo expand('%:p') <bar> redir END<CR>
nnoremap <Leader>bt :call CreateTempBuffer()<CR>
nnoremap <Leader>br :e! $MYVIMRC<CR>

" --- Windows ---
nnoremap <Leader>wh :split<CR>
nnoremap <Leader>wv :vsplit<CR>
nnoremap <Leader>wd :close<CR>
nnoremap <Leader>wo :only<CR>

" --- Tabs ---
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>td :tabclose<CR>
nnoremap <Leader>to :tabonly<CR>

" --- Navigation ---
nnoremap <A-h> <C-w>h
nnoremap <A-l> <C-w>l
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-n> :tabnext<CR>
nnoremap <A-p> :tabprev<CR>

nnoremap j gj
nnoremap k gk

nnoremap gh g^
vnoremap gh g^
nnoremap gl g$
vnoremap gl g$h
nnoremap gm %
vnoremap gm %
nnoremap gd <C-]>
nnoremap gD <C-t>

nnoremap <C-k> 5k
vnoremap <C-k> 5k
nnoremap <C-j> 5j
vnoremap <C-j> 5j

" --- Plugin keymaps ---
if g:load_plugins
    " nerdtree
    nnoremap <leader>e :NERDTreeToggle<CR>

    " vim-easy-motion
    nnoremap gs <Plug>(easymotion-overwin-f2)

    " vim-easy-align
    nnoremap ga <Plug>(EasyAlign)
    vnoremap ga <Plug>(EasyAlign)

    " asyncrun
    nnoremap <leader>r :AsyncRun<space>
endif
