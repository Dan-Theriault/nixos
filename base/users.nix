# Setup user account(s)

{ config, pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.bash;
    users.dtheriault3 = {
      isNormalUser = true;
      extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "scanner" "lpadmin" "bluetooth" ];
      initialPassword = "hagan lio"; # change immediately after install with passwd
    };
  };
}
