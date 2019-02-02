# Personal Laptop configuration
{ config,  pkgs, ... }:

{
  imports = [ 
    # System Essentials
    ../base.nix
    ../hardware-configuration.nix

    # Desktop Environment
    ../desktop/audio.nix
    ../desktop/bluej.nix
    ../desktop/fonts.nix
    ../desktop/gaming.nix
    ../desktop/home-users.nix
    ../desktop/x.nix

    # Developer Tooling
    ../developer

    # Network Services
    ../net
    ../net/ssh-client.nix
    # ../net/ssh-server.nix

    # Hardening
    ../security
    ../security/keybase.nix
  ];

  environment.systemPackages = import ../desktop/pkgs.nix {
    inherit config pkgs;
    tex = true;
    BlueJ = true;
  };

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
    # plymouth.enable = true;
  };

  networking = { 
    hostName = "specere"; 
    wireless.enable = true;
  };

  powerManagement = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
      wpa_supplicant_gui
      solaar
      fortune
      powertop
      glxinfo
      blueman
    ];

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
        horizontalScrolling = false; # unintuitively, enables horizontal scrolling
      };
    };
    upower.enable = true;
    acpid.enable = true;
    printing.enable = true;
    compton.enable = false;
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

  system.stateVersion = "17.09";
}
