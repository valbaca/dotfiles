" Vundle
set nocp
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'                " NERDTree
Plugin 'kien/ctrlp.vim'                     " ctrlp
Plugin 'tpope/vim-commentary'               " gcc=comments or uncomments
Plugin 'tpope/vim-fugitive'                 " git
Plugin 'airblade/vim-gitgutter'             " git, shows +/~/- in gutter
Plugin 'rking/ag.vim'                       " Ag
Plugin 'Yggdroot/indentLine'                " show with :IndentLinesToggle
Plugin 'kien/rainbow_parentheses.vim'       " Rainbow Parens
"Plugin 'vim-syntastic/syntastic'            " syntax checking
Plugin '907th/vim-auto-save'                " autosave, :AutoSaveToggle
Plugin 'tpope/vim-abolish'                  " rename helper :Abolish :%Subvert
Plugin 'tpope/vim-obsession'                " Sessions :Obsess / :so Session.vim
Plugin 'tpope/vim-surround'                 " work with ({[]})
Plugin 'machakann/vim-swap'                 " easily move comma separated items
Plugin 'godlygeek/tabular'                  " horizontal aligning :Tab /=
Plugin 'davidhalter/jedi-vim'               " Python
Plugin 'maksimr/vim-jsbeautify'             " js formatter (Ctrl-f)
Plugin 'fatih/vim-go'                       " Go
Plugin 'AndrewRadev/splitjoin.vim'          " Go structs
Plugin 'Shougo/deoplete.nvim'               " autocomplete
Plugin 'roxma/nvim-yarp'                    " remote plugin (req for autocomplete)
Plugin 'roxma/vim-hug-neovim-rpc'           " rpc plugin (req for autocomplete)
Plugin 'stamblerre/gocode', {'rtp': 'vim/'} " gocode autocomplete
Plugin 'deoplete-plugins/deoplete-go'       " deoplete for go
Plugin 'tfnico/vim-gradle'                  " recognize gradle files
Plugin 'keith/swift.vim'                    " swift
Plugin 'tpope/vim-salve'                    " static support for Leiningen and Boot
Plugin 'clojure-emacs/cider-nrepl'          " Clojure repl support
Plugin 'guns/vim-clojure-highlight'         " Clojure highlights
Plugin 'guns/vim-clojure-static'            " Clojure static
Plugin 'tpope/vim-fireplace'                " Clojure repl
Plugin 'venantius/vim-cljfmt'               " Clojure format
" Archive / Broken / etc
"Plugin 'Valloric/YouCompleteMe'            " autocomplete (requires setup)
"Plugin 'SirVer/ultisnips'                  " Code snippets (weird with python rn)
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'wincent/terminus'   " change cursor to block in visual & pipe in insert
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
" Make the line numbers a more "background" color
highlight LineNr ctermfg=grey
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
" similar to MS Word:'Enter' adds a new-line before the current line
map <CR> O<Esc>j
" highlight trailing whitespace red
match ErrorMsg '\s\+$'
" fix tab and shift-tab
vmap <Tab> >gv
vmap <S-Tab> <gv
inoremap <S-Tab> <C-D>
" have backspace work as expected
set backspace=2
" take lag out of Esc
set timeout timeoutlen=200 ttimeoutlen=10
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
" encode like, the good way
set encoding=utf-8
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" otherwise mouse doesn't work in widescreen (WTF?!)
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end
" put backup~ and .swp files in ~/.vim (fallback to /tmp)
set backup
set swapfile
set backupdir=~/.vim/bk/,/tmp//
set directory=~/.vim/swp/,/tmp//
set undodir=~/.vim/undo/,/tmp//
" use ctrl-x ctrl-k for diKtionary completion
set dictionary=/usr/share/dict/words

" Customizations
" comma is Leader
let mapleader = ","
let g:mapleader = ","
" Q executes @q
" qq<record macro>q then Q to repeat macro
nnoremap Q @q
" :set list chars
set listchars=eol:$,tab:>-,trail:-
" get rid of bars on the left
set foldcolumn=0
" remove special treatment of #
set cinkeys-=0#
set indentkeys-=0#
" fd in insert is ESC (like spacemacs)
inoremap fd <Esc>

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

" vim-commentary
autocmd FileType mason set commentstring=#\ %s

" Rainbow Parens
au VimEnter * RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

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


" Other common filetype specifiers
augroup configgroup
    autocmd!
    " 2-space indention: ruby
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal expandtab
    autocmd FileType ruby setlocal tabstop=2
    " # for comments: ruby and python
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    " Tabs indentation: Makefile and Go
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter go setlocal noexpandtab
    " Misc filename <=> filetype fixes
    autocmd BufRead,BufNewFile *.m set ft=mason
    autocmd BufRead,BufNewFile *.mi set ft=mason
    autocmd BufRead,BufNewFile *.tag set ft=jsp
    autocmd BufNewFile,BufRead *.md set syntax=markdown
augroup END

" Ctrl-f formats Javascript
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>

" More fixes?
" setting it earlier isn't actually sticking, so adding it here again:
autocmd FileType * set formatoptions-=o
autocmd FileType * set formatoptions+=cr
