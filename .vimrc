" Allow Vim-only settings even if they break vi keybindings.
set nocompatible

syntax on " syntax highting
filetype on " Enable filetype detection
filetype plugin indent on " enable loading indent file for filetypes


" Pathogen settings.
runtime bundle/vim-pathogen/autoload/pathogen.vim bundle\vim-pathogen\autoload\pathogen.vim

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
"call add(g:pathogen_disabled, 'ack')
"call add(g:pathogen_disabled, 'delimitMate')
"call add(g:pathogen_disabled, 'DirDiff')
"call add(g:pathogen_disabled, 'drupal_snippets')
"call add(g:pathogen_disabled, 'drupalvim')
"call add(g:pathogen_disabled, 'easymotion')
"call add(g:pathogen_disabled, 'fugitive')
"call add(g:pathogen_disabled, 'fuzzyfinder')
"call add(g:pathogen_disabled, 'git')
"call add(g:pathogen_disabled, 'gundo')
"call add(g:pathogen_disabled, 'L9')
"call add(g:pathogen_disabled, 'linediff')
"call add(g:pathogen_disabled, 'matchit')
"call add(g:pathogen_disabled, 'neocomplete')
"call add(g:pathogen_disabled, 'nerdcommenter')
"call add(g:pathogen_disabled, 'nerdtree')
call add(g:pathogen_disabled, 'PIV')
"call add(g:pathogen_disabled, 'snipmate')
"call add(g:pathogen_disabled, 'supertab')
"call add(g:pathogen_disabled, 'surround')
"call add(g:pathogen_disabled, 'syntastic')
"call add(g:pathogen_disabled, 'tabular')
"call add(g:pathogen_disabled, 'tagbar')
"call add(g:pathogen_disabled, 'tasklist')
"call add(g:pathogen_disabled, 'vim-colors-solarize')
"call add(g:pathogen_disabled, 'vim-pathogen')
"call add(g:pathogen_disabled, 'vividchalk')
"call add(g:pathogen_disabled, 'web-indent')
"call add(g:pathogen_disabled, 'xdebug')
"call add(g:pathogen_disabled, 'ZoomWin')
"call add(g:pathogen_disabled, 'z_overrides')

"Disable PIV when in windows.
if exists('$ComSpec')
  call add(g:pathogen_disabled, 'PIV')
endif

" Gundo requires at least vim 7.3
if v:version < '703' || !has('python')
  call add(g:pathogen_disabled, 'gundo')
  call add(g:pathogen_disabled, 'xdebug')
endif

if v:version < '702'
  call add(g:pathogen_disabled, 'autocomplpop')
  call add(g:pathogen_disabled, 'ZoomWin')
  call add(g:pathogen_disabled, 'fuzzyfinder')
  call add(g:pathogen_disabled, 'L9')
  call add(g:pathogen_disabled, 'syntastic')
  call add(g:pathogen_disabled, 'tagbar')
  call add(g:pathogen_disabled, 'tasklist')
endif

if !executable("ctags")
  call add(g:pathogen_disabled, 'tasklist')
  call add(g:pathogen_disabled, 'tagbar')
endif

if exists('$ComSpec')
  call add(g:pathogen_disabled, 'PIV')
endif

call pathogen#infect('~/.vim/bundle/drupalvim/bundle')
call pathogen#infect('~\vimfiles\bundle\drupalvim\bundle')
call pathogen#infect()

" Pathogen provides Helptags as a substitute to :helptags
" It automatically runs helptags on all our bundles.
Helptags

let g:SuperTabDefaultCompletionType = "context"
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
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


" Interactive shell loads my aliases.
" Not to be enabled on windows system.
if !exists('$ComSpec')
  set shellcmdflag=-ic
endif

"Drupal settings
set expandtab               "Tab key inserts spaces
set tabstop=2               "Use two spaces for tabs
set shiftwidth=2            "Use two spaces for auto-indent
set autoindent              "Auto indent based on previous line
let php_htmlInStrings = 1   "Syntax highlight for HTML inside PHP strings
let php_parent_error_open = 1 "Display error for unmatch brackets
let php_sql_query = 1 "for SQL syntax highlighting inside strings
let php_parent_error_close = 1 "for highlighting parent error ] or )
" let php_folding = 1 "for folding classes and functions
" let php_sync_method = 0
"                             x=-1 to sync by search ( default )
"                             x>0 to sync at least x lines backwards
"                             x=0 to sync from start


"Enable syntax highlighting
if &t_Co > 1
  syntax enable
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
map <leader>n :NERDTreeToggle<CR>
map <Leader>g :GundoToggle<CR>
map <Leader>a <Esc>:Ack! 
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>
map <Leader>t :TagbarToggle<CR>
map <Leader>tl <Plug>TaskList


set background=dark

if exists('$ConEmuArgs')
  colorscheme solarized
elseif exists('$ComSpec')
  colorscheme vividchalk 
elseif exists('$__vim_colorscheme')
  colorscheme $__vim_colorscheme
else
  colorscheme solarized
endif

if g:colors_name == 'solarized'
  set t_Co=256
endif



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


" Nerd Tree settings.
let g:NERDTreeDirArrows=0

" Neocomplcache settins.
" Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
let g:acp_enableAtStartup = 0
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder 
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define file-type dependent dictionaries.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion. Not required if they are already set elsewhere in .vimrc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion, which require computational power and may stall the vim. 
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
