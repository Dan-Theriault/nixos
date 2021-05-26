# Home Desktop Configuration
{ config, pkgs, ... }:

{
  imports = [ 
    <nixpkgs/nixos/modules/profiles/qemu-guest.nix>

    ../base.nix                   
    ../hardware-configuration.nix 

    ../desktop
    # ../desktop/audio.nix
    # ../desktop/brother-printing.nix
    ../desktop/fonts.nix
    # ../desktop/gaming.nix
    ../desktop/wayland.nix

    ../developer

    ../net
    # ../net/ssh-client.nix 
    # ../net/ssh-server.nix

    # ../security
  ];

  environment.systemPackages = (import ../desktop/pkgs.nix {
    inherit config pkgs;
    tex = true;
  }) ++ (with pkgs; [
    mullvad-vpn
    solaar # TODO: package logiops
  ]);
  
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "geist"; 

  # system.autoUpgrade = {
  #   enable = true;
  #   dates = "02:30";
  # };

  # systemd.services.nixos-upgrade.path = with pkgs; [
  #   gnutar xz.bin gzip config.nix.package.out
  # ];

  services.xserver.resolutions = [ { x = 3840; y = 2160; } ];
  services.xserver.xrandrHeads = [
    {
      output = "DisplayPort-2";
      primary = true;
    }
  ];


  # Tweaks from nixos-hardware
  # boot.kernel.sysctl = {
  #   "vm.swappiness" = 10; # swap less aggressively
  #   "vm.dirty_writeback_centisecs" = 1500; # reduce window for data loss 
  # };

  hardware.bluetooth.enable = false;

  # hardware.logitech.wireless = {
  #   enable = true;
  #   enableGraphical = true;
  # };

  # services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "virtio-vga" ];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  powerManagement.cpuFreqGovernor = "performance";

  hardware.opengl.extraPackages = with pkgs; [ ];

  console.font = "sun12x22";

  # networking.iproute2.enable = true; #required for mullvad
  # services.mullvad-vpn.enable = true;
}
