{ config, lib, pkgs, ... }:
# At present, this module should NOT be used without also including developer/default.nix
# Several programs installed in that module (rg, fd, etc) are required.
# TODO: Identify all dependencies for this configuration, and move them here

let 

  tasklib = pkgs.python3Packages.buildPythonPackage rec {
    pname = "tasklib";
    version = "1.1.0";
    src = pkgs.fetchurl {
      url = "https://files.pythonhosted.org/packages/d4/2c/dac7e0557381b467113b4c6fb684a2daeb1bb902e3d7da39ea8e4eddf2c0/tasklib-1.1.0.tar.gz";
      sha256 = "dcc4755ec81d0238d669282b444d5d52c0424d340ac7d456af4d87f75d2d7153";
    };
    # preCheck = ''
    #   mkdir tasks
    # '';
    preConfigure = ''
      export LC_ALL="en_US.UTF-8"
    '';
    propagatedBuildInputs = with pkgs.python3Packages; [
      six pytz tzlocal taskw
    ] ++ [ pkgs.taskwarrior pkgs.glibcLocales ];
  };

  customPlugins = {
    vim-buftabline = pkgs.vimUtils.buildVimPlugin {
      name = "vim-buftabline";
      src = pkgs.fetchFromGitHub {
        owner = "ap";
        repo = "vim-buftabline";
        rev = "12f29d2cb11d79c6ef1140a0af527e9231c98f69";
        sha256 = "1m2pwjagpbwalrckbyj2w5llqv6nzdkc5nfblwvj5fwkdiy8lmsn";
      };
    };
    vim-lastplace = pkgs.vimUtils.buildVimPlugin {
      name = "vim-lastplace";
      src = pkgs.fetchFromGitHub {
        owner = "farmergreg";
        repo = "vim-lastplace";
        rev = "102b68348eff0d639ce88c5094dab0fdbe4f7c55";
        sha256 = "1d0mjjyissjvl80wgmn7z1gsjs3fhk0vnmx84l9q7g04ql4l9pja";
      };
    };
    vim-taskwiki = pkgs.vimUtils.buildVimPlugin {
      name = "vim-taskwiki";
      src = pkgs.fetchFromGitHub {
        owner = "tbabej";
        repo = "taskwiki";
        rev = "0c964460e6bbfba387b8a2976a3c349aa615e525";
        sha256 = "0hqb4lxdr6z52aygvlwyr37m6xvf28ipxx7hzmf3xsk5qhsvq96n";
      };
      python3Dependencies = [ tasklib ];
    };
    latex-unicoder = pkgs.vimUtils.buildVimPlugin {
      name = "latex-unicoder";
      src = pkgs.fetchFromGitHub {
        owner = "joom";
        repo = "latex-unicoder.vim";
        rev = "46c1ccaec312e4d556c45c71b4de8025ff288f48";
        sha256 = "03a16ysy7fy8if6kwkgf2w4ja97bqmg3yk7h1jlssz37b385hl2d";
      };
    };
  };

  vim-configuration = {
    customRC = builtins.readFile ../dots/vimrc;
    vam.knownPlugins = pkgs.vimPlugins // customPlugins;
    vam.pluginDictionaries = [ {
      names = [
        "Tabular"
        "ack-vim"
        "airline"
        "ale"
        "calendar"
        "commentary"
        "ctrlp"
        "deoplete-jedi"
        "deoplete-nvim"
        "deoplete-rust"
        "elm-vim"
        "goyo"
        "nerdtree"
        "polyglot"
        "surround"
        "tagbar"
        "vim-airline-themes"
        "vim-colorschemes"
        "vim-nix"
        "vim-pandoc"
        "vim-pandoc-syntax"
        "vim-signify"
        "vimtex"
        "vimwiki"
        # "vim-markdown"

        # Custom Packages
        "latex-unicoder"
        "vim-buftabline"
        "vim-lastplace"
        "vim-taskwiki"
      ];
    } ];
  };
in
  { 
    environment.systemPackages = [ 
      ( pkgs.neovim.override { configure = vim-configuration; } )
    ]; 
    programs.fish.shellAliases = {
      vim = "nvim";
      svim = "sudo nvim";
    };
  }
