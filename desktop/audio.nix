{ config, pkgs, ... }:

let
  spotifyd = pkgs.spotifyd.override { withMpris = true; withKeyring = true; dbus = pkgs.dbus; };
  spotifydConf = pkgs.writeText "spotifyd.conf" ''
    [global]
    username = dan@theriault.codes
    use_keyring = true
    device_name = spotifyd 
    device_type = computer
    backend = pulseaudio
    bitrate = 320
  '';
in
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

    spotify-tui
  ] );

  boot.kernelModules = [ "snd_usb_audio" ]; # external DAC/AMP support

  programs.fish.shellAliases = {
    lyrics = "glyrc lyrics -a (playerctl metadata artist 2>/dev/null) -t (playerctl metadata title 2>/dev/null) -v 0 -w /tmp/lyrics; and cat /tmp/lyrics";
  };

  systemd.user.services.spotifyd = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "sound.target" ];
    description = "spotifyd, a Spotify playing daemon";
    serviceConfig = {
      ExecStart = "${spotifyd}/bin/spotifyd --no-daemon --config-path ${spotifydConf}";
      Restart = "always";
      RestartSec = 12;
    };
  };
}
