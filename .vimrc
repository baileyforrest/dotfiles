" .vimrc
" Bailey Forrest <baileycforrest@gmail.com>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-altr'
Plug 'leafgarland/typescript-vim'
Plug 'majutsushi/tagbar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'
Plug 'tomasr/molokai'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

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
set nobackup
set nowritebackup
set directory=$XDG_DATA_HOME/vim " Vim .swp file location
set wildmode=longest,list,full " Tab expand up partial matches
set spelllang=en_us " American English for spell checking

" Persistent undo
set undofile
set undodir=$XDG_DATA_HOME/vim/undo

set undolevels=1000
set undoreload=10000

" Recommended by coc.nvim
set encoding=utf-8
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes


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

function ToggleWrap()
  if (&wrap == 1)
    set nowrap
  else
    set wrap
  endif
endfunction

" Disable omnicomplete preview window after choosing an option.
autocmd CompleteDone * pclose

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256 " Enable 256 colors
let g:solarized_termcolors=256
set background=light
colorscheme solarized

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
" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
map <F9> :call ToggleWrap()<cr>
nnoremap <C-c> :bp<bar>sp<bar>bn<bar>bd<CR>.
nmap <F4>  <Plug>(altr-forward)
nmap <S-F4>  <Plug>(altr-back)
nnoremap ; :
nnoremap m :
nnoremap <leader>md :call CreateDirectoryAskConfirmation(expand("%:p:h"))<cr>
inoremap jj <ESC>
nnoremap <leader>en <esc>:cn <cr>
nnoremap <leader>ep <esc>:cp <cr>

" Remove trailing whitespace
nnoremap <leader>tws <esc>:%s/\s\+$//e <cr>

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
let g:airline_theme='solarized'

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

" FZF options
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~40%' }
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>s :Ag<cr>

" easymotion
" Dvorak friendly keys
let g:EasyMotion_keys='zl;savqr,nowj.cmkbxdifygptehu'

" <Leader>c{char} to move to {char}
map  <Leader>c <Plug>(easymotion-bd-f)
nmap <Leader>c <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" coc.nvim

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
