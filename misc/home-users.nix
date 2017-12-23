{ config, pkgs, ... }:

let 
  home_user = {
    isNormalUser = true;
    extraGroups = [ "disk" "audio" "video" "networkmanager" "scanner" "lp" "bluetooth" ];
    initialPassword = "123pleasechangeme";
  }; 
in {
  users.users = {
    Marc  = home_user;
    Lisa  = home_user;
    Luke  = home_user;
    Jimmy = home_user;
    Joey  = home_user;
    Nicki = home_user;
  };
  security.pam.services = {
    Marc.enableKwallet = true;
    Lisa.enableKwallet = true;
    Luke.enableKwallet = true;
    Jimmy.enableKwallet = true;
    Joey.enableKwallet = true;
    Nicki.enableKwallet = true;
  };
}

