{ pkgs, inputs, system, ... }:

let
  theme = import ./theme.nix;
in
rec {
  programs.home-manager.enable = true;
  # nixpkgs.config = {};

  home.username = "dan";
  home.homeDirectory = "/home/dan";
  home.stateVersion = "21.05";
  home.keyboard = null; # disable home-manager keyboard config
  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs = {
    nix-index.enable = true;
  };

  # TODO: neovim
  # TODO: nix-doom-emacs
  # TODO: user-packages ?
  # TODO: waybar, wofi ?
  # TODO: SSH

  # dconf.settings = {};

  # gtk = {
  #   enable = true;
  #   # font = {
  #   #   package = null;
  #   #   name = null;
  #   # };
  #   theme = {
  #     package = pkgs.arc-theme;
  #     name = "arc";
  #   };
  #   iconTheme = {
  #     package = pkgs.moka-icon-theme;
  #     name = "moka";
  #   };
  # };

  programs.git = {
    enable = true;
    userName = "Dan Theriault";
    userEmail = "dan@theriault.codes";
    # TODO
    aliases = { };
    ignores = [];
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = "true";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";

      # Adds this many blank pixels of padding around the window
      # Units are physical pixels; this is not DPI aware.
      # (change requires restart)
      window.padding = {
        x = 10;
        y = 10;
      };
      window.dynamic_padding = false;

      # The FreeType rasterizer needs to know the device DPI for best results
      # (changes require restart)
      dpi = {
        x = 192.0;
        y = 192.0;
      };

      # When true, bold text is drawn using the bright variant of colors.
      draw_bold_text_with_bright_colors = true;

      # Font configuration (changes require restart)
      font = {
        normal.family = "monospace";
        bold.family = "monospace";
        italic.family = "monospace";
        size = 10.0;
        # Offset is the extra space around each character. offset.y can be thought of
        # as modifying the linespacing, and offset.x as modifying the letter spacing.
        offset = {
          x = 0;
          y = 1;
        };
        # Glyph offset determines the locations of the glyphs within their cells with
        # the default being at the bottom. Increase the x offset to move the glyph to
        # the right, increase the y offset to move the glyph upward.
        glyph_offset = {
          x = 0;
          y = 0;
        };
      };

      colors = {
        primary = {
          background = theme.background;
          foreground = theme.foreground;
        };
        normal = {
          black =   theme.black1;
          red =     theme.red1;
          green =   theme.green1;
          yellow =  theme.yellow1;
          blue =    theme.blue1;
          magenta = theme.magenta1;
          cyan =    theme.cyan1;
          white =   theme.white1;
        };
        bright = {
          black =   theme.black2;
          red =     theme.red2;
          green =   theme.green2;
          yellow =  theme.yellow2;
          blue =    theme.blue2;
          magenta = theme.magenta2;
          cyan =    theme.cyan2;
          white =   theme.white2;
        };
      };

      # To completely disable the visual bell, set its duration to 0.
      bell = {
        animation = "EaseOutExpo";
        duration = 0;
      };

      # Background opacity
      background_opacity = 1.0;

      key_bindings = [
        { key = "V"; mods = "Control|Shift"; action = "Paste"; }
        { key = "C"; mods = "Control|Shift"; action = "Copy"; }
      ];

      mouse_bindings = [
        { mouse = "Middle"; action = "PasteSelection"; }
      ];

      mouse = {
        double_click.threshold = 300;
        triple_click.threshold = 300;
      };

      selection.semantic_escape_chars = ",│`|:\"' ()[]{}<>";

      # Live config reload (changes require restart)
      live_config_reload = false;
    };
  };

  programs.fish = {
    enable = true;
    promptInit = builtins.readFile ./scripts/fish-prompt.fish;   
    shellAliases = {
      open = "xdg-open";
      doom = "~/.emacs.d/bin/doom";
      lyrics = "${pkgs.glyr}/bin/glyrc lyrics -a (playerctl metadata artist 2>/dev/null) -t (playerctl metadata title 2>/dev/null) -v 0 -w /tmp/lyrics; and cat /tmp/lyrics";
    };
    shellAbbrs = {
      ipy = "ipython3";
      lo2pdf = "libreoffice --writer --headless --convert-to pdf";
      sgit = "sudo -E git";
      svim = "sudo vim";
    };
    interactiveShellInit = ''
      function fish_user_key_bindings
        set -g fish_key_bindings fish_vi_key_bindings
        bind -M insert \ck kill-line
        bind -M insert \ca beginning-of-line
        bind -M insert \ce end-of-line
      end

      function fish_greeting
      end
    '';
  };

  programs.mako = {
    enable = true;
    layer = "overlay";
    anchor = "top-center";
    font = "sans-serif 12";
    backgroundColor = theme.background;
    textColor= theme.foreground;
    borderColor= theme.highlight1;
    borderSize = 2;
    width = 240;
    height = 100;
    icons = true;
    markup = true;
    actions = true;
    # history = true;
    # max-history = 20;
  };

  programs.neovim = let
    neoPkgs = pkgs.extend inputs.neovim-nightly-overlay.overlay;
  in {
    enable = true;
    package = neoPkgs.neovim-unwrapped;
    withNodeJs = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with neoPkgs.vimPlugins; [
      lush-nvim
      nvim-compe
      telescope-nvim
      # nvim-treesitter
      # nvim-lspconfig
      # nvim-metals
      # nvim-dap

      commentary
      editorconfig-vim
      lightline-bufferline
      lightline-vim
      vim-eunuch
      vim-lastplace
      vim-polyglot
      vim-signify

      (neoPkgs.vimUtils.buildVimPlugin {
        name = "vim-dim";
        src = inputs.vim-dim;
      })
    ];

    extraPackages = with neoPkgs; [
      fd ripgrep bat # for telescope
      # coursier # for metals
      # clangStdenv tree-sitter # for nvim-treesitter
      # rnix-lsp
      # sudo # for vim-eunuch
    ];

    # TODO: tre-sitter setup
    # TODO: LSP setup
    # TODO: DAP setup
    # TODO: telescope + LSP integration
    # TODO: telescope + git integration
    # TODO: telescope + tree-sitter integration
    extraConfig = ''
      set shell=${pkgs.bashInteractive}/bin/bash

      syntax on

      set t_Co=256
      set background=dark
      colorscheme dim

      let mapleader=","

      set hidden
      set showtabline=2

      let g:lightline = {
          \ 'tabline': {
          \   'left': [ [ 'buffers' ] ],
          \   'right': [ [ ] ]
          \ },
          \ 'component_expand': {
          \   'buffers': 'lightline#bufferline#buffers'
          \ },
          \ 'component_type': {
          \   'buffers': 'tabsel'
          \ }
          \ }
      let g:lightline#bufferline#show_number = 2

      nmap <Leader>1 <Plug>lightline#bufferline#go(1)
      nmap <Leader>2 <Plug>lightline#bufferline#go(2)
      nmap <Leader>3 <Plug>lightline#bufferline#go(3)
      nmap <Leader>4 <Plug>lightline#bufferline#go(4)
      nmap <Leader>5 <Plug>lightline#bufferline#go(5)
      nmap <Leader>6 <Plug>lightline#bufferline#go(6)
      nmap <Leader>7 <Plug>lightline#bufferline#go(7)
      nmap <Leader>8 <Plug>lightline#bufferline#go(8)
      nmap <Leader>9 <Plug>lightline#bufferline#go(9)
      nmap <Leader>0 <Plug>lightline#bufferline#go(10)

      "Italics support
      hi Comment cterm=italic
      let &t_ZH="\e[3m"
      let &t_ZR="\e[23m"

      set mouse=a		" Enable mouse usage (all modes)

      set autowrite		" Automatically save before commands like :next and :make
      set expandtab
      set foldcolumn=0
      set number
      set relativenumber 
      set shiftwidth=2
      set showmatch		" Show matching brackets.
      set softtabstop=4
      set spell spelllang=en
      set wildmenu

      " status line settings
      set laststatus=2
      set nomodeline
      set noshowmode
      set ruler
      set showcmd		" Show (partial) command in status line.

      "  search settings
      set ignorecase  " Do case insensitive matching
      set smartcase		" Do smart case matching

      "swapfiles make me sad
      set noswapfile
      set nobackup

      " Visual Line movements
      noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
      noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

      " Keep text selected when fixing indentation
      vnoremap < <gv
      vnoremap > >gv

      hi LineNr ctermbg=None
      hi Normal ctermbg=None
      hi SignColumn ctermbg=None
      hi SpellBad ctermbg=None
      hi FoldColumn ctermbg=None

      " extension settings

      set completeopt=menuone,noselect
      let g:compe = {}
      let g:compe.enabled = v:true
      let g:compe.autocomplete = v:true
      let g:compe.documentation = v:true
      let g:compe.source = {}
      let g:compe.source = {}
      let g:compe.source.path = v:true
      let g:compe.source.buffer = v:true
      "let g:compe.source.nvim_lsp = v:true
      inoremap <silent><expr> <C-Space> compe#complete()
      inoremap <silent><expr> <CR> compe#confirm('<CR>')
      inoremap <silent><expr> <C-e> compe#close('<C-e>')
      inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })
      inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })

      nnoremap <c-p> <cmd>Telescope find_files<cr>
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    '';
  };

  wayland.windowManager.sway = let
    terminal = "alacritty -e fish";
    wallpaper = "~/.wallpaper";
    lockMessage = "\"DO NOT DISTURB\"";
    waybarConfig = import ./dots/waybar.nix { inherit pkgs; };
    wofi = ''${pkgs.wofi}/bin/wofi -ib \
      -p "" \
      -s ${pkgs.writeText "wofi.css" (import ./dots/wofi.nix { inherit pkgs; })} \
    '';
  in {
    enable = true;
    package = pkgs.sway;
    extraSessionCommands = ''
      export XDG_SESSION_TYPE=wayland
      export CLUTTER_BACKEND=wayland
      export SDL_VIDEODRIVER=wayland
      export GDK_BACKEND=wayland
      export QT_QPA_PLATFORM=wayland
      # export QT_WAYLAND_FORCE_DPI=physical
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export _JAVA_AWT_WM_NONPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
      export MOZ_USE_XINPUT2=1
    '';
    wrapperFeatures = {
      gtk = true;
      xwayland = true;
    };
    config = {
      terminal = "alacritty -e fish";
      output."*".bg = "${wallpaper} fill";
      output."*".scale = "1";
      input."*" = {
        xkb_layout = "us";
        xkb_options = "compose:ralt,caps:escape";
      };
      bars = [];

      # ====== BINDINGS =======
      modifier = "Mod4";
      floating.modifier = wayland.windowManager.sway.config.modifier;

      keybindings = let
        mod = wayland.windowManager.sway.config.modifier;
      in pkgs.lib.mkOptionDefault {
        # start emacsclient
        "${mod}+Shift+Return" = "exec emacsclient -cne '(switch-to-buffer nil)'";
        # toggle scale
        "${mod}+shift+s" = "exec /etc/nixos/scripts/toggle-scale.sh";

        "${mod}+b" = "split horizontal";
        "${mod}+v" = "split vertical";

        # change container layout (stacked, tabbed, toggle split)
        "${mod}+s" = "layout stacking";
        "${mod}+t" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        # toggle tiling / floating
        "${mod}+Shift+space" = "floating toggle";

        # ======= HARDWARE KEY CONTROLS =======

        # # Audio controls
        # XF86AudioRaiseVolume exec amixer -q set Master 1%+
        # XF86AudioLowerVolume exec amixer -q set Master 1%-
        # XF86AudioMute exec amixer -q set Master toggle

        # Alt+XF86AudioRaiseVolume exec pactl set-sink-volume 0 +5%
        # Alt+XF86AudioLowerVolume exec pactl set-sink-volume 0 +5%
        # Alt+XF86AudioMute exec pactl set-sink-mute 0 toggle

        # # Screen brightness controls
        # XF86MonBrightnessUp exec ${pkgs.light}/bin/light -A 2 # increase screen brightness
        # XF86MonBrightnessDown exec ${pkgs.light}/bin/light -U 2 # decrease screen brightness

        # # Media player controls
        # XF86AudioPlay exec ${pkgs.playerctl}/bin/playerctl play-pause 2> /dev/null 
        # XF86AudioNext exec ${pkgs.playerctl}/bin/playerctl next 2> /dev/null 
        # XF86AudioPrev exec ${pkgs.playerctl}/bin/playerctl previous 2> /dev/null 

        # ====== ROFI ======
        "${mod}+space" = "exec ${wofi} --show run";
        "${mod}+Shift+d" = "exec ${wofi} --show drun";
        # "${mod}+w exec" = "rofi -show window"; # TODO: update for wayland
        "${mod}+Shift+x" = "exec loginctl lock-session";
      };

      # ======= AUTORUNS =======
      startup = [
        { command = "${pkgs.wmname}/bin/wmname LG3D"; }
        { command = "${pkgs.waybar}/bin/waybar -c ${waybarConfig.config} -s ${waybarConfig.style}"; }
        # { command = ''${pkgs.swayidle}/bin/swayidle -w \
        #   timeout 600 '/etc/nixos/scripts/lock.sh' \
        #   lock '/etc/nixos/scripts/lock.sh' \
        #   before-sleep 'swaymsg "output * dpms off"' \
        #   after-resume 'swaymsg "output * dpms on"' 
        # ''; }
      ];

      window.border = 2;
      floating.border = 7;

      gaps = {
        inner = 8;
        outer = 18;
        smartGaps = false;
        smartBorders = "off";
      };

      colors = let
        focus = theme.highlight1;
        unfocus = theme.border;
        urgent = theme.highlight2;
      in {
        focused = {
          background = focus;
          border = focus;
          childBorder = focus;
          indicator = focus;
          text = focus;
        };
        focusedInactive = {
          background = unfocus;
          border = unfocus;
          childBorder = unfocus;
          indicator = unfocus;
          text = unfocus;
        };
        unfocused = {
          background = unfocus;
          border = unfocus;
          childBorder = unfocus;
          indicator = unfocus;
          text = unfocus;
        };
        urgent = {
          background = urgent;
          border = urgent;
          childBorder = urgent;
          indicator = urgent;
          text = urgent;
        };
      };
    };
  };

  xresources.properties = {
      "Xft.dpi" = 192;
      "*.foreground" =   theme.foreground;
      "*.background" =   theme.background;
      "*.cursorColor" =  theme.foreground;

      # black
      "*.color0" =       theme.black1;
      "*.color8" =       theme.black2;

      # red
      "*.color1" =       theme.red1;
      "*.color9" =       theme.red2;

      # green
      "*.color2" =       theme.green1;
      "*.color10" =      theme.green2;

      # yellow
      "*.color3" =       theme.yellow1;
      "*.color11" =      theme.yellow2;

      # blue
      "*.color4" =       theme.blue1;
      "*.color12" =      theme.blue2;

      # magenta
      "*.color5" =       theme.magenta1;
      "*.color13" =      theme.magenta2;

      # cyan
      "*.color6" =       theme.cyan1;
      "*.color14" =      theme.cyan2;

      # white
      "*.color7" =       theme.white1;
      "*.color15" =      theme.white2;

  };
}
