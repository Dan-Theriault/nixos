# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config,  pkgs, ... }:

let
  nodeEnv = import "/etc/nixos/.envs/node/default.nix" {};
  local = import "/etc/nixos/.envs/local/localpkgs.nix";
in {
  imports =
    [ 
      # System Essentials
	    /etc/nixos/base
	    /etc/nixos/hardware-configuration.nix

      # Desktop Environment
      /etc/nixos/desktop/audio.nix
      /etc/nixos/desktop/pkgs.nix
      /etc/nixos/desktop/x.nix

      # Misc. Other Components
      /etc/nixos/misc/dev.nix
      /etc/nixos/misc/fonts.nix
      /etc/nixos/misc/tex.nix 
    ];

  # Startup Settings
  boot = {
    initrd = {
      luks.devices = [ { name = "root"; device = "/dev/sda2"; preLVM = true; } ];
    };
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    keepassx-community = pkgs.keepassx-community.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "varjolintu";
        repo = "keepassxc";
        rev = "2.2.0-browser-beta5";
        sha256 = "0s4m5cd1swskkhi5c5jf2fhwxr9026vgn2fxm22nfrv8j6kg5j7a";
      };
    } );
  };

  networking = { 
    hostName = "Hanscom"; # Define your hostname.
    wireless.enable = false;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    systemPackages = ( with pkgs; [
      # Nodejs
      nodejs
      nodePackages.node2nix
      nodeEnv.base16-builder

      # Languages
      rustStable.rustc
      rustStable.cargo
    ] );

    shellInit = ''
      ### SYSTEM WIDE CONFIGURATION SCRIPTING ###
      export GTK_DATA_PREFIX=${config.system.path}

      export QT_STYLE_OVERRIDE=gtk
      xrandr --size 1920x1080
    '';
  };



  # List services that you want to enable:

  services = { 
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
    dbus.enable = true;

    # Enable CUPS to print documents.
    printing.enable = false;

    xserver.xrandrHeads = [
      { output = "Virtual1";
        primary = true;
        monitorConfig = ''
          DisplaySize 1920 1200
        '';
      }
    ];
  };


}
