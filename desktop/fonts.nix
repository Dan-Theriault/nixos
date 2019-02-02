{ config, pkgs, ... }:

{
  fonts = {
    fontconfig = {
      penultimate.enable = true;
      defaultFonts = {
        monospace = [ "IBM Plex Mono" ];
        sansSerif = [ "IBM Plex Sans" ];
        serif     = [ "IBM Plex Serif" ];
      };
      localConf = ''
        <match target="font">
          <edit name="hinting" mode="assign">
            <bool>true</bool>
          </edit>
          <edit name="hintstyle" mode="assign">
            <const>hintfull</const>
          </edit>
          <edit name="rgba" mode="assign">
            <const>rgb</const>
          </edit>
          <edit name="lcdfilter" mode="assign">
            <const>lcddefault</const>
          </edit>
          <test name="weight" compare="more">
            <const>medium</const>
          </test>
          <edit name="autohint" mode="assign">
            <bool>false</bool>
          </edit>
        </match>
      '';
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
