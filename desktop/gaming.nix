{ config, pkgs, ... }:

{
  hardware = {
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };
  # environment.extraInit = ''
  #   export XDG_DATA_DIRS=$XDG_DATA_DIRS:${basalt}/layers/
  # '';
  environment.systemPackages = with pkgs; [
    steam
    steam-run
    lutris
    # basalt
    # wineWowPackages.base
    # winetricks
    # samba
    # p7zip
  ];
}
