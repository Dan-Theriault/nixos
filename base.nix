# Base system with editor and major shell utilities

{ config, pkgs, ... }:

let
  mozilla = builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
in
{
  # Nix settings
  nix = {
    gc = {
      automatic = true;
      options = "-d";
    };
    buildCores = 0;
    maxJobs = 8;
    allowedUsers = [ "@wheel" ];
    autoOptimiseStore = true;
    daemonNiceLevel = 3;
    daemonIONiceLevel = 3;
  };


  nixpkgs.config = {
    allowUnfree = true;
    overlays = [ (import "${mozilla}/firefox-overlay.nix") ];
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = pkgs.lib.mkDefault "Lat2-Terminus16";
    consoleKeyMap = pkgs.lib.mkDefault "us";
    defaultLocale = pkgs.lib.mkDefault "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";
  # services.openntpd.enable = true;
  boot.kernelPackages = pkgs.lib.mkDefault pkgs.linuxPackages_latest;

  # Manual on VT-8
 services.nixosManual.showManual = true;

  # CLI utilities, services, and other packages that should always be installed.
  environment.systemPackages = with pkgs; [ 
    abduco # detached sessions
    dnsutils
    file
    git
    gnupg
    htop 
    ncdu
    mailutils
    neofetch
    netsniff-ng # flowtop, others
    psmisc # killall and friends
    tree
    unzip
    vim
    wget curl
    whois
  ];

  # Setup user account(s)
  users = {
    defaultUserShell = pkgs.bashInteractive;
    users.dtheriault3 = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "disk"
        "audio" "video" "input" "tty"
        "networkmanager" 
        "systemd-journal" 
        "scanner" "lpadmin" 
        "bluetooth" 
        "sway"
      ];
      initialPassword = "hagan lio"; # change immediately after install with passwd
    };
  };
  security.sudo.extraConfig = ''
    Defaults env_reset,pwfeedback
  '';
}
