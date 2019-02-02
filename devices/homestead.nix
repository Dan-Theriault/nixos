# Home Desktop Configuration
{ config, pkgs, ... }:

{
  imports = [ 
    ../base.nix                   
    ../hardware-configuration.nix 

    ../desktop/audio.nix
    ../desktop/brother-printing.nix
    ../desktop/fonts.nix
    ../desktop/gaming.nix
    ../desktop/home-users.nix
    ../desktop/x.nix              

    ../developer

    ../net
    ../net/ssh-client.nix 
    ../net/ssh-server.nix
    # ../net/wireguard.nix

    ../security
    ../security/keybase.nix
  ];

  environment.systemPackages = import ../desktop/pkgs.nix {
    inherit config pkgs;
    tex = true;
  };
  
  # Handle two encrypted partitions
  boot.initrd.luks.devices.aCrypt = { # large HDD
    device = "/dev/sda1";
    preLVM = true;
  };
  boot.initrd.luks.devices.bCrypt = { # small SSD
    device = "/dev/sdb2";
    preLVM = true;
  };

  boot.initrd.availableKernelModules = [ "plymouth" "plymouth-encrypt" ]; 
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
  };

  boot.plymouth.enable = true;

  networking.hostName = "homestead"; 

  system.autoUpgrade = {
    enable = true;
    dates = "02:30";
  };

  environment.systemPackages = with pkgs; [
    # Only needed on this host
    chromium solaar 
  ];

  services.udev.packages = with pkgs; [ solaar ];

  services.xserver.resolutions = [ { x = 3840; y = 2160; } ];

  hardware.cpu.intel.updateMicrocode = true;
  services.compton.enable = false;

  # Tweaks from nixos-hardware
  boot.kernel.sysctl = {
    "vm.swappiness" = 10; # swap less aggressively
    "vm.dirty_writeback_centisecs" = 1500; # reduce window for data loss 
  };
  hardware.bluetooth.enable = true;
  services.xserver.videoDrivers = [ "intel" "nvidia" ];

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
  ];
}
