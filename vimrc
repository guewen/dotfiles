" based on http://github.com/jferris/config_files/blob/master/vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


" Vundle {{{

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
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-cucumber'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
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
Bundle 'sjl/gundo.vim'
Bundle 'vim-scripts/DrawIt'
" Editing CSV
Bundle 'chrisbra/csv.vim'
" Airline, instead of powerline
Bundle 'bling/vim-airline'
" tags for javascript: https://github.com/majutsushi/tagbar/wiki#javascript
Bundle 'marijnh/tern_for_vim'
" autocomplete
Bundle 'Valloric/YouCompleteMe'
" snippets (compatible with YouCompleteMe)
Bundle 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" Python Color Syntax
Plugin 'hdima/python-syntax'
" Syntax checker on the fly (complement Syntastic/Flake8)
Plugin 'mitechie/pyflakes-pathogen'
" open a selection in a split window
Plugin 'chrisbra/NrrwRgn'
" Rust
Bundle 'wting/rust.vim'

filetype plugin indent on     " required!

" }}}


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Uncomment below to disable 'swap files' (eg. .myfile.txt.swp) from being
" created
" set noswapfile

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

" autocmd {{{
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
  " Activate spell checking for text files
  autocmd FileType text,markdown,html,xhtml,eruby set spell

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " autocmd BufReadPost *
  "   \ if line("'\"") > 0 && line("'\"") <= line("$") |
  "   \   exe "normal g`\"" |
  "   \ endif
  "
  "   Commented out: take the habit to use '" when opening a file to reach
  "   the last position

  autocmd FileType python set colorcolumn=80
  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
" }}}

" Folding {{{
if has("folding")
  set foldenable            " enable folding
  set foldmethod=indent     " fold based on indent level
  set foldlevelstart=10     " open most folds by default
  set foldnestmax=10        " 10 nested fold max
  set foldcolumn=0
  " space open/closes folds
  nnoremap <space> za
  set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '

  if has("autocmd")
    autocmd FileType c,cpp,d,perl,java,cs set foldmethod=syntax
    autocmd FileType python,xml set foldmethod=indent
  endif
endif
" }}}

" Tabs {{{
" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
" }}}

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

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

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

" keep selection when indent / unindent
vnoremap < <gv
vnoremap > >gv

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


" Syntastic {{{ 
" Syntax checker for python (flake8, pyflakes, pylint)
let g:syntastic_python_checkers = ['python', 'flake8', 'pylint']
" }}}


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

" the gundo preview is below the current window
let g:gundo_preview_bottom = 1

" F keys shortcuts {{{

" No Help, please
nmap <F1> <Esc>

" activate spellchecks
map <silent> <F3> "<Esc>:silent setlocal spell! spelllang=en<CR>"
map <silent> <F4> "<Esc>:silent setlocal spell! spelllang=fr<CR>"

" regenerate ctags
:nnoremap <F5> :!ctags -R<CR>

" display gundo graph
nnoremap <F6> :GundoToggle<CR>

" save a vim session
:nnoremap <F8> :wa<Bar>exe "mksession! " . v:this_session<CR>

" toggle tagbar
nmap <F9> :TagbarToggle<CR>

" toggle display of unprintable chars
map<C-F12> <ESC>:set list!<CR>
" toggle auto wrap
map<F12> <ESC>:set wrap!<CR>

" }}}

" highlight the current line when the current mode is Insert
autocmd InsertEnter,InsertLeave * set cul!

" python-mode {{{
let g:pymode_lint_checker = "pylint,pep8,mccabe,pep257"

" Autoremove unused whitespaces
let g:pymode_trim_whitespaces = 0

" Auto open cwindow if errors be finded
let g:pymode_lint_cwindow = 0

let g:pymode_lint_on_fly = 1

" }}}

" shortcut to delete in the black hole register
nnoremap <leader>d "_d
vnoremap <leader>d "_d
" shortcut to paste but keeping the current register
vnoremap <leader>p "_dP

" allow :W for :write
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

" Undo {{{

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" }}}


" Tmux {{{
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

" Misc {{{
set modelines=1  " interpret the modelines at the bottom of the files
" }}}

" Airline {{{
let g:airline_powerline_fonts = 1 " use the powerline symbols in airline
" }}}


" YouCompleteMe {{{
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:UltiSnipsExpandTrigger       ="<c-tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Enable tabbing through list of results
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

" Expand snippet or return
let g:ulti_expand_res = 0
function! Ulti_ExpandOrEnter()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res
        return ''
    else
        return "\<return>"
endfunction

" Set <space> as primary trigger
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>
" }}}

" use 'translate-shell' to show google translations (with shift-k)
set keywordprg=trans\ :en

" vim:foldmethod=marker:foldlevel=0
