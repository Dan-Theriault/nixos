{ config, pkgs, ... }:

{
  hardware = {
    opengl.driSupport32Bit = true;
    opengl.extraPackages32 = with pkgs; [
      vaapiIntel
    ];
    pulseaudio.support32Bit = true;
  };
  environment.systemPackages = with pkgs; [
    steam
    steam-run
  ];
}
