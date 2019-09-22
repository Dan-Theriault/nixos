{ config, pkgs }:

let
  theme = import ../theme.nix;
in
''
Xft.dpi: 192

! special
*.foreground:   ${theme.foreground}
*.background:   ${theme.background}
*.cursorColor:  ${theme.foreground}

! black
*.color0:       ${theme.black1}
*.color8:       ${theme.black2}

! red
*.color1:       ${theme.red1}
*.color9:       ${theme.red2}

! green
*.color2:       ${theme.green1}
*.color10:      ${theme.green2}

! yellow
*.color3:       ${theme.yellow1}
*.color11:      ${theme.yellow2}

! blue
*.color4:       ${theme.blue1}
*.color12:      ${theme.blue2}

! magenta
*.color5:       ${theme.magenta1}
*.color13:      ${theme.magenta2}

! cyan
*.color6:       ${theme.cyan1}
*.color14:      ${theme.cyan2}

! white
*.color7:       ${theme.white1}
*.color15:      ${theme.white2}

! Rofi
#define rofibg ${theme.background}
#define rofifg ${theme.foreground}
#define clear #00000000
#define rofihl ${theme.highlight1}
/* #define rofihl #AA44b5b1 */
! State:           bg,    fg,     bgalt, hlbg,  hlfg
rofi.color-normal: clear, rofifg, clear, clear, rofihl
rofi.color-active: clear, rofifg, clear, clear, rofihl
!                  bg,     border  separator
rofi.color-window: rofibg, rofihl, rofihl
rofi.opacity: 100

rofi.bw: 10
rofi.lines: 7
rofi.columns: 1

rofi.location: 0
rofi.yoffset: 0
rofi.xoffset: 0

rofi.eh: 1
rofi.line-margin: 10
rofi.width: 47
rofi.padding: 80

rofi.combi-modi: run,window,drun
rofi.fuzzy: true

rofi.font: Sans 18
rofi.hide-scrollbar: true
rofi.separator-style: none

/* rofi.run-command: fish -c '{cmd}' */
/* rofi.run-list-command: 'fish -c functions' */

! xst configuration
st.font: Monospace:pixelsize=14
st.bold_font: 1
st.termname: st-256color
st.borderpx: 25
st.cursorshape: 1
''
