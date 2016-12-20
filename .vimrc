" .vimrc
" Bailey Forrest <baileycforrest@gmail.com>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/syntastic'
Plug 'tomasr/molokai'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer --tern-completer --racer-completer' }

call plug#end()

set omnifunc=syntaxcomplete#Complete " Enable omnicomplete


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set textwidth=80
set cinoptions=l1 " Sane c/c++ switch case indentation

" Alternative syntax for filetypes
au BufReadPost *.sig set syntax=sml
au BufReadPost *.glsl set syntax=c



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup " No backup files
set directory=$XDG_DATA_HOME/vim " Vim .swp file location
set wildmode=longest,list,full " Tab expand up partial matches
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
set t_Co=256 " Enable 256 colors

if exists('+relativenumber')
    set relativenumber " Show line numbers from cursor
else
    set number " Number shows current line number on 0 position if relative enabled
endif

if exists('+colorcolumn')
    set colorcolumn=+0
    hi ColorColumn ctermbg=235
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Show trailing whitespace and tabs as characters
set list
set listchars=trail:·,tab:▸-,extends:>,precedes:<,nbsp:+

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

" Syntastic Options
let g:syntastic_check_on_open=1 "Check syntax of file open

" JSLint options
let g:syntastic_javascript_checkers = ['jshint']

" Default ycm conf for scratch files
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
nnoremap <leader>jd :YcmCompleter GoTo<cr>
nnoremap <leader>yd :YcmDiags<cr>

" FZF options
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~40%' }
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>s :Ag<cr>
