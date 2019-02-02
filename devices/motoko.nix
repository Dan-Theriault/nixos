# VirtualBox configuration
{ config,  pkgs, ... }:

{
  imports = [ 
    # System Essentials
    ../base.nix
    ../net

    # Desktop Environment
    ../desktop/x.nix
    ../desktop/fonts.nix

    # Developer
    ../developer
  ];

  environment.systemPackages = import ../desktop/pkgs.nix {inherit config pkgs;};

  # Startup Settings
  networking.hostName = "motoko"; 

  # Tweaks from nixos-hardware
  boot.kernel.sysctl = {
    "vm.swappiness" = 10; # swap less aggressively
    "vm.dirty_writeback_centisecs" = 1500; # reduce window for data loss 
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
  };

  boot.growPartition = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.fsIdentifier = "provided";

  virtualisation.virtualbox.guest.enable = true;

  system.stateVersion = "18.03";

  powerManagement.enable = false;

  services.xserver.videoDrivers = [ "virtualbox" "cirrus" "vesa" "modesetting" ];
  services.compton.enable = false;
  services.syncthing.enable = false;

  services.xserver.windowManager.i3.configFile = pkgs.writeTextFile {
    name = "i3-vm.conf";
    text = import ../desktop/i3.nix { inherit config pkgs; isVm = true; };
  };
}
