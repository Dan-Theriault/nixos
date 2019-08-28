{ config, pkgs }:

with pkgs; [
    pdfpc
    ( texlive.combine {
      inherit (texlive) 
      scheme-medium

      # XeTeX Compiler
      xetex 
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

      gfsdidot 
      crimson
      roboto

      # Syntax Checking
      lacheck
      chktex

      # ???
      logreq xstring
      ;
    } )
    biber
    fontconfig
    proselint
]
