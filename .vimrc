" Allow Vim-only settings even if they break vi keybindings.
set nocompatible

syntax on " syntax highting
filetype on " Enable filetype detection
filetype plugin indent on " enable loading indent file for filetypes

let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

"General settings
set incsearch               "Find as you type
set ignorecase              "Ignore case in search
set scrolloff=2             "Number of lines to keep above/below cursor
set smartcase               "Only ignore case when all letters are lowercase
set number                  "Show line numbers
set wildmode=longest,list   "Complete longest string, then list alternatives
set pastetoggle=<F2>        "Toggle paste mode
set fileformats=unix        "Use Unix line endings
set smartindent             "Smart autoindenting on new line
set smarttab                "Respect space/tab settings
set history=300             "Number of commands to remember
set showmode                "Show whether in Visual, Replace, or Insert Mode
set showmatch               "Show matching brackets/parentheses
set backspace=2             "Use standard backspace behavior
set hlsearch                "Highlight matches in search
set ruler                   "Show line and column number
set formatoptions=1         "Don't wrap text after a one-letter word
set linebreak               "Break lines when appropriate
"set list                    "show invisible characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<


"Drupal settings
set expandtab               "Tab key inserts spaces
set tabstop=2               "Use two spaces for tabs
set shiftwidth=2            "Use two spaces for auto-indent
set autoindent              "Auto indent based on previous line
let php_htmlInStrings = 1   "Syntax highlight for HTML inside PHP strings
let php_parent_error_open = 1 "Display error for unmatch brackets
let php_sql_query = 1 "for SQL syntax highlighting inside strings
let php_parent_error_close = 1 "for highlighting parent error ] or )
let g:syntastic_phpcs_conf=" --standard=Drupal --extensions=php,module,inc,install,test,profile,theme" "Syntactic checking using Drupal Coding Standard

" let php_folding = 1 "for folding classes and functions
" let php_sync_method = 0
"                             x=-1 to sync by search ( default )
"                             x>0 to sync at least x lines backwards
"                             x=0 to sync from start


"Enable syntax highlighting
if &t_Co > 1
  syntax enable
endif

"Set filetype for Drupal PHP files.
if has("autocmd")
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.php set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
    autocmd BufRead,BufNewFile *.theme set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
  augroup END
endif

"Custom key mappings
map <S-u> :redo<cr>
map <C-n> :tabn<cr>
map <C-p> :tabp<cr>

" Map movements from one window pane to another
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" PDV mappings
inoremap <C-P> :call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>


" Vim jump to the last position when reopening a file
if has("autocmd")
 au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
 \| exe "normal! g'\"" | endif
endif

" Highlight long comments and trailing whitespace.
  if has("matchadd")
    highlight ExtraWhitespace ctermbg=red guibg=red
    let a = matchadd('ExtraWhitespace', '\s\+$')
    highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
    let b = matchadd('OverLength', '\(^\(\s\)\{-}\(*\|//\|/\*\)\{1}\(.\)*\(\%81v\)\)\@<=\(.\)\{1,}$')
  endif

" Lookup the API docs for a drupal function under cursor.
nnoremap <Leader>da :execute "!open http://api.drupal.org/".shellescape(expand("<cword>"), 1)<CR>
" Lookup the API docs for a drush function under cursor.
nnoremap <Leader>dda :execute "!open http://api.drush.ws/api/function/".shellescape(expand("<cword>"), 1)<CR>
" Get the value of the drupal variable under cursor.
nnoremap <Leader>dv :execute "!drush vget ".shellescape(expand("<cword>"), 1)<CR>


" Leader here can be set to athing.  The default is \
map <Leader>tl <Plug>TaskList
map <leader>n :NERDTreeToggle<CR>
map <Leader>g :GundoToggle<CR>
map <Leader>a <Esc>:Ack! 
map <Leader>mg :call MakeGreen()<cr>$ 
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>
map <Leader>t :TlistToggle<CR>

" Pathogen
" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
"call add(g:pathogen_disabled, 'gundo')
"call add(g:pathogen_disabled, 'makegreen')
"call add(g:pathogen_disabled, 'matchit')
"call add(g:pathogen_disabled, 'vip')
"call add(g:pathogen_disabled, 'supertab')
"call add(g:pathogen_disabled, 'tasklist')
"call add(g:pathogen_disabled, 'ack')
"call add(g:pathogen_disabled, 'nerdtree')
"call add(g:pathogen_disabled, 'fugitive')
"call add(g:pathogen_disabled, 'drupalvim')

" Gundo requires at least vim 7.3
if v:version < '703' || !has('python')
  call add(g:pathogen_disabled, 'gundo')
endif

if v:version < '702'
  call add(g:pathogen_disabled, 'autocomplpop')
  call add(g:pathogen_disabled, 'ZoomWin')
  call add(g:pathogen_disabled, 'fuzzyfinder')
  call add(g:pathogen_disabled, 'L9')
  call add(g:pathogen_disabled, 'syntastic')
  call add(g:pathogen_disabled, 'Tagbar')
endif

if !executable("ctags")
  call add(g:pathogen_disabled, 'Taglist')
  call add(g:pathogen_disabled, 'Tagbar')
endif

call pathogen#infect()

set background=dark
let g:solarized_termcolors=16
let g:solarized_termtrans=1
let g:solarized_bold=1
set t_Co=256
colorscheme solarized


set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set statusline+=%{fugitive#statusline()}


if filereadable("/var/www/html/dkinzer/website/tags")
  set tags=./tags,/var/www/html/dkinzer/website/tags
endif
