# Base system with editor and major shell utilities

{ config, pkgs, inputs, ... }:

{
  # Nix settings
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
    '';
    gc = {
      automatic = true;
      options = "-d";
    };
    # buildCores = 0;
    # maxJobs = 12;
    allowedUsers = [ "@wheel" ];
    autoOptimiseStore = true;
    # daemonNiceLevel = 3;
    # daemonIONiceLevel = 3;
  };

  # pin nixpkgs to system version
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  # may not work as expected in vm
  services.xserver.xkbOptions = "compose:ralt, caps:escape"; 

  # Select internationalisation properties.
  console = {
    useXkbConfig = true;
    font = pkgs.lib.mkDefault "Lat2-Terminus16";
    keyMap = pkgs.lib.mkDefault "us";
    # defaultLocale = pkgs.lib.mkDefault "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = pkgs.lib.mkDefault "America/New_York";
  location = pkgs.lib.mkDefault {
    latitude = 42.3;
    longitude = -71.1;
  };
  # services.openntpd.enable = true;
  boot.kernelPackages = pkgs.lib.mkDefault pkgs.linuxPackages_latest;

  # Manual on VT-8
 # services.nixosManual.showManual = true;

  # CLI utilities, services, and other packages that should always be installed.
  environment.systemPackages = with pkgs; [ 
    abduco # detached sessions
    clang
    coreutils
    dnsutils
    file
    fish
    fd
    git
    gnupg
    htop 
    ncdu
    mailutils
    neofetch
    netsniff-ng # flowtop, others
    psmisc # killall and friends
    ripgrep
    tree
    unzip
    vim
    wget curl
    whois
  ];

  # Setup user account(s)
  users = {
    defaultUserShell = pkgs.bashInteractive;
    users.dan = {
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
      initialPassword = "password"; # change immediately after install with passwd
    };
  };
  security.sudo.extraConfig = ''
    Defaults env_reset,pwfeedback
  '';
}
