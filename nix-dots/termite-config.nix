with import <nixpkgs> {};

pkgs.writeText "TermiteConfig" ''
  [options]
  font = Source Code Pro 10
  allow_bold = true
  search_wrap = true
  scrollback = 20000

  [colors]
  # Base16 Ashes
  # Scheme: Jannik Siebert (https://github.com/janniks)

  foreground      = #C7CCD1
  foreground_bold = #C7CCD1
  cursor          = #C7CCD1
  background      = #1C2023

  # 16 color space
  color0  = #1C2023
  color1  = #C7AE95
  color2  = #95C7AE
  color3  = #AEC795
  color4  = #AE95C7
  color5  = #C795AE
  color6  = #95AEC7
  color7  = #C7CCD1
  color8  = #747C84
  color9  = #C7AE95
  color10 = #95C7AE
  color11 = #AEC795
  color12 = #AE95C7
  color13 = #C795AE
  color14 = #95AEC7
  color15 = #F3F4F5

  # 256 color space
  color16 = #C7C795
  color17 = #C79595
  color18 = #393F45
  color19 = #565E65
  color20 = #ADB3BA
  color21 = #DFE2E5
''
