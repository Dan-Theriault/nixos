# Personal Laptop configuration
{ config,  pkgs, ... }:

{
  imports =
    [ 
      # System Essentials
	    /etc/nixos/base
	    /etc/nixos/hardware-configuration.nix

      # Desktop Environment
      /etc/nixos/desktop/audio.nix
      /etc/nixos/desktop/pkgs.nix
      /etc/nixos/desktop/x.nix

      # Developer Tooling
      /etc/nixos/developer

      # Network Services
      /etc/nixos/net/ssh-client.nix
      /etc/nixos/net/ssh-server.nix

      # Misc. Other Components
      /etc/nixos/misc/fonts.nix
      /etc/nixos/misc/tex.nix
    ];

  # Startup Settings
  # boot = {
  #   initrd = {
  #     luks.devices = [ { name = "root"; device = "/dev/sda2"; preLVM = true; } ];
  #   };
  #   loader.grub = {
  #     enable = true;
  #     version = 2;
  #     device = "/dev/sda";
  #   };
  # };

  networking = { 
    hostName = "specere"; 
    wireless.enable = true;
  };

  environment = {
    systemPackages = ( with pkgs; [
      wpa_supplicant_gui
      solaar
    ] );
  };

  services = { 
    xserver.xrandrHeads = [
      {
        output = "eDP-1";
        primary = "true";
        monitorConfig = ''
          Option "mode" "1920x1080"
          Option "pos" "0x0"
          Option "rotate" "normal"
        '';
      }
    ];
    upower.enable = true;
    acpid.enable = true;
    printing.enable = true;
  };
}
