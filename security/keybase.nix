{config, pkgs, ...}:

{
  services = {
    kbfs.enable = true;
    keybase.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    keybase keybase-gui
  ];
}

