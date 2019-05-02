{ config, pkgs, ... }:

{
  fonts = {
    fontconfig = {
      penultimate.enable = pkgs.lib.mkDefault true;
      defaultFonts = {
        monospace = [ "IBM Plex Mono" ];
        sansSerif = [ "IBM Plex Sans" ];
        serif     = [ "IBM Plex Serif" ];
      };
    };
    fonts = with pkgs; [
      google-fonts # ~300mb tarball download. Slow. Lots of junk. But oh-so-many fonts!

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
