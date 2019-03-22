{ config, lib, pkgs, ... }:

let 
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
  };

  vim-configuration = {
    customRC = import ../dots/vimrc.nix {inherit config pkgs;};
    vam.knownPlugins = pkgs.vimPlugins // customPlugins;
    vam.pluginDictionaries = [ {
      names = [
        "ack-vim"
        "airline"
        "ale"
        "commentary"
        "ctrlp"
        "polyglot"
        "surround"
        "vim-airline-themes"
        "vim-colorschemes"
        "vim-nix"
        "vim-signify"
        "vim-markdown"

        # Custom Packages
        "vim-buftabline"
        "vim-lastplace"
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
