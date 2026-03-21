" ---------- General ----------
set nocompatible
filetype plugin indent on
syntax on

" ---------- Indentation ----------
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smartindent

" ---------- Display ----------
set background=dark
set cursorline
set number
set numberwidth=5
set ruler
set showmatch
set nowrap
set laststatus=2
set showcmd
set showmode
set title

" ---------- Search ----------
set incsearch
set hlsearch
set ignorecase
set smartcase
" Clear search highlight with Escape
nnoremap <Esc> :nohlsearch<CR><Esc>

" ---------- Behavior ----------
set backspace=indent,eol,start
set hidden
set wildmenu
set wildmode=list:longest,full
set scrolloff=5
set mouse=a
set encoding=utf-8
set fileencoding=utf-8

" ---------- Performance ----------
set lazyredraw
set ttyfast

" ---------- Backup / Swap ----------
set nobackup
set nowritebackup
set noswapfile

" ---------- Splits ----------
set splitbelow
set splitright

" ---------- Whitespace visibility ----------
set listchars=tab:>\ ,trail:~,extends:>,precedes:<
" Toggle with :set list / :set nolist

" ---------- Status line ----------
set statusline=%f\ %m%r%h%w\ [%{&ff}]\ [%Y]\ [line\ %l/%L,\ col\ %c]

" ---------- Key mappings ----------
" Quick save
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ---------- File type specifics ----------
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType make setlocal noexpandtab
