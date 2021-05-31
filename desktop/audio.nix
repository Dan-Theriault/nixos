{ config, pkgs, ... }:

{
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1
      load-module module-switch-on-connect
    '';
  };

  environment.systemPackages = ( with pkgs; [
    pamixer
    pasystray
    lxqt.pavucontrol-qt
    cava
    glyr

    ffmpeg
    ncmpcpp
    mpc_cli
    sonata
    clerk
  ] );

  boot.kernelModules = [ "snd_usb_audio" ]; # external DAC/AMP support
}
