" Vundle
set nocp
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'    " NERDTree
Plugin 'kien/ctrlp.vim'         " ctrlp
Plugin 'tpope/vim-commentary'    " gcc=comments or uncomments
Plugin 'tpope/vim-fugitive'     " git
"Plugin 'vim-gitgutter'          " git, shows +/~/- in gutter
Plugin 'rking/ag.vim'           " ag
Plugin 'kien/rainbow_parentheses.vim'   " Rainbow Parens
Plugin 'vim-syntastic/syntastic'    " syntax checking
Plugin 'tpope/vim-surround'     " work with ({[]})
Plugin 'dikiaap/minimalist'     " good colorscheme
Plugin 'davidhalter/jedi-vim'   " Python
"Plugin 'SirVer/ultisnips'       " Code snippets
" https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources
" Go
Plugin 'fatih/vim-go'           " Go
Plugin 'AndrewRadev/splitjoin.vim' " Go structs
" Go Autocomplete. First do `pip3 install pynvim`
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'stamblerre/gocode', {'rtp': 'vim/'} " gocode autocomplete
Plugin 'deoplete-plugins/deoplete-go'   " deoplete for go
call vundle#end()

" Basics & Fixes
filetype plugin indent on
syntax on
" no splash screen
set shortmess+=I
" spaces, not tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" set autoindent " off b/c filetype indent is on
set smartindent " Usually works
" show line and column position
set ruler
" show matching brackets & parens
set showmatch
set showmode
" Cursor lines slows vim
set nocursorline
" smart search
set incsearch
set ignorecase
set smartcase
" don't continue comments with o or O
set formatoptions-=o
" auto wrap
set formatoptions+=cr
" space moves page forward, like `less`
nnoremap <Space> <C-f>
" highlight trailing whitespace red
match ErrorMsg '\s\+$'
" fix tab and shift-tab
vmap <Tab> >gv
vmap <S-Tab> <gv
inoremap <S-Tab> <C-D>
" have backspace work as expected
set backspace=2
" take lag out of Esc
set timeout timeoutlen=1000 ttimeoutlen=10
" don't auto newline at 80 chars
set textwidth=0
" stop asking to load files (reload manually with :e)
set autoread
" this 'mouse' thing might be a fad, but let's try it out
set mouse=a
" copy to the system clipboard
set clipboard=unnamed
" autowrite when :make is called
set autowrite
set encoding=utf-8

" put backup~ and .swp files in ~/.vim (fallback to /tmp)
set backup
set swapfile
set backupdir=~/.vim/bk/,/tmp//
set directory=~/.vim/swp/,/tmp//
set undodir=~/.vim/undo/,/tmp//

" Customizations
colorscheme minimalist
" comma is Leader
let mapleader = ","
let g:mapleader = ","
" Q executes @q
" qq<record macro>q then Q to repeat macro
nnoremap Q @q
" :set list chars
set listchars=eol:$,tab:>-,trail:-
" 100ms is faster than default 800ms
" set updatetime=250

" CtrlP
" ctrl-l invokes CtrlP plugin
let g:ctrlp_map = '<C-l>'
let g:ctrlp_cmd = 'CtrlP'
" CtrlP don't move
let g:ctrlp_working_path_mode = ''
let g:ctrlp_custom_ignore = {
\ 'dir': '\v[\/](\.(git|hg|svn)|bin)$',
\ 'file': '\v\.(exe|so|dll)$',
\ 'link': 'some_bad_symbolic_links',
\ }
" no max file count
let g:ctrlp_max_files=0
" but don't go into a black hole
let g:ctrlp_max_depth=40

" NERDTree
let g:NERDTreeIgnore=['\~$']

" Rainbow Parens
au VimEnter * RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" " UtilSnips fix
" let g:UltiSnipsUsePythonVersion = 3

" deoplete
" let g:deoplete#enable_at_startup = 1

" Go
" autoimport
let g:go_fmt_command = "goimports"
" don't show fmt failures
let g:go_fmt_fail_silently = 1
let g:go_addtags_transform = "camelcase"
" auto show info
let g:go_auto_type_info = 1
" underline same ids
let g:go_auto_sameids = 1
" Go shortcuts
" ,b build ,r run ,t test ,c coverage ,i info
"autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" For all other filetypes ,b and ,m run make
nmap <leader>b :make<CR>
nmap <leader>m :make<CR>
set makeprg=make " or obviously change to whatever your build system is

" Other common filetype specifiers
augroup configgroup
    autocmd!
    " Ruby uses 2-spaces
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal expandtab
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType ruby setlocal tabstop=2
    " Tabs only: Makefile and Go
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter go setlocal noexpandtab
augroup END


" setting it earlier isn't actually sticking, so adding it here again:
autocmd FileType * set formatoptions-=o
autocmd FileType * set formatoptions+=cr
