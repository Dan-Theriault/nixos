# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      ../base                       # core modules
      ../hardware-configuration.nix # hardware, detected automatically

      ../desktop/audio.nix
      ../desktop/pkgs.nix
      ../desktop/x.nix              # DE / WM configuration
      ../desktop/gaming.nix

      ../developer

      ../misc/brother-printing.nix
      ../misc/fonts.nix
      ../misc/home-users.nix
      ../misc/tex.nix
      ../misc/bluej.nix

      ../net/ssh-client.nix         # client configuration + preset known hosts (WIP)
      ../net/ssh-server.nix         # OpenSSH server as a TOR hidden service

      ../security
    ];
  
  # Handle two encrypted partitions
  boot.initrd.luks.devices.aCrypt = { # large HDD
    device = "/dev/sda1";
    preLVM = true;
  };
  boot.initrd.luks.devices.bCrypt = { # small SSD
    device = "/dev/sdb2";
    preLVM = true;
  };

  boot.initrd.availableKernelModules = [ "hid-logitech-hidpp" "plymouth" "plymouth-encrypt" ]; # logitech required to get keyboard / mouse for LUKS unlock
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

  # # This is mostly useless, since the ISP blocks a lot of ports.
  # # Left in just-in-case (and to test my assumptions on reading secret files).
  # services.ddclient = {
  #   enable = true;
  #   domain = "homestead.dtheriault.com";
  #   server = "dynamicdns.park-your-domain.com";
  #   protocol = "namecheap";
  #   use = "web, web=dynamicdns.park-your-domain.com/getip";
  #   username = "dtheriault.com";
  #   password = builtins.readFile /etc/nix-secrets/dyndns;
  # };

  environment.systemPackages = with pkgs; [
    # Only needed on this host
    chromium solaar 
    # google-chrome-beta
    blueman
    compton
  ];

  services.udev.packages = with pkgs; [ solaar ];

  services.xserver.xrandrHeads = [
    {
      output = "HDMI1";
      monitorConfig = ''
        Option "mode" "1920x1080"
        Option "pos" "0x0"
        Option "rotate" "right"
      '';
    }
    {
      output = "VGA1";
      primary = true;
      monitorConfig = ''
        Option "mode" "1920x1080"
        Option "pos" "1080x465"
        Option "rotate" "normal"
      '';
    }
  ];

  hardware.cpu.intel.updateMicrocode = true;
  services.compton.enable = false;

  # Tweaks from nixos-hardware
  boot.kernel.sysctl = {
    "vm.swappiness" = 10; # swap less aggressively
    "vm.dirty_writeback_centisecs" = 1500; # reduce window for data loss 
  };
  hardware.bluetooth.enable = true;
  services.xserver.videoDrivers = [ "intel" ];

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
  ];
}
