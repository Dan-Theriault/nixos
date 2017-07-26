# Setup user account(s)

{ config, pkgs, ... }:

{
  users.users.dtheriault3 = {
    shell = pkgs.bash;

    createHome = true;
    home = "/home/dtheriault3";

    group = "users";
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" ];

    initialPassword = "hagan lio"; # change immediately after install with passwd
  };
}
