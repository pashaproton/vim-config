set nocompatible
set encoding=utf-8

filetype plugin indent on
syntax enable

set number
set ruler
set hidden
set nowrap
set incsearch
set ignorecase
set smartcase

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" JS/HTML/CSS usually use 2 spaces
autocmd FileType javascript,typescript,html,css setlocal tabstop=2 shiftwidth=2

" Required/recommended for coc.nvim
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
set shortmess+=c
set completeopt=menuone,noinsert

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" coc.nvim extensions
let g:coc_global_extensions = [
            \ 'coc-rust-analyzer',
			\ 'coc-tsserver',
			\ 'coc-html',
			\ 'coc-css',
			\ 'coc-json'
			\ ]

" Autocomplete

function! CheckBackspace() abort
      let col = col('.') - 1
        return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
                  \ coc#refresh()

inoremap <silent><expr> <S-TAB>
      \ coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Ctrl+Space in real Vim terminal is often Ctrl+@
inoremap <silent><expr> <C-@> coc#refresh()

" LSP navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Rename symbol
nmap <leader>rn <Plug>(coc-rename)

" Code actions: auto-imports, fixes, assists
nmap <leader>ca <Plug>(coc-codeaction-cursor)
nmap <leader>qf <Plug>(coc-fix-current)

" Format current buffer
command! Format call CocActionAsync('format')

" Organize imports
command! OR call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Highlight symbol under cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Apple Terminal / Coc popup colors

set background=light
set notermguicolors
set t_Co=256

function! s:BasementCocColors() abort
    " Normal popup menu
    highlight Pmenu      cterm=NONE ctermfg=0 ctermbg=254
    highlight PmenuSel   cterm=reverse,bold ctermfg=NONE ctermbg=NONE
    highlight PmenuSbar  cterm=NONE ctermbg=250
    highlight PmenuThumb cterm=NONE ctermbg=0

    " Coc custom popup menu selected item
    highlight CocMenuSel cterm=reverse,bold ctermfg=NONE ctermbg=NONE

    " Coc floating documentation window
    highlight CocFloating    cterm=NONE ctermfg=0 ctermbg=254
    highlight CocFloatBorder cterm=NONE ctermfg=8 ctermbg=254

endfunction

augroup BasementCocColors
      autocmd!
        autocmd VimEnter,ColorScheme * call s:BasementCocColors()
augroup END

call s:BasementCocColors()

" Netrw - native Vim file manager
let g:netrw_banner = 0              " hide ugly banner
let g:netrw_liststyle = 3           " tree-style listing
let g:netrw_browse_split = 0        " open files in same window
let g:netrw_altv = 1                " vertical split opens to the right
let g:netrw_winsize = 25            " width of Lexplore window
let g:netrw_keepdir = 0             " keep Vim cwd synced with browsing dir

nnoremap <leader>e :Lexplore<CR>
nnoremap <leader>E :Explore<CR>

" Tabs
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>
nnoremap <leader>t :tabnew .<CR>
nnoremap <leader>q :tabclose<CR>

" Vim temp files
set directory=$HOME/.vim/swap//
set undofile
set undodir=$HOME/.vim/undo//
set backupdir=$HOME/.vim/backup//
set backupskip=/tmp/*,/private/tmp/*
set nobackup
set nowritebackup
