with import <nixpkgs> {};

pkgs.writeText "XResources" ''
  ! Base16 Ashes
  ! Scheme: Jannik Siebert (https://github.com/janniks)

  #define base00 #1C2023
  #define base01 #393F45
  #define base02 #565E65
  #define base03 #747C84
  #define base04 #ADB3BA
  #define base05 #C7CCD1
  #define base06 #DFE2E5
  #define base07 #F3F4F5
  #define base08 #C7AE95
  #define base09 #C7C795
  #define base0A #AEC795
  #define base0B #95C7AE
  #define base0C #95AEC7
  #define base0D #AE95C7
  #define base0E #C795AE
  #define base0F #C79595

  *foreground:   base05
  *background:   base00
  *cursorColor:  base05

  *color0:       base00
  *color1:       base08
  *color2:       base0B
  *color3:       base0A
  *color4:       base0D
  *color5:       base0E
  *color6:       base0C
  *color7:       base05

  *color8:       base03
  *color9:       base09
  *color10:      base01
  *color11:      base02
  *color12:      base04
  *color13:      base06
  *color14:      base0F
  *color15:      base07

  ! vim: filetype=yaml
  ! rofi template
  ! Base16 Ashes Dark, by Jannik Siebert (https://github.com/janniks)

  ! State:           'bg',    'fg',   'bgalt',   'hlbg',  'hlfg'
  rofi.color-normal: #00000000, base05, #00000000, #00000000, base0B
  rofi.color-active: #00000000, base05, #00000000, #00000000, base0B
  !                  'bg',   'border'     'separator'
  rofi.color-window: base00, base0B, base0B
  rofi.opacity: 100

  rofi.bw: 2
  rofi.lines: 8
  rofi.columns: 1

  rofi.location: 7
  rofi.yoffset: -35
  rofi.xoffset: 0

  rofi.eh: 1
  rofi.line-margin: 10
  rofi.width: 18
  rofi.padding: 20

  rofi.combi-modi: run,window,drun
  rofi.fuzzy: true

  rofi.font: Overpass 14
  rofi.hide-scrollbar: true
  rofi.separator-style: none

  rofi.run-command: fish -c '{cmd}'
  rofi.run-list-command: 'fish -c functions'

  ! urxvt configuration
  urxvt.scrollBar: false
  urxvt.font: xft:Overpass:size=10
''
