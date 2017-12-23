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
    enableFontDir = true;
    enableDefaultFonts = true;
    fontconfig.penultimate.enable = true;
    fontconfig.defaultFonts = {
      monospace = [ "IBM Plex Mono" ];
      sansSerif = [ "IBM Plex Sans" ];
      serif =     [ "IBM Plex Serif" ];
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
