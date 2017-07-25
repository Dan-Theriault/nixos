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


  [global/wm]
  margin-top = 5
  margin-bottom = 5


  [bar/main]
  width = 100%
  height = 35
  offset-x = 0
  offset-y = 0

  background = ''${colors.base00}
  foreground = ''${colors.base05}

  border-bottom-size = 0
  border-bottom-color = ''${colors.base05} 

  font-0 = Iosevka:size=11;0
  font-1 = FontAwesome:size=11;0

  modules-left = time i3 
  modules-right = volume backlight battery 

  tray-position = right
  tray-padding = 2


  [module/xwindow]
  type = internal/xwindow
  label = %title:0:20:...%
  label-foreground = ''${colors.dim}
  label-background = ''${colors.bg}
  label-padding = 3

  [module/i3]
  type = internal/i3
  format = <label-state> <label-mode>
  index-sort = true
  enable-click = true
  strip-wsnumbers = true

  label = %name%

  label-mode-foreground = ''${colors.base0F}

  label-focused-foreground = ''${colors.base0D}
  label-focused-padding = 1

  label-unfocused-foreground = ''${colors.dim}
  label-unfocused-padding = 1

  label-urgent-foreground = ''${colors.base0E}
  label-urgent-padding = 1


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
  toggle-on-foreground = ''${colors.primary}
  toggle-off-foreground = #66


  [module/backlight]
  type = internal/backlight
  card = intel_backlight
  label =   %percentage%
  label-foreground = ''${colors.base08}
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
  label-volume-foreground = ''${colors.base0C}
  label-volume-padding = 2

  label-muted =   %percentage%
  label-muted-foreground = ''${colors.base0C}
  label-muted-padding = 2


  [module/battery]
  type = internal/battery
  battery = BAT0
  adapter = ADP1
  full-at = 98

  format-charging = <label-charging>
  label-charging =   %percentage%
  label-charging-foreground = ''${colors.base0B}
  label-charging-padding = 2

  format-discharging = <ramp-capacity>  <label-discharging>
  format-discharging-foreground = ''${colors.base0B}
  format-discharging-padding = 2

  format-full = <ramp-capacity>  <label-full>
  format-full-foreground = ''${colors.base0B}
  format-full-padding = 2

  ramp-capacity-0 = 
  ramp-capacity-1 = 
  ramp-capacity-2 = 
  ramp-capacity-3 = 
  ramp-capacity-4 = 


  [module/powermenu]
  type = custom/menu

  label-open =  power
  label-open-foreground = ''${colors.secondary}
  label-close =  cancel
  label-close-foreground = ''${colors.secondary}
  label-separator = |
  label-separator-foreground = ''${colors.foreground-alt}

  menu-0-0 = reboot
  menu-0-0-exec = menu-open-1
  menu-0-1 = power off
  menu-0-1-exec = menu-open-2

  menu-1-0 = cancel
  menu-1-0-exec = menu-open-0
  menu-1-1 = reboot
  menu-1-1-exec = sudo reboot

  menu-2-0 = power off
  menu-2-0-exec = sudo poweroff
  menu-2-1 = cancel
  menu-2-1-exec = menu-open-0

  ; vim:ft=dosini
''
