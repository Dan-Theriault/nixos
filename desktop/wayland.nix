{ config, pkgs, inputs, system, ... }:

let 
  waylandPkgs = pkgs.extend inputs.nixpkgs-wayland.overlay;
  emacsPkgs = pkgs.extend inputs.emacs-overlay.overlay;
in
{
  programs.sway = {
    enable = true;
    extraSessionCommands = ''
      export XDG_SESSION_TYPE=wayland
      export CLUTTER_BACKEND=wayland
      export SDL_VIDEODRIVER=wayland
      export GDK_BACKEND=wayland
      export QT_QPA_PLATFORM=wayland
      # export QT_WAYLAND_FORCE_DPI=physical
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export _JAVA_AWT_WM_NONPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
      export MOZ_USE_XINPUT2=1
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
    ];
  };

  environment.etc."sway/config".text = import ../dots/sway.nix { 
    inherit config;
    pkgs = waylandPkgs;
  };

  # emacs service
  services.emacs = {
    enable = true;
    defaultEditor = true;
    package = emacsPkgs.emacsPgtkGcc;
  };

  services.pipewire.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    # gtkUsePortal = true; # causes issues with hidpi
  };
  hardware.opengl.enable = true;
}
