" ============================================================================
" Init
" ============================================================================


let g:vim_data_home = $XDG_DATA_HOME . '/vim'
let g:vim_config_home = $XDG_CONFIG_HOME . '/vim'

" Make sure vim uses a compatible shell
if has("win32")
    set shell=powershell.exe
    set shellcmdflag=-Command
elseif &shell =~# 'fish$'
    set shell=/bin/zsh
endif


" ============================================================================
" Python Integration
" ============================================================================


if has("win32")
    let g:python3_hostdir = g:vim_data_home . '/pyvenv35'
    let g:python3_host_prog = g:python3_hostdir . '/Scripts/python.exe'
else
    let g:python3_hostdir = g:vim_data_home . '/pyvenv3'
    let g:python3_host_prog = g:python3_hostdir . '/bin/python3'
    " let g:python_host_prog = 'python2.7'
endif


" ============================================================================
" Plugins (vim-plug)
" ============================================================================


call plug#begin()


" --------------------
" vim-commentary
" --------------------
Plug 'tpope/vim-commentary'
xmap <Leader>x <Plug>Commentary
nmap <Leader>X <Plug>Commentary
omap <Leader>x <Plug>Commentary
nmap <Leader>x <Plug>CommentaryLine


" " --------------------
" " deoplete
" " --------------------
" function! DoRemote(arg)
"     UpdateRemotePlugins
" endfunction
" Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_smart_case = 1


" " --------------------
" " deoplete-jedi
" " --------------------
" Plug 'zchee/deoplete-jedi'
" if exists(':DeopleteEnable')
"     let g:jedi#completions_enabled = 0
"     let g:jedi#auto_vim_configuration = 0
"     let g:jedi#smart_auto_mappings = 0
"     let g:jedi#show_call_signatures = 0
" endif


" --------------------
" jedi
" --------------------
Plug 'davidhalter/jedi-vim'
let g:jedi#force_py_version = 3
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#smart_auto_mappings = 0
" let g:jedi#show_call_signatures = 0


" --------------------
" neomake
" --------------------
Plug 'benekastah/neomake'
nmap <Leader>j :Neomake<CR>
let g:neomake_open_list = 1
let g:neomake_list_height = 4


" --------------------
" gutentags
" --------------------
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_enabled = 0


" --------------------
" tagbar
" --------------------
Plug 'majutsushi/tagbar'
nnoremap <F8> :TagbarToggle<CR>
inoremap <F8> <C-c>:TagbarToggle<CR>a


" --------------------
" UltiSnips
" --------------------
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'


" --------------------
" vim-template
" --------------------
Plug 'aperezdc/vim-template'
let g:templates_directory = g:vim_config_home . '/template'
let g:templates_user_variables = [
    \   ['FULLPATH', 'Template_GetFullPath'],
    \   ['PRETTYDATE', 'Template_PrettyDate'],
    \ ]

function! Template_GetFullPath()
    return expand('%:p')
endfunction

function! Template_PrettyDate()
    return strftime('%a %b %d, %Y')
endfunction


" --------------------
" FZF
" --------------------
Plug 'junegunn/fzf', { 'dir': g:vim_data_home . '/fzf',
            \ 'do': './install --completion --key-bindings --no-update-rc' }
Plug 'junegunn/fzf.vim'
nnoremap <F3> :FZF<CR>
vnoremap <F3> <Esc>:FZF<CR>


" --------------------
" Denite
" --------------------
Plug 'Shougo/denite.nvim'
" C-@ is Control-Space
nnoremap <C-@> :Denite -mode=normal -cursor-wrap=true buffer<CR>
vnoremap <C-@> <Esc>:Denite -mode=normal -cursor-wrap=true buffer<CR>

nnoremap <Leader>` :Denite -mode=normal -cursor-wrap=true outline<CR>
vnoremap <Leader>` <Esc>:Denite -mode=normal -cursor-wrap=true outline<CR>

