" --------------------------------------
" ---- Vim Plug ----
" --------------------------------------
call plug#begin('~/.vim/plugged')
" --- Init
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
"Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'powerline/powerline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' 

" ---- Git / Tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" ---- Commenter
Plug 'scrooloose/nerdtree'

" Polygot
Plug 'sheerun/vim-polyglot'
" coc extension
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Go lang 
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
" Rust
Plug 'rust-lang/rust.vim'
call plug#end()

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

