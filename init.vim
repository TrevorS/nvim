" vim settings
syntax on

filetype indent plugin on

set number
set smartindent
set expandtab

set shiftwidth=2
set softtabstop=2
set tabstop=2

set ignorecase
set smartcase

set virtualedit=onemore

set undofile
set undolevels=1000
set undoreload=10000
set undodir=$HOME/.config/nvim/undo

set wildmode=longest,list:longest

set tags+=./.git/tags

set lazyredraw
set noshowmode

set noerrorbells visualbell t_vb=

set clipboard+=unnamedplus

" turn on true color
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" plugs
call plug#begin($HOME . '/.config/nvim/plugged')

" javascript
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'mxw/vim-jsx'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'burnettk/vim-angular'

" templating
Plug 'plasticboy/vim-markdown'
Plug 'mustache/vim-mustache-handlebars'

" ruby
Plug 'vim-ruby/vim-ruby'

" elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'powerman/vim-plugin-AnsiEsc'

" tpope
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'

" junegunn
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'

" shougo
Plug 'Shougo/deoplete.nvim'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" utilities
Plug 'mhinz/vim-signify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/syntastic'
Plug 'Raimondi/delimitMate'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'

" themes
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
call plug#end()

" theme
let g:jellybeans_use_term_italics = 1

set background=dark
colorscheme jellybeans

" file specific nvim settings
augroup file_specific_settings
  autocmd!
  autocmd FileType markdown setlocal spell
  autocmd FileType gitcommit setlocal spell
  autocmd BufRead,BufNewFile *.jbuilder setfiletype ruby
  autocmd BufWritePre * StripWhitespace
  autocmd VimEnter * CurrentLineWhitespaceOff soft

  autocmd FileType ruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby let g:rubycomplete_classes_in_global = 1
augroup END

" keymaps
let mapleader = ','

" jj to escape insert mode
inoremap <silent> jj <ESC>

" remap , to repeat like find
nnoremap <silent> \ ,

" readline-like keybindings in command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>

" up and down through soft wrap
noremap <silent> j gj
noremap <silent> k gk

" reindent whole file
nnoremap <silent> <leader>i gg=G''

" grep under cursor
nnoremap <silent> <leader>* :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" window manipulation
nnoremap <silent> <leader>l :redraw!<CR>:nohl<CR><ESC>
nnoremap <silent> <leader>v :vsplit<CR><C-w><C-w>
nnoremap <silent> <leader>h :split<CR><C-w><C-w>
nnoremap <silent> <leader>q :quit<CR>

" quickly edit/reload the vimrc file or plugs file
nnoremap <silent> <leader>ev  :e $MYVIMRC<CR>
nnoremap <silent> <leader>esv :vsplit<CR><C-w><C-w>:e $MYVIMRC<CR>
nnoremap <silent> <leader>sv  :so $MYVIMRC<CR>:nohl<CR>

" quickly edit .zshrc
nnoremap <silent> <leader>ez :e $HOME/.zshrc<CR>
nnoremap <silent> <leader>ezv :vsplit<CR><C-w><C-w>:e $HOME/.zshrc<CR>

" quickly edit .tmux.conf
nnoremap <silent> <leader>et :e $HOME/.tmux.conf<CR>
nnoremap <silent> <leader>etv :vsplit<CR><C-w><C-w>:e $HOME/.tmux.conf<CR>

" fzf
nnoremap <silent> <leader>p :call fzf#run({ 'source': 'ag -g ""', 'sink': 'e', 'window': 'enew' })<CR>

" easy align
vmap <silent> <CR> <Plug>(EasyAlign)

" easy split navigation
nnoremap <BS> <C-w>h
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" terminal mode shortcuts
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" center screen when jumping to next match
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
"
" center screen while paging
nnoremap <silent> <C-d> <C-d>zz
nnoremap <silent> <C-u> <C-u>zz

" ag
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  nnoremap <leader>a :Ag!

  let g:ag_highlight = 1
endif

" vim-test
let test#strategy = "neovim"
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tT :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" format JSON
nnoremap <silent> <leader>fj :%!python -m json.tool<CR>:set syntax=json<CR>

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"

" syntastic
let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_mode_map = { "mode": "active", "passive_filetypes": ["java", "jruby"] }
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_html_tidy_blocklevel_tags = [
  \ 'ion-view',
  \ 'ion-content',
  \ 'ion-nav-bar',
  \ 'ion-nav-back-button',
  \ 'ion-nav-view',
  \ 'ion-nav-buttons',
  \ 'ion-list',
  \ 'ion-item',
  \ 'ion-refresher'
  \ ]

" vim-ruby
let ruby_operators = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1
let g:rubycomplete_use_bundler = 1

" lightline
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" deoplete
let g:deoplete#enable_at_startup = 1
