{ config, pkgs, ... }:

let
  ibm-plex = pkgs.fetchzip rec {
    name = "ibm-plex-0.5.3";

    url = "https://github.com/IBM/type/archive/v0.5.3.zip";

    postFetch = ''
      mkdir -p $out/share/{doc,fonts}
      unzip -j $downloadedFile \*.otf      -d $out/share/fonts/opentype
      unzip -j $downloadedFile \*README.md -d "$out/share/doc/${name}"
    '';

    sha256 = "1ghj2lqc5m33qa55h8ag6xwdqbwc9gdxncf66jr5fd5fadjhrfr8";

    meta = with pkgs.stdenv.lib; {
      description = "IBM's new corporate typeface. Mono, Sans, and Serif with eight weights.";
      homepage = https://ibm.github.io/type/;
      license = licenses.ofl;
      platforms = platforms.all;
      # maintainers = with maintainers; [ dan-theriault ];
    };
  };

in

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
          <edit name=lcdfilter" mode="assign">
            <const>lcddefault</const>
          </edit>
          <test name="weight" compare="more>
            <const>medium</const>
          </test>
          <edit name="autohint" mode="assign">
            <bool>false</bool>
          </edit>
        </match>
      '';
    };
    fonts = [ ibm-plex ] ++ ( with pkgs; [
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
    ] );
  };
}
