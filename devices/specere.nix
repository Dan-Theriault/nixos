# Personal Laptop configuration
{ config,  pkgs, ... }:

{
  imports =
    [ 
      # System Essentials
      ../base
      ../hardware-configuration.nix

      # Desktop Environment
      ../desktop/audio.nix
      ../desktop/pkgs.nix
      ../desktop/x.nix
      ../desktop/gaming.nix

      # Developer Tooling
      ../developer

      # Network Services
      ../net/ssh-client.nix
      ../net/ssh-server.nix

      # Misc. Other Components
      ../misc/fonts.nix
      ../misc/tex.nix
    ];

  # Startup Settings
  boot = {
    initrd = {
      luks.devices = [ { device = "/dev/sda2"; preLVM = true; } ];
    };
    loader.systemd-boot = {
      enable = true;
      editor = false;
    };
    loader.efi.canTouchEfiVariables = true;
  };

  networking = { 
    hostName = "specere"; 
    wireless.enable = true;
  };

  powerManagement = {
    enable = true;
    powerDownCommands = ''
      /run/current-system/sw/bin/i3lock-fancy -f Overpass-Black -t "TYPE TO UNLOCK" -- maim -u
    '';
    resumeCommands = ''
      systemctl restart dnscrypt-proxy.service
      /run/current-system/sw/bin/i3lock
    '';
  };

  environment = {
    systemPackages = ( with pkgs; [
      wpa_supplicant_gui
      solaar
      chromium # just for youtube tv 
      fortune
      powertop
    ] );
  };

  # nixpkgs.config = {
  #   chromium = {
  #     enablePepperFlash = true;
  #     enablePepperPDF = true;
  #     enableWideVine = true;
  #   };
  # };

  services = { 
    xserver = {
      xrandrHeads = [
        {
          output = "eDP-1";
          primary = true;
          monitorConfig = ''
            Option "mode" "1920x1080"
            Option "pos" "0x0"
            Option "rotate" "normal"
          '';
        }
      ];
      libinput = {
        enable = true;
        naturalScrolling = true;
      };
    };
    upower.enable = true;
    acpid.enable = true;
    printing.enable = true;
    compton.enable = true;
    tlp.enable = true;
  };
}
