set shell=/bin/bash

call pathogen#infect() 
call pathogen#helptags() 

set nocompatible
set t_Co=256
set term=screen-256color

set cul                                           " highlight current line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set cm=blowfish2
" Sets how many lines of history VIM has to remember
set history=700
set number 

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Load matchit
runtime macros/matchit.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add padding of 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/node_modules/*

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Display max columns with long lines
set synmaxcol=1024

" Fix syntax highlighting
set nocursorcolumn
set nocursorline
syntax sync minlines=256

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac
set ff=unix

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Whitespace preference by filetype
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype jade setlocal ts=2 sts=2 sw=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Clear highlight
nmap <silent> ,/ :nohlsearch<CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Enable paste mode to prevent auto-indentation
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Syntastic 
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_ignore_files=['.*\.min\..*']

" Navigate buffers
nnoremap <silent> [b :bprevious<CR> 
nnoremap <silent> ]b :bnext<CR> 
nnoremap <silent> [B :bfirst<CR> 
nnoremap <silent> ]B :blast<CR>

" Navigate quick lists
nnoremap <silent> [c :cprev<CR> 
nnoremap <silent> ]c :cnext<CR> 
nnoremap <silent> [C :cfirst<CR> 
nnoremap <silent> ]C :clast<CR>

set runtimepath^=~/.vim/bundle/ctrlp.vimset runtimepath^=~/.vim/bundle/ctrlp.vim

" Ctrl-p options

let g:ctrlp_regexp = 1
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" Grep / Ag
nmap <Leader>G :Ag <C-R><C-W><CR>

" AnkiCard cloze-tag surrounding
nnoremap <Leader>Sc ciw{{c1::<C-r>"}}<Esc>
vnoremap <Leader>Sc c{{c1::<C-r>"}}<Esc>

set tags=tags;/
syntax on

" Cscope
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

" 0 or s: Find this C symbol
" 1 or g: Find this definition
" 2 or d: Find functions called by this function
" 3 or c: Find functions calling this function
" 4 or t: Find this text string
" 6 or e: Find this egrep pattern
" 7 or f: Find this file
" 8 or i: Find files #including this file
map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Using 'CTRL-spacebar' then a search type makes the vim window
" split horizontally, with search result displayed in
" the new window.
nmap g<C-_>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap g<C-_>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap g<C-_>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap g<C-_>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap g<C-_>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap g<C-_>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap g<C-_>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap g<C-_>d :scs find d <C-R>=expand("<cword>")<CR><CR>

" Hitting CTRL-space *twice* before the search type does a vertical
" split instead of a horizontal one
nmap g<C-_><C-_>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap g<C-_><C-_>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap g<C-_><C-_>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap g<C-_><C-_>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap g<C-_><C-_>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap g<C-_><C-_>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap g<C-_><C-_>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

" Delay for moving with hjkl so that they are not overused
noremap hh <nop>
noremap jj <nop>
noremap kk <nop>
noremap ll <nop>

" Transparent editing of gpg encrypted files.
augroup encrypted
au!
" First make sure nothing is written to ~/.viminfo while editing
" an encrypted file.
autocmd BufReadPre,FileReadPre      *.gpg,*.wiki set viminfo=
" We don't want a swap file, as it writes unencrypted data to disk
autocmd BufReadPre,FileReadPre      *.gpg,*.wiki set noswapfile
" Switch to binary mode to read the encrypted file
autocmd BufReadPre,FileReadPre      *.gpg,*.wiki set bin
autocmd BufReadPre,FileReadPre      *.gpg,*.wiki let ch_save = &ch|set ch=2
autocmd BufReadPre,FileReadPre      *.gpg,*.wiki let shsave=&sh
autocmd BufReadPre,FileReadPre      *.gpg,*.wiki let &sh='sh'
autocmd BufReadPre,FileReadPre      *.gpg,*.wiki let ch_save = &ch|set ch=2
autocmd BufReadPost,FileReadPost    *.gpg,*.wiki '[,']!gpg2 --decrypt --default-recipient-self 2> /dev/null
autocmd BufReadPost,FileReadPost    *.gpg,*.wiki let &sh=shsave
" Switch to normal mode for editing
autocmd BufReadPost,FileReadPost    *.gpg,*.wiki set nobin
autocmd BufReadPost,FileReadPost    *.gpg,*.wiki let &ch = ch_save|unlet ch_save
autocmd BufReadPost,FileReadPost    *.gpg,*.wiki execute ":doautocmd BufReadPost " . expand("%:r")
" Convert all text to encrypted text before writing
autocmd BufWritePre,FileWritePre    *.gpg,*.wiki set bin
autocmd BufWritePre,FileWritePre    *.gpg,*.wiki let shsave=&sh
autocmd BufWritePre,FileWritePre    *.gpg,*.wiki let &sh='sh'
autocmd BufWritePre,FileWritePre    *.gpg,*.wiki '[,']!gpg2 --encrypt --default-recipient-self 2>/dev/null
autocmd BufWritePre,FileWritePre    *.gpg,*.wiki let &sh=shsave
" Undo the encryption so we are back in the normal text, directly
" after the file has been written.
autocmd BufWritePost,FileWritePost  *.gpg,*.wiki silent u
autocmd BufWritePost,FileWritePost  *.gpg,*.wiki set nobin
augroup END
