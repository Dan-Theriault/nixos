{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    androidStudioPackages.dev
  ];
  programs.adb.enable = true;
  users.extraUsers.dtheriault3.extraGroups = ["adbusers"];
}
