with import <nixpkgs> {};

pkgs.writeText "gtkcssConfig" ''
  VteTerminal, vte-terminal {
    padding: 16px;
  }
''
