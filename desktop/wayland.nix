{ config, pkgs, ... }:

let
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball url));
  waylandPkgs = pkgs.extend waylandOverlay;
in
{
  programs.sway = {
    enable = true;
    extraSessionCommands = ''
      # export XDG_SESSION_TYPE=wayland
      export CLUTTER_BACKEND=wayland
      export SDL_VIDEODRIVER=wayland
      export GDK_BACKEND=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_FORCE_DPI=physical
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export _JAVA_AWT_WM_NONPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
    extraPackages = with waylandPkgs; [
      cage
      grim
      mako
      qt5.qtwayland
      slurp
      swayidle
      swaylock
      waybar
      wdisplays
      wf-recorder
      wl-clipboard
      xwayland
      emacs-pgtk
    ];
  };

  environment.etc."sway/config".text = import ../dots/sway.nix { inherit config; pkgs = waylandPkgs; };

  # emacs service
  services.emacs = {
    enable = true;
    defaultEditor = true;
    package = waylandPkgs.emacs-pgtk;
  };

  hardware.opengl.enable = true;
}
