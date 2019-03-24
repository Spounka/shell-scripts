set number
call plug#begin()

Plug 'roxma/nvim-completion-manager'
Plug 'calebeby/ncm-css'
Plug 'roxma/ncm-clang'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kaicataldo/material.vim'
Plug 'neovim/nvim.net'
Plug 'brooth/far.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'octol/vim-cpp-enchanced-highlight'

call plug#end()

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"



if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set copyindent


let g:material_theme_style = 'dark'
let g:lightline = { 'colorscheme': 'material_vim' }

set background=dark
colorscheme material 