" " Fuzzy file search
" " nnoremap <F3> :Denite -direction=botright file_rec<CR>
" " vnoremap <F3> <Esc>:Denite -direction=botright file_rec<CR>


" --------------------
" Ack
" --------------------
Plug 'mileszs/ack.vim'
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif


" --------------------
" Better whitespace
" --------------------
Plug 'ntpeters/vim-better-whitespace'
augroup betterwhitespace
    autocmd!

    " Always strip whitespace from all files
    autocmd BufWritePre * StripWhitespace
augroup END


" --------------------
" delimitMate
" --------------------
Plug 'Raimondi/delimitMate'
let g:delimitMate_autoclose = 0


" --------------------
" braceless
" --------------------
Plug 'tweekmonster/braceless.vim'


" --------------------
" vim-isort
" --------------------
" This sorts python imports
Plug 'arielmakestuff/vim-isort', { 'branch': 'develop' }


" --------------------
" Rust
" --------------------
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
let g:racer_cmd = 'racer'


" --------------------
" Scratch
" --------------------
Plug 'mtth/scratch.vim'
nnoremap <F4> :Scratch<CR>
vnoremap <F4> :ScratchSelection<CR>
inoremap <F4> <Esc>:Scratch<CR>i


" --------------------
"  Undotree
" --------------------
Plug 'mbbill/undotree'
nnoremap <F9> :UndotreeToggle<CR>
vnoremap <F9> <ESC>:UndotreeToggle<CR>
inoremap <F9> <ESC>:UndotreeToggle<CR>


" --------------------
" Airline
" --------------------
Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Enable list of buffers
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1

" Show just filename
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_theme='badwolf'
let g:airline_theme='oceanicnext'


" --------------------
" Others
" --------------------
Plug 'honza/vim-snippets'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'Lokaltog/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'mhartington/oceanic-next'
Plug 'marcopaganini/termschool-vim-theme'
Plug 'edkolev/tmuxline.vim'
Plug 'pgdouyon/vim-evanesco'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-vinegar'


" " ------------------------
" " custom neoterm (tox lib)
" " ------------------------
" Plug 'arielmakestuff/neoterm', { 'branch': 'develop' }

" " Neoterm keybindings
" nnoremap <Leader>T :call neoterm#toggle()<CR>
" nnoremap <Leader>a :call neoterm#test#run('file')<CR>
" nnoremap <Leader>A :call neoterm#test#run('all')<CR>
" let g:neoterm_size = '10'
" " let g:neoterm_keep_term_open = 0


call plug#end()

" ============================================================================
" Plugin initialization
" ============================================================================


" Denite
if executable('ag')
    call denite#custom#var('file_rec', 'command',
                \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif


" ============================================================================
" Default settings
" ============================================================================


set encoding=utf-8
filetype on
filetype plugin on
filetype plugin indent on
syntax enable
highlight normal guibg=black
highlight normal guifg=grey90
set hidden
set showtabline=0
set autochdir
set nobackup
set softtabstop=3
set shiftwidth=4
set noexpandtab
set formatoptions+=n
set wrap
set hlsearch
set textwidth=78
set wrapmargin=2
set background=dark
set foldcolumn=0
set wildmenu
set wildmode=list:full
set laststatus=2
set ttimeoutlen=0
set clipboard=unnamed
set showmatch

" spell check
set nospell
set spelllang=en_ca
let &spellfile = g:vim_config_home . '/spellfile.utf-8.add'

" Completion options
set completeopt=menu,noinsert,noselect

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent       " always set autoindenting on
set ruler            " show the cursor position all the time
set showcmd          " display incomplete commands
set incsearch        " do incremental searching


" ============================================================================
" Look & Feel
" ============================================================================


" Enable true colour
set termguicolors

let &guioptions = 'aegit'

" Popup menu size
set pumheight=6

" Theme
" Note: theme customizations are found in after/plugin/colors.vim
colorscheme OceanicNext

" colorscheme zenburn
" colorscheme gruvbox
" colorscheme termschool
" set background=dark


