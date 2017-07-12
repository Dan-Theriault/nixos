{ pkgs, config, lib, ... }:

let
  texOverride = ( pkg: if ( builtins.hasAttr "urls" pkg ) 
    then lib.overrideDerivation pkg ( oldAttrs: {
      urls = [ ( builtins.replaceStrings
        [ "http://lipa.ms.mff.cuni.cz/~cunav5am/nix/texlive-2016/" ]
        [ "http://146.185.144.154/texlive-2016/" ]
        ( builtins.elemAt oldAttrs.urls 0 )
      ) ];
    } )
    else pkg
  );
in {

  nixpkgs.config.packageOverrides = pkgs: {
    texlive = lib.mapAttrs ( name: value: 
      if builtins.typeOf value == "set" 
        then lib.mapAttrs ( n: v: (
          if builtins.typeOf v == "list"
            then map texOverride v else v) 
        ) value
        else value
    ) pkgs.texlive;
  };
  environment.systemPackages = ( with pkgs; [
    # ( texlive.combine {
    #   inherit (texlive) scheme-medium
    #   xetex latexmk
    #   beamer
    #   bibtex biblatex biber biblatex-ieee

    #   moresize
    #   csquotes
    #   wrapfig
    #   fontspec
    #   microtype
    #   xcolor

    #   gfsdidot crimson
    #   ;
    # } )
  ] );
}
