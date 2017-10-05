{ config, pkgs, ... }:

{
  fonts = {
    enableFontDir = true;
    enableDefaultFonts = true;
    fontconfig.penultimate.enable = true;
    fontconfig.defaultFonts = {
      monospace = [ "Source Code Pro" ];
      sansSerif = [ "Source Sans Pro" ];
      serif =     [ "Source Serif Pro" ];
    };
    fonts = with pkgs; [
      google-fonts # ~300mb tarball download. Slow. Lots of junk. But oh-so-many fonts!

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
