"   This is the personal .vimrc file of nasoundead, which is inspired by Steve Francia.
"   Copyright 2016 Wanghaibo
set nocompatible        " Must be first line

silent function! OSX()
return has('macunix')
endfunction
silent function! LINUX()
return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
return  (has('win32') || has('win64'))
endfunction

if !WINDOWS()
    set shell=/bin/sh
endif
if WINDOWS()
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME
    if has("multi_byte")
        set fileencodings=utf-8,gbk,gb18030,gk2312
        set langmenu=zh_CN.utf-8
        language messages zh_CN.utf-8
    endif
else
    set fileencodings=utf-8,gbk
endif
set termencoding=utf-8
set encoding=utf-8
scriptencoding utf-8


if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
    inoremap <silent> <C-[>OC <RIGHT>
endif


if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif
function! ResCur()
    if line("'\"") <= line("$")
        silent! normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug 'Chiel92/vim-autoformat'
" Plug 'powerline/powerline'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
call plug#end()

if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    set lines=40                " 40 lines of text instead of 24

    if LINUX() && has("gui_running")
        set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 14,Fantasque\ Sans\ Mono\ 12,Andale\ Mono\ Regular\ 11,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
    elseif OSX() && has("gui_running")
        set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
    elseif WINDOWS() && has("gui_running")
        set guifont=Fantasque\ Sans\ Mono\ 14,DejaVu\ Sans\ Mono\ for\ Powerline:h11
    endif
else
    if &term == 'xterm' || &term == 'screen'
        set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
	" set term=builtin_ansi       " Make arrow and other keys work
endif

" if has('statusline')
    " set rtp+=%HOME%/.vim/plugged/powerline/powerline/bindings/vim
    " set laststatus=2
" endif
"Powerline setting
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

color onedark
filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing


set autowrite                       " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set nospell                         " Spell checking off
set hidden                          " Allow buffer switching without saving
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator
set nobackup
set noswapfile
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
set cursorline                  " Highlight current line
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:naso_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
let mapleader = "\<Space>"
nnoremap Y y$
inoremap jk <esc>





