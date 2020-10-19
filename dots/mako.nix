{config, pkgs}:
let
  theme = import ../theme.nix;
in
''
max-history=20
layer=overlay
anchor=top-center
font=sans-serif 10
background-color=${theme.background}
text-color=${theme.foreground}
border-color=${theme.highlight1}
border-size=2
width=240
height=100
icons=1
markup=1
actions=1
history=1
''
