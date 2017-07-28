{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    promptInit = builtins.readFile ./fish_prompt.fish;   
    
    shellAliases = {
      vim = "vim --servername vim";
    };
  };
}
