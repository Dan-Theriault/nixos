{ pkgs, config, lib, ... }:

{
  environment.systemPackages = ( with pkgs; [
    pdfpc
    ( texlive.combine {
      inherit (texlive) 
      scheme-full

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
      gfsdidot 
      crimson
      roboto

      # ???
      logreq xstring
      ;
    } )
    biber
    fontconfig
  ] );
}
