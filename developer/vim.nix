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
    vim-dim = pkgs.vimUtils.buildVimPlugin {
      name = "vim-dim";
      src = pkgs.fetchFromGitHub {
        owner = "jeffkreeftmeijer";
        repo = "vim-dim";
        rev = "00d1b3beacf22cf061b95261d7afbba461701826";
        sha256 = "13x3bx1dv8ivfvjlzaj7c8386ps93a2y7h56viai1xnqhbvjjvqy";
      };
    };
  };

  vim-configuration = {
    customRC = import ../dots/vimrc.nix {inherit config pkgs;};
    plug.plugins = with (pkgs.vimPlugins // customPlugins); [
      ack-vim
      airline
      ale
      commentary
      ctrlp
      polyglot
      surround
      vim-airline-themes
      vim-colorschemes
      vim-nix
      vim-signify
      vim-markdown

      # Custom Packages
      vim-buftabline
      vim-lastplace
      vim-dim
    ];
  };
  vim-env = pkgs.buildEnv {
    name = "vim-env";
    paths = with pkgs; [
      wl-clipboard
      (neovim.override { configure = vim-configuration; })
    ];
  };
in
  { 
    environment.systemPackages = [ vim-env ]; 
    programs.fish.shellAliases = {
      vim = "nvim";
      svim = "sudo nvim";
    };
  }
