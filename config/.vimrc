" custom path to .vim directory
set runtimepath+=/config/.vim

" set custom color scheme
colorscheme onedark

" set to allow navigate vim through arrows
set nocompatible

" set encoding
set encoding=utf-8

" syntax higlighting
syntax on
filetype plugin indent on

" set 2-space indent for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" set syntax for *.dockerfile
autocmd BufNewFile,BufRead *.dockerfile set syntax=dockerfile

" add line numbering
set number
set relativenumber
set numberwidth=6

" add displaying whitespaces
set list
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:·
