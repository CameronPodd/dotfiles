" Required Vundle Code --------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins-----------------------------------------------
Plugin 'Valloric/YouCompleteMe' " Syntax Checking
Plugin 'w0rp/ale' " Asynchronous YCM
Plugin 'jiangmiao/auto-pairs' " Auto-closing brackets
Plugin 'prettier/vim-prettier'
"
" All of your Plugins must be added before the following line
call vundle#end()

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" UI Config ----------------------------------------------------
set encoding=utf-8
set background=dark
colorscheme desert
set number              " show line numbers
set showcmd             " show command in bottom bar
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set columns=9999        " Make window full screen
set lines=9999
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
set guioptions+=e
set showtabline=2

" Syntax ----------------------------------------------
syntax enable           " enable syntax processing
set guifont=Fixedsys:h10

" Tabzz -------------------------------------------------
" Whitespace.
" Spaces instead of tabs.
set expandtab
" How many columns a tab counts for.
set tabstop=4
" How many columns vim uses when you hit Tab in insert mode.
set softtabstop=4
" How many columns of text is indented with <<, >>, and cindent.
set shiftwidth=4
set backspace=indent,eol,start
set smarttab
" Indentation
set autoindent
set cindent

" Backup, Swap, Undo Directories -------------------------------
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

" Backspace --------------------------------------------
set backspace=indent,eol,start

" Optimizations ----------------------------------------
set lazyredraw          " redraw only when we need to

" Search ---------------------------------------------------
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" Folding ----------------------------------------
set foldenable          " enable folding
set foldlevelstart=3   " open most folds by default
nnoremap <space> za
set foldmethod=indent   " fold based on indent level
set foldignore=

" Movement --------------------------------------
set autochdir

" Leader Mappings -------------------------------------
let mapleader=","       " leader is comma

" jk is escape
inoremap jk <esc>

" Terminal Remaps
" tnoremap : <C-w>:
" tnoremap <leader>w <C-w>

" Map leader w to window commands
nnoremap <leader>w <C-w>

" Map Shift-Enter to add new line inplace
nmap <S-Enter> O<Esc>

" Map Enter to add new line below inplace
nmap <Enter> o<Esc>

" File Specific Settings ---------------------------------------
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter Makefile setlocal noexpandtab
augroup END

" Set filetype extensions
augroup msbuildextensions
    au!
    autocmd BufNewFile,BufRead *.vcxproj set syntax=xml
    autocmd BufNewFile,BufRead *.csproj set syntax=xml
augroup END

" Custom Functions ---------------------------
function! Formatonsave()
  let l:formatdiff = 1
  py3f ~/.vim/clang-format.py
endfunction
autocmd BufWritePre *.h,*.hpp,*.cpp call Formatonsave()

" ---------------------------------- "
"  " Configure YouCompleteMe
"
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :tab split \| YcmCompleter GoToDefinition<CR>
let g:jedi#use_tabs_not_buffers = 1
let g:ycm_show_diagnostics_ui = 1
let g:ycm_register_as_syntastic_checker = 1 "default 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" Ale Config -------------------------------------
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 0
" let g:ale_python_pylint_executable = '/home/cbpodd/anaconda3/bin/pylint'

" Prettier Config --------------------------------
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue, PrettierAsync