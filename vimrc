" based on http://github.com/jferris/config_files/blob/master/vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" required for vundle
filetype off

" vundle : Vim plugin manager
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
" Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'msanders/snipmate.vim'
Bundle 'majutsushi/tagbar'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-cucumber'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
" Bundle 'Lokaltog/vim-powerline'
Bundle 'benmills/vimux'
Bundle 'actionshrimp/vim-xpath'
Bundle 'vim-scripts/argtextobj.vim'
Bundle 'kana/vim-textobj-user'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'sophacles/vim-bundle-mako'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'sjl/gundo.vim'
" Bundle 'davidhalter/jedi-vim'
Bundle 'vim-scripts/DrawIt'
" Bundle 'benzheren/vim-python'
Bundle 'klen/python-mode'

 " vim-scripts repos
" Bundle 'L9'
" Bundle 'pythoncomplete'

 " non github repos
 " Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on     " required!

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" Switch wrap off for everything
set nowrap

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text

  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC

  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType python highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd FileType python match OverLength /\%80v.*/

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

if has("folding")
  set foldenable
  set foldmethod=syntax
  set foldlevel=1
  set foldnestmax=3
  set foldcolumn=2
  set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '

  if has("autocmd")
    autocmd FileType c,cpp,d,perl,java,cs set foldmethod=syntax
    autocmd FileType python,xml set foldmethod=indent
  endif
endif

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = ","

" Hide search highlighting
map <Leader>h :set invhls <CR>
" bind C-l to :nohl in order to mute
" the highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-O> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" For rml
au! BufRead,BufNewFile *.rml set ft=xml

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Maps autocomplete to tab
imap <Tab> <C-N>

imap <C-L> <Space>=><Space>

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Use Ack instead of Grep when available
if executable("ack-grep")
  set grepprg=ack-grep\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif

" 256 colors
set t_Co=256

" Color scheme
set background=dark
colorscheme solarized
" highlight NonText guibg=#060606
" highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu,preview
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
set ignorecase
set smartcase

" Tags
set tags=./tags,tags

" Open URL
command -bar -nargs=1 OpenURL :!open <args>
function! OpenURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
	  exec "!open \"" . s:uri . "\""
  else
	  echo "No URI found in line."
  endif
endfunction
map <Leader>w :call OpenURL()<CR>

" allow to save as sudo with :w!!
cmap w!! %!sudo tee > /dev/null %

" no sound bell
set visualbell

" tabs for ruby
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 sts=2

" toggle display of unprintable chars
map<C-F12> <ESC>:set list!<CR>
" toggle auto wrap
map<F12> <ESC>:set wrap!<CR>

" keep selection when indent / unindent
vnoremap < <gv
vnoremap > >gv

" disable cross keys
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

" regenerate ctags
:nnoremap <f5> :!ctags -R<CR>

" ignore files
set wildignore+=*.po,*.pot,*.pyc

" & is used to replay a susbstitution but does not
" keep the flags. && keeps them, so rebind && to &
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>

" CommantT configuration
let g:CommandTMaxFiles=20000
let g:CommandTMatchWindowAtTop=1

" Stifle many interruptive prompts
set shortmess=atI

" toggle tagbar
nmap <F8> :TagbarToggle<CR>

" display fancy symbols in status bar with vim-powerline
" let g:Powerline_symbols = 'fancy'
" Powerline colorscheme optimized for Solarized
" let g:Powerline_colorscheme = 'skwp'

" add a segment in Powerline status bar which display a marker
" when current buffer has trailing whitespaces
" call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')
"
" disable syntastic because checkers are already in python-mode
let g:loaded_python_syntax_checker = 1
" Syntax checker for python (flake8, pyflakes, pylint)
"let g:syntastic_python_checker = 'pylint'
let g:syntastic_python_checker = ''


" hidden files in Netrw
let g:netrw_list_hide= '.*\.pyc$'


" ctrlp options
let g:ctrlp_extensions = ['tag', 'buffertag', 'mixed']
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_max_height = 20
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 0

" display gundo graph
nnoremap <F6> :GundoToggle<CR>
" the preview is below the current window
let g:gundo_preview_bottom = 1

" save a vim session
:nnoremap <F8> :wa<Bar>exe "mksession! " . v:this_session<CR>

" highlight the current line when the current mode is Insert
autocmd InsertEnter,InsertLeave * set cul!

" python-mode
let g:pymode_lint_checker = "pylint,pep8,mccabe"

" Autoremove unused whitespaces
let g:pymode_utils_whitespaces = 0

" Auto open cwindow if errors be finded
let g:pymode_lint_cwindow = 0
