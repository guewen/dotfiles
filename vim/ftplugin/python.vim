setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab

" add syspathes to path
" python << EOF
" import os
" import sys
" import vim
" for p in sys.path:
"     # Add each directory in sys.path, if it exists.
"     if os.path.isdir(p):
"         # Command 'set' needs backslash before each space.
"         vim.command(r"set path+=%s" % p.replace(" ", r"\ "))
" EOF

" add openerp paths to path
python << EOF
import os
import vim
cwd = os.getcwd()
dirname = os.path.split(cwd)[-1]
if dirname == 'src':
    for d in os.listdir('.'):
        if not os.path.isdir(d):
            continue
        path = os.path.join(cwd, d)
        if d == 'server':
            path = os.path.join(path, 'openerp')
            vim.command(r"set path+=%s" % path.replace(" ", r"\ "))
EOF

" Wrap at 72 chars for comments.
set formatoptions=cq textwidth=72 foldignore= wildignore+=*.py[co]

setlocal comments=:# commentstring=#\ %s
