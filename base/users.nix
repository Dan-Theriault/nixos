# Setup user account(s)

{ config, pkgs, ... }:

{
  users = {
    users.dtheriault3 = {
      isNormalUser = true;
      extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" ];
      initialPassword = "hagan lio"; # change immediately after install with passwd
    };
  };
}
