
{ config, pkgs }:

let
  theme = import ../theme.nix;
in
''
* {
  border: none;
  border-radius: 0;
  font-family: sans-serif;
  font-size: 24px;
  min-height: 0;
  color: ${theme.foreground};
}

window {
  margin: 2px;
  border: 8px solid ${theme.border};
  background-color: ${theme.black1};
}

#input {
  margin: 4px;
  background-color: ${theme.black1};
}

#inner-box {
  margin: 4px;
  background-color: ${theme.background};
}

#outer-box {
  margin: 2px;
  background-color: ${theme.black1};
}

#scroll {
  margin: 0px;
  border-top: 2px solid ${theme.border};
  background-color: ${theme.background};
}

#text {
  margin: 0px;
  background-color: ${theme.background};
}
''
