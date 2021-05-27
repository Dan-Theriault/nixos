{ pkgs, inputs, system, ... }:

rec {
  programs.home-manager.enable = true;

  home.username = "dan";
  home.homeDirectory = "/home/dan";

  # TODO: neovim
  # TODO: nix-doom-emacs
  # TODO: user-packages ?
  # TODO: sway, waybar, wofi ?
  # TODO: fish
  # TODO: SSH

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

  home.stateVersion = "21.05";
}
