{ config, pkgs, ... }:

{
  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };
  environment.systemPackages = [
    pkgs.steam
  ];
}
