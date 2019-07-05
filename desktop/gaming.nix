{ config, pkgs, ... }:

{
  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };
  environment.systemPackages = with pkgs; [
    steam
    steam-run
    # wineWowPackages.base
    # winetricks
    # samba
    # p7zip
  ];
}
