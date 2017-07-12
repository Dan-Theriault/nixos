{ config, pkgs, ... }:

let 
  vim = pkgs.vimUtils.makeCustomizable ( pkgs.vim_configurable.overrideAttrs (
    oldAttrs: {
      configureFlags = ( builtins.filter ( x: x != "--disable-perlinterp" ) 
        oldAttrs.configureFlags ) ++ [ "--enable-perlinterp" ];
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.perl ];
      perlSupport = true;
    }
  ) );
in {
  environment.systemPackages = [
    pkgs.git pkgs.wget

    ( vim.customize {
      name = "vim";

      vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
      vimrcConfig.vam.pluginDictionaries = [ {
        names = [
          "airline"
          "commentary"
          "ctrlp"
          "goyo"
          "polyglot"
          "syntastic"
          "vim-airline-themes"
          "vim-colorschemes"
          "vim-signify"
          "vimtex"
          "YouCompleteMe"
        ];
      } ];

      vimrcConfig.customRC = ''
        set shell=bash
        filetype plugin indent on    " required

        syntax on
        set background=dark

        " Load commands / settings by filetype
        if has("autocmd")
          filetype plugin indent on
        endif

        " The following are commented out as they cause vim to behave a lot
        " differently from regular Vi. They are highly recommended though.
        " set showcmd		" Show (partial) command in status line.
        set showmatch		" Show matching brackets.
        set ignorecase		" Do case insensitive matching
        set smartcase		" Do smart case matching
        set incsearch		" Incremental search
        set autowrite		" Automatically save before commands like :next and :make
        set hidden		" Hide buffers when they are abandoned
        set mouse=a		" Enable mouse usage (all modes)

        " PERSONAL CUSTOMIZATIONS
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

        " B goes to the start of the line
        nnoremap B ^
        " E goes to the end
        nnoremap E $
        " ?
        nnoremap gV '[v']
        let mapleader=","

        " Always show statusline
        set laststatus=2

        " Use 256 colours (Use this setting only if your terminal supports 256
        " colours)
        set t_Co=256
        set term=screen-256color
        set nomodeline

        "vim-airline
        let g:airline_powerline_fonts=1
        let g:airline_left_sep=""
        let g:airline_right_sep=""
        let g:airline_theme='base16_shell'

        "colorscheme
        let base16colorspace=256
        source /etc/nixos/colors.vim
        hi LineNr  ctermbg=None

        "swapfiles make me sad
        set noswapfile
        set nobackup

        "syntastic is sometimes stupid
        let g:syntastic_python_checkers=['flake8', 'python']
        " let g:syntastic_python_flake8_args='--ignore=E501'
        autocmd CompleteDone * pclose

        "vimtex settings
        let g:vimtex_view_method='zathura'

        "ack.vim settings
        " let g:ackprg = 'ag --vimgrep'

        "AUTOCMDS
        autocmd FileType nix :set softtabstop=2
      '';
    } 
  ) ];
}
