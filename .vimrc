set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Bundle plugins
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'pangloss/vim-javascript'
"Bundle 'jelera/vim-javascript-syntax'
Bundle 'plasticboy/vim-markdown'
Bundle 'wavded/vim-stylus'
Bundle 'scrooloose/syntastic'
Bundle 'digitaltoad/vim-jade'
Bundle 'Lokaltog/vim-powerline'

" Enable filetype plugins
filetype plugin indent on

" Enable omnicomplete
set omnifunc=syntaxcomplete#Complete

syntax on
set tabstop=4 shiftwidth=4 expandtab " No tabs, default tab width 4
set autoindent
set cindent
set encoding=utf-8
set laststatus=2 " Always enable status line
set nobackup " No backup files
set directory=~/.tmp/vim " Vim .swp file location

" Line number config
set relativenumber " Show line numbers from cursor
highlight LineNr ctermfg=10 ctermbg=234

" Enable 256 colors
set t_Co=256

" Mark Trailing white spaces
set list
set listchars=tab:>-
set listchars=trail:~
highlight SpecialKey ctermfg=14 ctermbg=1

" Highlight lines over 80 char
if exists('+colorcolumn')
    set colorcolumn=80
    hi ColorColumn ctermbg=235
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Plugin config
" Plugin Toggles
nmap <F8> :TagbarToggle<CR>
nmap <c-_> :NERDTreeToggle<CR>

" Toggle CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = ''

" Syntastic Options
"let g:syntastic_check_on_open=1 "Check syntax of file open

" html indent options
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" JSLint options
let g:syntastic_javascript_checkers = ['jshint']
