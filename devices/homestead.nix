# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix # hardware, detected automatically
      /etc/nixos/base                       # core modules

      /etc/nixos/desktop/x.nix              # DE / WM configuration
      /etc/nixos/desktop/pkgs.nix

      /etc/nixos/developer/vim.nix
      /etc/nixos/developer/fish.nix

      /etc/nixos/misc/fonts.nix
      /etc/nixos/misc/home-users.nix
      /etc/nixos/misc/brother-printing.nix

      /etc/nixos/net/ssh-server.nix         # OpenSSH server as a TOR hidden service
      /etc/nixos/net/ssh-client.nix         # client configuration + preset known hosts (WIP)
    ];
  
  # Dual full-disk encryption
  boot.initrd.luks.devices.aCrypt = { # large HDD
    device = "/dev/sda1";
    preLVM = true;
  };
  boot.initrd.luks.devices.bCrypt = { # small SSD
    device = "/dev/sdb2";
    preLVM = true;
  };

  hardware.bluetooth.enable = true;
  boot.initrd.availableKernelModules = [ "hid-logitech-hidpp" ]; # required to get keyboard / mouse for LUKS unlock
  boot.loader.systemd-boot.enable = true;

  networking.hostName = "homestead"; 

  # This is mostly useless, since the ISP blocks a lot of ports.
  # Left in just-in-case (and to test my assumptions on reading secret files).
  services.ddclient = {
    enable = true;
    domain = "homestead.dtheriault.com";
    server = "dynamicdns.park-your-domain.com";
    protocol = "namecheap";
    use = "web, web=dynamicdns.park-your-domain.com/getip";
    username = "dtheriault.com";
    password = builtins.readFile /etc/nix-secrets/dyndns;
  };

  environment.systemPackages = with pkgs; [
    wget vim git curl # Bootstrapping tools

    # Only needed on this host
    chromium solaar
  ];

  services.xserver.xrandrHeads = [
    {
      output = "HDMI1";
      primary = true;
      monitorConfig = ''
        Option "mode" "1920x1080"
        Option "pos" "0x0"
        Option "rotate" "normal"
      '';
    }
    {
      output = "VGA1";
      monitorConfig = ''
        Option "mode" "1920x1080"
        Option "pos" "1920x0"
        Option "rotate" "normal"
      '';
    }
  ];
}
