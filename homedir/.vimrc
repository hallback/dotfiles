if has("autocmd")
    filetype plugin indent on
    autocmd Filetype perl setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
    autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
    autocmd Filetype yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    autocmd Filetype sh setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
endif

set cursorline
set cursorcolumn
hi CursorLine   cterm=NONE ctermbg=darkgrey guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkgrey guibg=darkred guifg=white
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" --------------------------------------------------------------------------------
" configure editor with tabs and nice stuff...
"
" --------------------------------------------------------------------------------
set expandtab           " enter spaces when tab is pressed
set textwidth=80       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line

" make backspaces more powerfull
set backspace=indent,eol,start

set ruler               " show line and column number
syntax on               " syntax highlighting
set showcmd             " show (partial) command in status line
" Disable line wrapping
set wrap!
set formatoptions-=t
