{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-studio-preview
  ];
  programs.adb.enable = true;
  users.extraUsers.dtheriault3.extraGroups = ["adbusers"];
}
