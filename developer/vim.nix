{ config, lib, pkgs, ... }:

let 

  customPlugins = {
    # nvim-yarp = pkgs.vimUtils.buildVimPlugin {
    #   name = "nvim-yarp";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "roxma";
    #     repo = "nvim-yarp";
    #     rev = "b222af8dbbfb35c6d833fd76a940f6ca2fe322fa";
    #     sha256 = "0rialn5xmyd3n02j81cflvljrx2lld2mhggni66frrjdz5c45xkl";
    #   };
    # };
    # vim-hug-neovim-rpc = pkgs.vimUtils.buildVimPlugin {
    #   name = "vim-hug-neovim-rpc";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "roxma";
    #     repo = "vim-hug-neovim-rpc";
    #     rev = "60093847f0ba0a57ace54df30bd17a8239a99d6f";
    #     sha256 = "0rim73si32z1h9rh0i2qs5gy010cpb6mz1zxr197agf85zdq7x0f";
    #   };
    # };
    vim-buftabline = pkgs.vimUtils.buildVimPlugin {
      name = "vim-buftabline";
      src = pkgs.fetchFromGitHub {
        owner = "ap";
        repo = "vim-buftabline";
        rev = "12f29d2cb11d79c6ef1140a0af527e9231c98f69";
        sha256 = "1m2pwjagpbwalrckbyj2w5llqv6nzdkc5nfblwvj5fwkdiy8lmsn";
      };
    };
    nerdtree = pkgs.vimUtils.buildVimPlugin {
      name = "nerdtree";
      src = pkgs.fetchFromGitHub {
        owner = "scrooloose";
        repo = "nerdtree";
        rev = "5.0.0";
        sha256 = "1dpfzbz02a47g84j5nxhb0qahpzg1fwnm4qyabjni2faz73v7ddk";
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
  };

  # inputFilter = builtins.filter ( x: x != pkgs.python2 );
  # flagsFilter = builtins.filter ( x: x != "--disable-perlinterp" && x != "--enable-pythoninterp" );

  # vim-python = pkgs.python3.buildEnv.override rec {
  #   extraLibs = (with pkgs.python3Packages; [
  #     neovim
  #   ]);
  # };

  vim-configuration = {
    customRC = builtins.readFile /etc/nixos/dots/vimrc;
    vam.knownPlugins = pkgs.vimPlugins // customPlugins;
    vam.pluginDictionaries = [ {
      names = [
        "ack-vim"
        "airline"
        "ale"
        "calendar"
        "commentary"
        "ctrlp"
        "deoplete-nvim"
        "deoplete-jedi"
        "deoplete-rust"
        "elm-vim"
        "goyo"
        "polyglot"
        "surround"
        "Tabular"
        "tagbar"
        "vim-airline-themes"
        "vim-colorschemes"
        "vim-signify"
        "vimtex"
        "vimwiki"

        # Custom Packages
        # "nvim-yarp" "vim-hug-neovim-rpc"
        "vim-buftabline"
        "nerdtree"
        "vim-lastplace"
      ];
    } ];
  };

in

  { 
    environment.systemPackages = [ 
      # ( pkgs.vim.customize  { name = "cvim"; vimrcConfig = vim-configuration; } )
      ( pkgs.neovim.override { configure = vim-configuration; } )
    ]; 

    programs.fish.shellAliases.vim = "nvim";
    
    # nixpkgs.config.packageOverrides = pkgs: {
    #   vim = pkgs.vimUtils.makeCustomizable ( pkgs.vim_configurable.overrideAttrs (oldAttrs: {
    #     configureFlags = ( 
    #       ( builtins.filter ( x: x != "--disable-perlinterp" && x != "--enable-pythoninterp" ) oldAttrs.configureFlags ) 
    #       ++ [ "--enable-perlinterp" "--enable-python3interp" ]
    #     );
    #     nativeBuildInputs = oldAttrs.nativeBuildInputs ++ ( [ pkgs.perl vim-python ]);
    #     perlSupport = true;
    #   } ) );
    # };
  }
