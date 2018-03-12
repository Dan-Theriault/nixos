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
      # ../net/ssh-server.nix

      # Misc. Other Components
      ../misc/fonts.nix
      ../misc/tex.nix

      # Hardening
      ../security
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
  };

  environment = {
    systemPackages = ( with pkgs; [
      wpa_supplicant_gui
      solaar
      google-chrome-beta
      fortune
      powertop
      glxinfo
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

  # Tweaks from nixos-hardware
  boot.kernel.sysctl = {
    "vm.swappiness" = 10; # swap less aggressively
    "vm.dirty_writeback_centisecs" = 1500; # reduce window for data loss 
  };
  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth.enable = true;
  services.xserver.videoDrivers = [ "intel" ];

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
  ];
}
