" Initialize vim-plug for plugin management
call plug#begin('~/.config/nvim/plugged')

" Install desired plugins
Plug 'tpope/vim-sensible'               " Basic defaults for Vim
Plug 'preservim/nerdtree'                " File explorer
Plug 'junegunn/fzf.vim'                  " Fuzzy finder
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Syntax highlighting with treesitter
Plug 'neovim/nvim-lspconfig'             " Language Server Protocol support
Plug 'hrsh7th/nvim-compe'                " Autocompletion

" Initialize the plugin system
call plug#end()

" General settings
set number                 " Show line numbers
set relativenumber         " Show relative line numbers
set cursorline             " Highlight the current line
set tabstop=4              " Set tab width to 4 spaces
set shiftwidth=4           " Set indentation width to 4 spaces
set expandtab              " Use spaces instead of tabs
set wrap                   " Enable line wrapping

" Enable mouse support
set mouse=a

" Set clipboard to use system clipboard
set clipboard=unnamedplus

" Enable syntax highlighting
syntax on

" Configure NERDTree (file explorer)
nmap <C-n> :NERDTreeToggle<CR>

" Configure fzf (fuzzy finder)
nmap <C-p> :Files<CR>

" Enable LSP (Language Server Protocol) for code intelligence
lua <<EOF
  require'lspconfig'.pyright.setup{}     " Example: LSP for Python
EOF

" Enable autocompletion
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.source = {
    \ 'path': v:true,
    \ 'buffer': v:true,
    \ 'nvim_lsp': v:true,
    \ }