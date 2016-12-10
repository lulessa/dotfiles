" Author: Lucas Lessa
" https://github.com/lulessa

" Expand tabs to 2 spaces
set expandtab
set shiftwidth=2
set softtabstop=2


" Leader mappings
let mapleader = "\<Space>"

nmap <leader>vr :sp $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>
map <leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<cr>

" Easy access to beginning of line
nmap 0 ^
" Quickly escape insert mode
imap jk <esc>
imap kj <esc>

nmap k gk
nmap j gj

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"set autowrite " Write whenever i make a change
set backspace=indent,eol,start " allow backspacing over everything in insert mode

set nobackup		" do not keep a backup file, use versions instead
set noswapfile          " do not keep swap files

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set relativenumber      " Set line numbers to be relative
colorscheme koehler

" zoom a vim pane, zoom vertically, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>\ :wincmd _<cr>
nnoremap <leader>= :wincmd =<cr>

" make test commands execute using dispatch.vim
let test#strategy = "vtr"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
map <Leader>f :VtrFocusRunner<CR>

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
let g:ctrlp_use_caching = 0

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
  
  " automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =

  " Associate .es6 files with javascript syntax
  autocmd BufRead,BufNewFile *.es6 setfiletype javascript

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'kchmck/vim-coffee-script'
" Plug 'vim-airline/vim-airline' " It is not allowing me to commit with git.
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'janko-m/vim-test'
Plug 'ngmy/vim-rubocop'
Plug 'elixir-lang/vim-elixir'
Plug 'slim-template/vim-slim'
" Add plugins to &runtimepath
call plug#end()

" Status and tab line colors more contrasting.
hi StatusLine ctermfg=Black ctermbg=White
hi StatusLineNC ctermfg=White ctermbg=Black
hi TabLine ctermfg=White ctermbg=DarkGrey
hi TabLineSel ctermfg=White ctermbg=Black
hi Title ctermfg=LightGrey
