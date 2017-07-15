{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    promptInit = builtins.readFile ( builtins.fetchurl { 
      url = "https://raw.githubusercontent.com/oh-my-fish/theme-robbyrussell/master/fish_prompt.fish";
    } );
    shellAliases = {
      vim = "vim --servername vim";
    };
  };
}