" ============================================================================
" Functions
" ============================================================================


function ModeChange()
    if getline(1) =~? '^#!'
        if getline(1) =~# '/bin/'
            silent !chmod a+x <afile>
        endif
    endif
endfunction


" ============================================================================
" Auto Commands
" ============================================================================


" --------------------
" Python
" --------------------
augroup filetype_python
    autocmd!
    autocmd BufRead,BufNewFile *.py
        \ source $XDG_CONFIG_HOME/vim/filetype/python.vim
    autocmd FileType python set omnifunc=python3complete#Complete
    autocmd FileType python let g:python_highlight_numbers=1
    autocmd FileType python let g:python_highlight_exceptions=1
    autocmd FileType python let g:python_highlight_space_errors=1

    " delimitMate options
    autocmd FileType python let g:delimitMate_autoclose=1 |
        \ let b:delimitMate_nesting_quotes = ["\"","'"]

    " braceless
    autocmd FileType python BracelessEnable

    " Isort
    " autocmd BufWritePre *.py Isort

    " Neomake
    autocmd BufWritePost *.py Neomake
augroup END


" --------------------
" Rust
" --------------------
augroup filetype_rust
    autocmd!
    autocmd BufRead,BufNewFile *.rs
        \ source $XDG_CONFIG_HOME/vim/filetype/rust.vim

    " Neomake
    autocmd BufWritePost *.rs Neomake
augroup END


" --------------------
" VimScript
" --------------------
augroup filetype_vim
    autocmd!
    autocmd BufRead,BufNewFile *.vim
        \ source $XDG_CONFIG_HOME/vim/filetype/vim.vim

    " delimitMate
    autocmd FileType vim let g:delimitMate_autoclose=1

    autocmd BufWritePost *.vim Neomake
augroup END


" --------------------
" Misc
" --------------------
augroup filetype_all
    autocmd!

    " Change script mode
    autocmd BufWritePost * call ModeChange()

    " File updated warning
    autocmd FileChangedShell *
        \ echohl WarningMsg |
        \ echo "File has been changed outside of nvim." |
        \ echohl None
augroup END


" ============================================================================
" Keybindings
" ============================================================================


" Key bindings for buffer next/prev
nnoremap <M-l> :bn<CR>
nnoremap <M-h> :bp<CR>

" Wipe buffer
" nmap <Leader>w :bwipeout<CR>

" Delete buffer
nnoremap <Leader>w :bdelete<CR>

" Toggle hidden characters
nnoremap <Leader>h :set invlist<cr>

" Clear hlsearch
nnoremap <Leader>/ :noh<CR>

" List buffers
nnoremap <Leader>l :ls<CR>
nnoremap <Leader><S-l> :ls!<CR>

" Spell check
nnoremap <Leader>s :set spell<CR>
nnoremap <Leader>S :set nospell<CR>

" Generic make
" :command! -nargs=* Make make <args> | cwindow 3
" nmap <Leader>j :Make<CR><C-w><Up>

" Open previous buffer. If the buffer is closed, will re-open it
nnoremap <S-Tab> <C-^>

" Open netrw explore
nnoremap <F2> :Texplore<CR>
vnoremap <F2> <Esc>:Texplore<CR>
inoremap <F2> <Esc>:Texplore<CR>

" Insert timestamp
nnoremap <F5> "=strftime("%c")<CR>P<Esc>
inoremap <F5> <C-R>=strftime("%c")<CR>
nnoremap <F6> "=strftime("%Y-%m-%d %H:%M:%S %Z")<CR>P<Esc>
inoremap <F6> <C-R>=strftime("%Y-%m-%d %H:%M:%S %Z")<CR>
nnoremap <F7> "=strftime("%Y.%m.%d.%H%M")<CR>P<Esc>
inoremap <F7> <C-R>=strftime("%Y.%m.%d.%H%M")<CR>


" ============================================================================
"
" ============================================================================
