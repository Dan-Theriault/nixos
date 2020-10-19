{ config, pkgs, ... }:


{
  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [ "Fira Code" ];
        sansSerif = [ "Inria Sans" ];
        serif     = [ "Inria Serif" ];
      };
    };
    fonts = with pkgs; [
      # google-fonts # ~300mb tarball download. Slow. Lots of junk. But oh-so-many fonts!
      inriafonts
      jost
      cooper-hewitt
      libre-franklin
      libre-baskerville
      libre-caslon
      libre-bodoni
      manrope
      inter

      ibm-plex

      siji
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
}
