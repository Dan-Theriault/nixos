{ config, pkgs, ... }:

let
  keepassxc = pkgs.keepassx-community.overrideDerivation (attrs: rec {
    version = "2.3.0";
    buildInputs = attrs.buildInputs ++ [ 
      pkgs.libargon2 
      pkgs.curlFull.dev 
      pkgs.libsodium.dev
    ];
    patches = [];
    cmakeFlags = attrs.cmakeFlags ++ [ 
      "-DWITH_XC_NETWORKING=ON"
      "-DWITH_XC_BROWSER=ON"
      "-DWITH_XC_SSHAGENT=ON"
      "-DKEEPASSXC_BUILD_TYPE=Release"
      "-DWITH_XC_HTTP=OFF"
    ];
    src = pkgs.fetchFromGitHub {
      owner = "keepassxreboot";
      repo = "keepassxc";
      rev = "2.3.0";
      sha256 = "1zch1qbqgphhp2p2kvjlah8s337162m69yf4y00kcnfb3539ii5f";
    };
  });
  firefox-custom = pkgs.buildEnv {
    name = "firefox-custom";
    paths = [ 
      pkgs.firefox-beta-bin
      # pkgs.keepassx-community 
      pkgs.ffmpeg pkgs.libav
      keepassxc
    ];
  };
in
{
  nixpkgs.config = {
    allowUnfree = true;
    firefox = {
      ffmpegSupport = true;
      gtk3Support = true;
    };
  };

  environment.systemPackages =  with pkgs; [
    arandr
    inkscape
    libav
    libreoffice-fresh detox
    mpv youtube-dl
    meld # graphical diffs
    sc-im
    steam
    steam-run
    wireshark
    xst
    zathura
  ] ++ ( with pkgs.kdeApplications; [
      okular
      filelight
      dolphin
      kate
      kgpg
  ] ) ++ [
    firefox-custom 
    firefoxPackages.tor-browser
  ];
}
