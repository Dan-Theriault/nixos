{ config, pkgs, ... }:

{
  services.cage = {
    enable = false;
    # TODO: workaround the wayland bug
    # TODO: configurable geometry?
    program = pkgs.writeShellScript "kiosk" ''
      export _JAVA_AWT_WM_NONREPARENTING=1
      ${pkgs.wmname}/bin/wmname LG3D
      ${pkgs.turbvnc}/bin/vncviewer \
        NoNewConn=1 \
        Shared=0 \
        FullScreen=1 \
        Password=password \
        Quality=80 \
        CompressionLevel=6 \
        Subsampling=2x \
        Colors=16 \
        Scale=auto \
        Server=100.67.63.47::5900
    '';
    user = "kiosk"; 
    extraArguments = [ "-ds" ] ;
  };

  systemd.services."cage-tty1".wants = [ "tailscaled.service" ];
  users.users."kiosk".isSystemUser = true;
}
