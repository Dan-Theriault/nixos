{ config, pkgs, ... }:

let
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball url));
  waylandPkgs = pkgs.extend waylandOverlay;
  swaypkg = pkgs.sway;
  swayWrapped = pkgs.writeShellScriptBin "sway" ''
    set -o errexit
    if [ ! "$_SWAY_WRAPPER_ALREADY_EXECUTED" ]; then
      export _SWAY_WRAPPER_ALREADY_EXECUTED=1
      # export XDG_SESSION_TYPE=wayland
      export CLUTTER_BACKEND=wayland
      # export SDL_VIDEODRIVER=wayland
      export GDK_BACKEND=wayland
      export QT_QPA_PLATFORM=wayland-egl
      export QT_QPA_PLATFORMTHEME=qt5ct
      export QT_WAYLAND_FORCE_DPI=physical
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    fi
    if [ "$DBUS_SESSION_BUS_ADDRESS" ]; then
      export DBUS_SESSION_BUS_ADDRESS
      exec ${swaypkg}/bin/sway -c /etc/sway-config "$@"
    else
      exec ${pkgs.dbus}/bin/dbus-run-session ${swaypkg}/bin/sway -c /etc/sway-config "$@"
    fi
  '';
  swayJoined = pkgs.symlinkJoin {
    name = "sway-joined";
    paths = [ swayWrapped swaypkg ];
  };
in
{
  programs.sway.enable = true;

  environment.systemPackages = with waylandPkgs; [
    grim
    mako
    slurp
    swayidle
    swaylock
    waybar
    wf-recorder
    wl-clipboard
    xwayland
    cage
  ] ++ [ swayJoined ];

  environment.etc."sway-config".text = import ../dots/sway.nix { inherit config; pkgs = waylandPkgs; };

  hardware.opengl.enable = true;
}
