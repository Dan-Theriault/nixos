{ config, pkgs, ... }:

let
  name = "BlueJ-${version}";
  version = "4.1.2";
  jar = pkgs.fetchurl {
    url = "https://www.bluej.org/download/files/BlueJ-generic-412.jar";
    sha256 = "1l1shlji33j861jiblrgx3n2mch9a8djflm4jn0jyc8i55fz3y9h";
  };
  BlueJ = pkgs.stdenv.mkDerivation rec {
    inherit name;
    inherit version;

    unpackPhase = "true";

    buildInputs = [ pkgs.oraclejdk pkgs.makeWrapper ];

    installPhase = ''
      mkdir -p $out/lib
      cp ${jar} $out/lib/${name}.jar

      mkdir -p $out/bin
      makeWrapper ${pkgs.oraclejdk}/bin/java $out/bin/BlueJ \
      --add-flags "-jar $out/lib/${name}.jar"
    '';
  };
in
[ BlueJ ]

