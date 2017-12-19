{ config, pkgs, ... }:

# Brother print queues are "lpd://<ip-address>/binary_p1"

{
  imports = [ 
    <nixpkgs/nixos/modules/services/hardware/sane_extra_backends/brscan4.nix>
  ];

  services.printing = {
    enable = true;
    # drivers = [ pkgs.gutenprint pkgs.gutenprintBin pkgs.hplip pkgs.brgenml1cupswrapper pkgs.brgenml1lpr pkgs.ghostscript];
    drivers = [ pkgs.brgenml1cupswrapper pkgs.brgenml1lpr pkgs.ghostscript];
  };

  hardware.sane = { #scanner
    enable = true;
    brscan4 = {
      enable = true;
      netDevices.home = {model = "MFC-J885DW"; ip = "192.168.1.107"; };
    };
  };

  environment.systemPackages = ( with pkgs; [
    xsane paperwork
  ]);

  services.avahi.enable = true; # needed for pdf export in papework... for some reason?
}
