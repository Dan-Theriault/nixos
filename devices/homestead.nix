# Home Desktop Configuration
{ config, pkgs, ... }:

{
  imports = [ 
    ../base                       # core modules
    ../hardware-configuration.nix # hardware, detected automatically

    ../desktop/audio.nix
    ../desktop/gaming.nix
    ../desktop/pkgs.nix
    ../desktop/tex.nix
    ../desktop/x.nix              # DE / WM configuration

    ../developer

    ../misc/brother-printing.nix
    ../misc/fonts.nix
    ../misc/home-users.nix

    ../net
    ../net/ssh-client.nix         # client configuration + preset known hosts (WIP)
    ../net/ssh-server.nix         # OpenSSH server as a TOR hidden service
    # ../net/wireguard.nix

    ../security
    ../security/keybase.nix
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

  services.xserver.resolutions = [ { x = 1920; y = 1080; } ];
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
  services.xserver.videoDrivers = [ "intel" "nvidia" ];

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
  ];
}
