" Allow Vim-only settings even if they break vi keybindings.
set nocompatible

"Enable filetype detection
":filetype on
call pathogen#infect()
syntax on
filetype plugin indent on

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
set list                    "show invisible characters
set listchars=tab:>�,trail:� "but only show tabs and trailing whitespace

"Sugar settings
"set tags=~/.vim/mytags/sugar "ctags for sugarcrm_dev project


"Drupal settings
set expandtab               "Tab key inserts spaces
set tabstop=2               "Use two spaces for tabs
set shiftwidth=2            "Use two spaces for auto-indent
set autoindent              "Auto indent based on previous line
let php_htmlInStrings = 1   "Syntax highlight for HTML inside PHP strings
let php_parent_error_open = 1 "Display error for unmatch brackets

"Enable syntax highlighting
if &t_Co > 1
  syntax enable
endif

"When in split screen, map <C-LeftArrow> and <C-RightArrow> to switch panes.
nn [5C <C-W>w
nn [5R <C-W>W

"Set filetype for Drupal PHP files.
if has("autocmd")
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.php set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
    autocmd BufRead,BufNewFile *.theme set filetype=php
  augroup END
endif

"Custom key mapping
map <S-u> :redo<cr>
map <C-n> :tabn<cr>
map <C-p> :tabp<cr>

"Custom SVN blame
vmap gl :<C-U>!svn blame <C-R>=expand("%:P") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
 au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
 \| exe "normal! g'\"" | endif
endif

" Highlight long comments and trailing whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red
let a = matchadd('ExtraWhitespace', '\s\+$')
highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
let b = matchadd('OverLength', '\(^\(\s\)\{-}\(*\|//\|/\*\)\{1}\(.\)*\(\%81v\)\)\@<=\(.\)\{1,}$')

" Lookup the API docs for a drupal function under cursor.
nnoremap <Leader>da :execute "!open http://api.drupal.org/".shellescape(expand("<cword>"), 1)<CR>
" Lookup the API docs for a drush function under cursor.
nnoremap <Leader>dda :execute "!open http://api.drush.ws/api/function/".shellescape(expand("<cword>"), 1)<CR>
" Get the value of the drupal variable under cursor.
nnoremap <Leader>dv :execute "!drush vget ".shellescape(expand("<cword>"), 1)<CR>

colorscheme vividchalk
