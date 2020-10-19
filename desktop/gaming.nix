{ config, pkgs, ... }:

{
  hardware = {
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    steam
    steam-run
    lutris
  ];
}
