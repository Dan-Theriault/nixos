{ pkgs, config, lib, ... }:

{
  # services.nginx = { # Hopefully temporary override of the tex mirror
  #   enable = true;
  #   virtualHosts."lipa.ms.mff.cuni.cz".locations = let
  #     path = "/~cunav5am/nix/";
  #   in {
  #     ${path}.extraConfig = ''
  #       rewrite ^${path}(.*)$ http://146.185.144.154/$1 redirect;
  #     '';
  #   };
  # };

  environment.systemPackages = ( with pkgs; [
    pdfpc
    ( texlive.combine {
      inherit (texlive) 
      scheme-medium

      # XeTeX Compiler
      xetex xetex-def
      fontspec euenc

      # Compilation
      latexmk pdftex
      
      # Presentations
      beamer

      # Bibliography
      bibtex biblatex biber biblatex-ieee

      # Misc. Formatting
      moresize
      csquotes
      wrapfig
      microtype
      xcolor

      # Fonts - Internal tex fonts aren't working for some reason.
      # Debug later, use system fonts for now.
      # gfsdidot 
      # crimson

      # ???
      logreq xstring
      ;
    } )
    biber
    fontconfig
  ] );
}
