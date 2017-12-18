{ config, pkgs, ... }:

let 
  unpriveleged_user = {
    isNormalUser = true;
    extraGroups = [ "disk" "audio" "video" "networkmanager" ];
    initialPassword = "123pleasechangeme";
  }; 
in {
  users.users.Marc = unpriveleged_user;
  users.users.Lisa = unpriveleged_user;
  users.users.Luke = unpriveleged_user;
  users.users.Jimmy = unpriveleged_user;
  users.users.Joey = unpriveleged_user;
  users.users.Nicki = unpriveleged_user;
}

