{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    androidStudioPackages.beta
  ];
  nixpkgs.config.android_sdk.accept_license = true;
  programs.adb.enable = true;
  users.extraUsers.dtheriault3.extraGroups = ["adbusers"];
}
