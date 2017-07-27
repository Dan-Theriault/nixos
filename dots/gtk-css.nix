with import <nixpkgs> {};

pkgs.writeText "gtkcssConfig" ''
  VteTerminal, vte-terminal {
    padding: 10px;
  }
''
