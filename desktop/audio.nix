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

    spotify
  ] );
  # TODO: spotifyd, spotify-tui, remove spotify

  boot.kernelModules = [ "snd_usb_audio" ]; # external DAC/AMP support

  programs.fish.shellAliases = {
    lyrics = "glyrc lyrics -a (playerctl metadata artist 2>/dev/null) -t (playerctl metadata title 2>/dev/null) -v 0 -w /tmp/lyrics; and cat /tmp/lyrics";
  };
}
