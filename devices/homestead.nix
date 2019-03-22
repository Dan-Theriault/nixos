# Home Desktop Configuration
{ config, pkgs, ... }:

{
  imports = [ 
    ../base.nix                   
    ../hardware-configuration.nix 

    ../desktop
    ../desktop/audio.nix
    ../desktop/brother-printing.nix
    ../desktop/fonts.nix
    ../desktop/gaming.nix
    ../desktop/home-users.nix
    ../desktop/wayland.nix
    ../desktop/x.nix              # DE / WM configuration

    ../developer

    ../net
    ../net/ssh-client.nix 
    # ../net/ssh-server.nix
    # ../net/wireguard.nix

    ../security
    ../security/keybase.nix
  ];

  environment.systemPackages = (import ../desktop/pkgs.nix {
    inherit config pkgs;
    tex = true;
  }) ++ (with pkgs; [chromium solaar]);
  
  # Handle two encrypted partitions
  boot.initrd.luks.devices.aCrypt = { # large HDD
    device = "/dev/sda1";
    preLVM = true;
  };
  boot.initrd.luks.devices.bCrypt = { # small SSD
    device = "/dev/sdb2";
    preLVM = true;
  };

  # boot.initrd.availableKernelModules = [ "plymouth" "plymouth-encrypt" ]; 
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
  };

  # boot.plymouth.enable = true;

  networking.hostName = "homestead"; 

  system.autoUpgrade = {
    enable = true;
    dates = "02:30";
  };

  services.udev.packages = with pkgs; [ solaar ];

  services.xserver.resolutions = [ { x = 3840; y = 2160; } ];
  services.xserver.xrandrHeads = [
    {
      output = "DisplayPort-2";
      primary = true;
      # monitorConfig = ''
      #   Option "mode" "3840x2160"
      #   Option "rotate" "normal"
      # '';
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
  services.xserver.videoDrivers = [ "amdgpu" "intel" ];
  boot.kernelPatches = [
    {
      name = "amdgpu-config";
      patch = null;
      extraConfig = ''
        DRM_AMDGPU m
        DRM_AMDGPU_SI y
        DRM_AMDGPU_CIK y
      '';
    }
  ];

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
  ];
}
