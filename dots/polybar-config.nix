with import <nixpkgs> {};

pkgs.writeText "PolybarConfig" ''
  ;=====================================================
  ;
  ;   To learn more about how to configure Polybar
  ;   go to https://github.com/jaagr/polybar
  ;
  ;   The README contains alot of information
  ;
  ;=====================================================

  [colors]
  base00 = #1C2023 
  base01 = #393F45
  base02 = #565E65
  base03 = #747C84
  base04 = #ADB3BA
  base05 = #C7CCD1
  base06 = #DFE2E5
  base07 = #F3F4F5
  base08 = #C7AE95
  base09 = #C7C795
  base0A = #AEC795
  base0B = #95C7AE
  base0C = #95AEC7
  base0D = #AE95C7
  base0E = #C795AE
  base0F = #C79595

  bg = ''${self.base00}
  fg = ''${self.base06}
  dim = ''${self.base03}
  hl = ''${self.base0B}

  [global/wm]
  margin-top = 2
  margin-bottom = 2


  [bar/main]
  bottom = true
  # offset-x = 6
  # offset-y = 6
  # width = 1908
  height = 33


  fixed-center = false
  # override-redirect = true
  # wm-restack = true

  background = ''${colors.base00}
  foreground = ''${colors.base05}

  border-top-color = ''${colors.hl}
  border-top-size = 1
  border-bottom-color = ''${colors.hl}
  border-bottom-size = 0
  border-left-color = ''${colors.hl}
  border-left-size = 0
  border-right-color = ''${colors.hl}
  border-right-size = 0

  font-0 = Overpass:style=Semibold:size=11;0
  font-1 = FontAwesome:size=11;0

  modules-left = time mpd
  modules-center = i3
  modules-right = volume backlight battery 

  tray-position = right
  tray-padding = 2


  [module/xwindow]
  type = internal/xwindow
  label = %title:0:20:...%
  label-foreground = ''${colors.bg}
  label-background = ''${colors.base07}
  label-padding = 3

  [module/i3]
  type = internal/i3
  format = <label-state> <label-mode>
  index-sort = true
  enable-click = true
  strip-wsnumbers = true

  label = %name%

  label-mode-foreground = ''${colors.dim}

  label-focused-foreground = ''${colors.bg}
  label-focused-background = ''${colors.hl}
  label-focused-padding = 3

  label-unfocused = %name:0:1%
  label-unfocused-foreground = ''${colors.fg}
  label-unfocused-padding = 3

  label-urgent-foreground = ''${colors.base0E}
  label-urgent-padding = 3


  [module/mpd]
  type = internal/mpd
  format-online = <label-song>  <icon-prev> <icon-seekb> <icon-stop> <toggle> <icon-seekf> <icon-next>  <icon-repeat> <icon-random>
  label-song-maxlen = 25
  label-song-ellipsis = true
  icon-prev = 
  icon-seekb = 
  icon-stop = 
  icon-play = 
  icon-pause = 
  icon-next = 
  icon-seekf = 
  icon-random = 
  icon-repeat = 
  toggle-off-foreground = #66


  [module/backlight]
  type = internal/backlight
  card = intel_backlight
  label =   %percentage%
  label-padding = 2


  [module/cpu]
  type = internal/cpu
  interval = 2
  format-prefix = 
  label =   %percentage%
  label-padding = 2
  label-foreground = ''${colors.dim}


  [module/memory]
  type = internal/memory
  interval = 2
  label =   %percentage_used%
  label-padding = 2
  label-foreground = ''${colors.dim}


  [module/time]
  type = internal/date
  interval = 5
  time = %a, %b %d %H:%M
  label = %time%
  label-padding = 3


  [module/volume]
  type = internal/volume
  format-volume = <label-volume> 
  label-volume =   %percentage% 
  label-volume-padding = 2
  label-muted =   %percentage%
  label-muted-padding = 2


  [module/battery]
  type = internal/battery
  battery = BAT0
  adapter = ADP1
  full-at = 98

  format-charging = <label-charging>
  label-charging =   %percentage%
  label-charging-padding = 2
  format-discharging = <ramp-capacity>  <label-discharging>
  format-discharging-padding = 2
  format-full = <ramp-capacity>  <label-full>
  format-full-padding = 2

  ramp-capacity-0 = 
  ramp-capacity-1 = 
  ramp-capacity-2 = 
  ramp-capacity-3 = 
  ramp-capacity-4 = 
''
