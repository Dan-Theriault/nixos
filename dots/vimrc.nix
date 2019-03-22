{config, pkgs}:

let
  theme = import ../theme.nix;
in
''
set shell=${pkgs.bash}/bin/bash
filetype plugin indent on    " required

syntax on
set background=dark

" Load commands / settings by filetype
if has("autocmd")
  filetype plugin indent on
endif

" set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set hlsearch
set backspace=indent,start
set autoindent
set ruler
set number
set relativenumber
set pastetoggle=<F11>
set shiftwidth=4
set softtabstop=4
set expandtab
set wildmenu
set lazyredraw
set backspace=2
set noshowmode
set spell spelllang=en
set nopaste

" Markdown settings
let g:markdown_fenced_languages = ['java', 'c', 'bash=sh', 'python']

" Visual Line movements
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Keep text selected when fixing indentation
vnoremap < <gv
vnoremap > >gv

" B goes to the start of the line
nnoremap B ^
" E goes to the end
nnoremap E $

let mapleader=","

" Always show statusline
set laststatus=2
set nomodeline

" Use 256 colours (Use this setting only if your terminal supports 256
" colours)
set t_Co=256

"vim-airline
let g:airline_powerline_fonts=1
let g:airline_left_sep=""
let g:airline_left_alt_sep = '|'
let g:airline_right_sep=""
let g:airline_righ_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1
let g:airline_section_x=""
let g:airline_section_y='%{strftime("%c")}'
let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'keymap', 'capslock', 'xkblayout', 'iminsert'])

"colorscheme
let base16colorspace=256
let g:airline_theme='base16_ocean'

hi LineNr ctermbg=None
hi Normal ctermbg=None
hi SignColumn ctermbg=None

hi BufTabLineCurrent cterm=italic ctermfg=15 ctermbg=242
hi BufTabLineActive cterm=italic ctermfg=15 ctermbg=242
hi BufTabLineHidden cterm=italic ctermfg=15 ctermbg=None
hi TabLineFill ctermbg=None cterm=None

hi SpellBad ctermbg=None

hi FoldColumn ctermbg=None
set foldcolumn=0

"Italics support
hi Comment cterm=italic
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

"swapfiles make me sad
set noswapfile
set nobackup

"ALE brews
let g:ale_fixers = {
\   'python': ['${pkgs.python3Packages.yapf}/bin/yapf'],
\}
let g:ale_linters = {
\   'python': ['flake8', '${pkgs.mypy}/bin/mypy'],
\   'vimwiki': ['${pkgs.proselint}/bin/proselint'],
\   'markdown': ['${pkgs.proselint}/bin/proselint'],
\   'latex': ['${pkgs.proselint}/bin/proselint','chktex','lacheck']
\}
let g:ale_fix_on_save = 1
let g:ale_python_flake8_options = '-m flake8 --max-line-length 100'
let usepython2=$USE_PYTHON2
if usepython2 == '1'
    let g:ale_python_flake8_executable = '${pkgs.python2}/bin/python2'
    let g:ale_python_flake8_options = '-m flake8 --max-line-length 100'
    let g:ale_python_mypy_options = '--py2'
endif

"deoplete
let g:deoplete#enable_at_startup = 1

"vimtex settings
let g:vimtex_view_method='${pkgs.zathura}/bin/zathura'
let g:vimtex_latexmk_progname = 'nvr' "wrapper for nvim 

"ack.vim settings
let g:ackprg = '${pkgs.ripgrep}/bin/rg --vimgrep'

"ctrlp settings
let g:ctrlp_user_command ='${pkgs.fd}/bin/fd --type file --color never "" %s'

"Use elm-vim and vimtex instead of polyglot
let g:polyglot_disabled = ['elm', 'latex', 'markdown']

"Start nerdtree if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"other nerdtree stuf
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-b> :TagbarToggle<CR>

"vim tabs
let g:buftabline_show = 1
let g:buftabline_numbers = 2
let g:buftabline_indicators = 'on'
let g:buftabline_separators = 'on'
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

let g:pandoc#syntax#conceal#urls=1
''
