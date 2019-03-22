{ config, pkgs, ... }:

let
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball url));
  swaypkg = pkgs.sway;
  swayWrapped = pkgs.writeShellScriptBin "sway" ''
    set -o errexit
    if [ ! "$_SWAY_WRAPPER_ALREADY_EXECUTED" ]; then
      export _SWAY_WRAPPER_ALREADY_EXECUTED=1
      # export XDG_SESSION_TYPE=wayland
      export CLUTTER_BACKEND=wayland
      export SDL_VIDEODRIVER=wayland
      export GDK_BACKEND=wayland
      export QT_QPA_PLATFORM=wayland-egl
      export QT_QPA_PLATFORMTHEME=qt5ct
      export QT_WAYLAND_FORCE_DPI=physical
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    fi
    if [ "$DBUS_SESSION_BUS_ADDRESS" ]; then
      export DBUS_SESSION_BUS_ADDRESS
      exec sway-setcap "$@"
    else
      exec ${pkgs.dbus}/bin/dbus-run-session sway-setcap -c /etc/sway-config "$@"
    fi
  '';
  swayJoined = pkgs.symlinkJoin {
    name = "sway-joined";
    paths = [ swayWrapped swaypkg ];
  };
in
{
  nixpkgs.overlays = [ waylandOverlay ];

  security.wrappers.sway = {
    program = "sway-setcap";
    source = "${swaypkg}/bin/sway";
    capabilities = "cap_sys_ptrace,cap_sys_tty_config=eip";
    owner = "root";
    group = "sway";
    permissions = "u+rx,g+rx";
  };

  environment.systemPackages = with pkgs; [
    swayJoined

    grim
    mako
    slurp
    swayidle
    swaylock
    waybar
    wf-recorder
    wl-clipboard
    xwayland
  ];

  environment.etc."sway-config".text = import ../dots/sway.nix { inherit config pkgs; };

  security.pam.services.swaylock = {};
  hardware.opengl.enable = true;
}
