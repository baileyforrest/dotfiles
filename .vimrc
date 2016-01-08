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
Plugin 'ctrlpvim/ctrlp.vim'
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

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Make prompt to create directory if it doesn't exist
function! CreateDirectoryAskConfirmation(dir)
    if isdirectory(a:dir) " Directory exists
        return
    endif

    " Ask for confirmation to create this directory
    echohl Question
    echo "Create directory `" . a:dir . "' [y/N]?"
    echohl None

    let response = nr2char(getchar())
    " mkdir() and :write if we want to make a directory
    if response ==? "y"
        call mkdir(a:dir, "p")
    endif
endfunction

" Disable omnicomplete preview window after choosing an option.
autocmd CompleteDone * pclose

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
let mapleader=" "
nnoremap <C-c> :bp\|bd # <cr>
nnoremap <F4> :make!<cr>
nnoremap ; :
nnoremap m :
nnoremap <leader>md :call CreateDirectoryAskConfirmation(expand("%:p:h"))<cr>
inoremap jj <ESC>
nnoremap <leader>en <esc>:cn <cr>
nnoremap <leader>ep <esc>:cp <cr>

" Expand %% to file's current path
cabbr <expr> %% expand('%:p:h')

" Open :e with cwd expanded
nnoremap <leader>e :e <C-R>=expand('%:p:h') . '/'<cr>

" Open :/? in buffer mode
nnoremap <leader>m q:i
nnoremap <leader>/ q/i
nnoremap <leader>? q?i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Alternative syntax for filetypes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufReadPost *.sig set syntax=sml
au BufReadPost *.glsl set syntax=c


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" airline
" remove separators
let g:airline_left_sep=''
let g:airline_right_sep=''

" Configure gtags
set cscopetag
nnoremap <leader>gg :GtagsCscope<cr>
nnoremap <leader>gc :cclose<cr>
nnoremap <leader>gn :cn<cr>
nnoremap <leader>gp :cp<cr>
nnoremap <leader>gr :Gtags -r<cr><cr>

" Plugin Toggles
nmap <F8> :TagbarToggle<cr>
nmap <c-_> :NERDTreeToggle<cr>

" Toggle CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_switch_buffer = '' " Don't switch to window with buffer already open
let g:ctrlp_max_files = 0 " Unlimited files to scan
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(d|o)$',
  \ }
nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>

" Syntastic Options
let g:syntastic_check_on_open=1 "Check syntax of file open

" JSLint options
let g:syntastic_javascript_checkers = ['jshint']

" Default ycm conf for scratch files
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
nnoremap <leader>jd :YcmCompleter GoTo<cr>
nnoremap <leader>yd :YcmDiags<cr>
