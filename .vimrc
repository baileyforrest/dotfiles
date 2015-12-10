" .vimrc
" Bailey Forrest <baileycforrest@gmail.com>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Plugin plugins
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-sleuth'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()

filetype plugin indent on " Enable filetype plugins
set omnifunc=syntaxcomplete#Complete " Enable omnicomplete


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set shiftwidth=4 expandtab
set textwidth=80


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup " No backup files
set directory=$XDG_DATA_HOME/vim " Vim .swp file location
set autoindent
set encoding=utf-8
set wildmode=longest,list,full " Tab expand up partial matches
set wildmenu " Open matching window
set spelllang=en_us " American English for spell checking


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme molokai
set laststatus=2 " Always enable status line
set t_Co=256 " Enable 256 colors

if exists('+relativenumber')
    set relativenumber " Show line numbers from cursor
else
    set number " Number shows current line number on 0 position if relative enabled
endif

" Highlight lines over 80 char
if exists('+colorcolumn')
    set colorcolumn=80
    hi ColorColumn ctermbg=235
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Show trailing whitespace and tabs as characters
set list
set listchars=trail:·,tab:▸-
highlight SpecialKey ctermfg=1

" Set up spelling errors to look nicer
hi SpellBad guisp=red gui=undercurl guifg=NONE guibg=NONE ctermfg=red ctermbg=NONE term=underline cterm=underline


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keyboard shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-c> :bp\|bd # <CR>
nnoremap <F4> :make!<cr>
nnoremap ; :
nnoremap m :
inoremap jj <ESC>
nnoremap <leader>en <esc>:cn <cr>
nnoremap <leader>ep <esc>:cp <cr>
let mapleader=" "

" Expand %% to file's current path
cabbr <expr> %% expand('%:p:h')

" Open :e with cwd expanded
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" Open :/? in buffer mode
nnoremap <Leader>m q:i
nnoremap <Leader>/ q/i
nnoremap <Leader>? q?i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Alternative syntax for filetypes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufReadPost *.sig set syntax=sml
au BufReadPost *.glsl set syntax=c


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Configure gtags
set cscopetag
nnoremap <Leader>gg :GtagsCscope<CR>
nnoremap <Leader>gc :cclose<CR>
nnoremap <Leader>gn :cn<CR>
nnoremap <Leader>gp :cp<CR>
nnoremap <Leader>gr :Gtags -r<CR><CR>

" Plugin Toggles
nmap <F8> :TagbarToggle<CR>
nmap <c-_> :NERDTreeToggle<CR>

" Toggle CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = ''
nnoremap <Leader>p :CtrlPMixed<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>

" Syntastic Options
let g:syntastic_check_on_open=1 "Check syntax of file open

" JSLint options
let g:syntastic_javascript_checkers = ['jshint']

" Default ycm conf for scratch files
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>yd :YcmDiags<CR>
