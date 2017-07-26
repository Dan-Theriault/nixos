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
	    /etc/nixos/hardware-configuration.nix
	    /etc/nixos/base/base.nix
      /etc/nixos/tex.nix
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
    plymouth = { 
      enable = true;
      theme = "script";
    };
  };

  # hardware = {
  #   opengl.driSupport32Bit = true;
  #   pulseaudio.support32Bit = true;
  # };

  nixpkgs.config.packageOverrides = pkgs: {
    polybar = pkgs.polybar.override {
      i3Support = true;
      mpdSupport = true;
    };

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
    hostName = "Hadron"; # Define your hostname.
    wireless.enable = false;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    systemPackages = ( with pkgs; [
      gtk2

      # CLI Tools
      wget 
      htop 
      git 
      ag 
      stow 
      taskwarrior 
      tree 
      nix-repl
      xclip

      # Window Manager & Accessories 
      rofi 
      dmenu 
      polybar 
      i3lock-fancy 
      networkmanagerapplet
      light
      xdotool
      arc-icon-theme 
      arc-theme 
      libsForQt5.qtstyleplugins 
      qt5.qtbase
      gnome3.gnome-font-viewer

      # Gaming
      steam

      # Misc. GUI Programs
      dolphin 
      filelight 
      kate
      liferea 
      arandr 
      zathura 
      lxappearance
      libreoffice-fresh
      enpass

      # Web
      firefox-beta-bin
      chromium

      # Terminal Emulator
      termite 

      # Utils
      syncthing 
      xlibs.xinput
      xlibs.fontutil
      xdg_utils
      xorg.xkill 
      xorg.xhost
      xclip
      sqlite
      psmisc # killall and other utilities
      netsniff-ng
      wireshark-cli
      wireshark

      # Nodejs
      nodejs
      nodePackages.node2nix
      nodeEnv.base16-builder

      # Rust Langt
      rustStable.rustc
      rustStable.cargo

      # Go Lang
      go
      
      # Perl
      perl
      
      keepassx-community

    ] ) ++ ( with pkgs.python35Packages; [
      ipython
    ] ) ++ ( with pkgs.python27Packages; [
      syncthing-gtk 
    # ] ) ++ ( with pkgs.goPackages; [
    #   base16-builder-go
    ] ) ++ ( with pkgs.xfce; [
      gtk_xfce_engine
      gvfs
      thunar
      thunar_volman
      xfce4icontheme
      xfce4settings
      xfconf
    ] );

    shellInit = ''
      ### SYSTEM WIDE CONFIGURATION SCRIPTING ###
      export GTK_PATH=${pkgs.xfce.gtk_xfce_engine}/lib/gtk-2.0
      export GTK_DATA_PREFIX=${config.system.path}
      export GIO_EXTRA_MODULES=${pkgs.xfce.gvfs}/lib/gio/modules

      export QT_STYLE_OVERRIDE=gtk
      export QT_QPA_PLATFORMTHEME=gtk2
      xfsettingsd &

      xrandr --size 1920x1080
    '';
  };

  fonts = {
    enableFontDir = true;
    enableDefaultFonts = true;
    fontconfig.defaultFonts = {
      monospace = [ "Source Code Pro" ];
      sansSerif = [ "Source Sans Pro" ];
      serif =     [ "Source Serif Pro" ];
    };
    fonts = with pkgs; [
      google-fonts # ~300mb tarball download. Slow. Lots of junk.

      dejavu_fonts
      fira
      fira-code
      font-awesome-ttf
      iosevka
      liberation_ttf
      norwester-font
      noto-fonts
      noto-fonts-emoji
      overpass
      roboto
      roboto-mono
      roboto-slab
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
  };

  # List services that you want to enable:

  services = { 
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    dbus.enable = true;
    upower.enable = true;
    acpid.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the X11 windowing system.
    xserver = { 
      resolutions = [ { x=1080; y=1920; } ];
      enable = true;
      layout = "us";
      xkbOptions = "compose:ralt";

      displayManager.sddm = {
        enable = true;
        autoLogin.user = "dtheriault3";
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3;
      };
    };
  };


}
