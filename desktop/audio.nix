{ config, pkgs, ... }:

{
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true;
  };

  environment.systemPackages = ( with pkgs; [
    pamixer
    pasystray
    lxqt.pavucontrol-qt
    cli-visualizer

    ffmpeg
    gstreamer
    ncmpcpp
  ] );

  # Here be dragons
  # services.mopidy = {
  #   enable = true;
  #   extensionPackages = ( with pkgs; [
  #     mopidy-gmusic
  #     mopidy-mopify
  #     mopidy-youtube
  #   ] );
  #   configuration = '' 
  #     [core]
  #     restore_state = true

  #     [audio]
  #     mixer = none
  #     mixer-volume = 100
  #     output = pulsesink

  #     [youtube]
  #     enabled = true

  #     [mopify]
  #     enabled = true

  #     [gmusic]
  #     enabled = true
  #     all_access = true
  #     bitrate = 320
  #   '';
  #   extraConfigFiles = [ "/home/dtheriault3/.mopidy" ]; # secret login details
  # };
}
