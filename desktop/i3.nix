{ config, pkgs,
  terminal ? "${pkgs.xst}/bin/st",
  shell ? "${pkgs.fish}/bin/fish",
  wallpaper ? "~/.wallpaper",
  isVm ? false,
  lockMessage ? "\"DO NOT DISTURB\""
}:

''
# i3 config file (v4)
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod4
# Font for window titles. 
font pango:IBMPlexMono 12, FontAwesome 10

# start a terminal
bindsym $mod+Return exec ${terminal} -e ${shell}
bindsym $mod+Shift+Return exec emacsclient -cne '(switch-to-buffer nil)'

# kill focused window
${if isVm then "bindsym $mod+Shift+c kill" else "bindsym $mod+Shift+q kill"}

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# split in horizontal orientation
bindsym $mod+b split horizontal

# split in vertical orientation
bindsym $mod+v split vertical

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+t layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
# bindsym $mod+space focus mode_toggle

# ======== WORKSPACE SETTINGS =======
set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"
set $ws6 "6"
set $ws7 "7"
set $ws8 "8"
set $ws9 "9"
set $ws0 "10"

# switch to workspace
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8
bindsym $mod+9 workspace $ws9
bindsym $mod+0 workspace $ws0

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4
bindsym $mod+Shift+5 move container to workspace $ws5
bindsym $mod+Shift+6 move container to workspace $ws6
bindsym $mod+Shift+7 move container to workspace $ws7
bindsym $mod+Shift+8 move container to workspace $ws8
bindsym $mod+Shift+9 move container to workspace $ws9
bindsym $mod+Shift+0 move container to workspace $ws0

# ===================================

# reload the configuration file
# bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym h resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym j resize shrink height 10 px or 10 ppt
        bindsym l resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

# ======= HARDWARE KEY CONTROLS =======

# Audio controls
bindsym XF86AudioRaiseVolume exec amixer -q set Master 1%+
bindsym XF86AudioLowerVolume exec amixer -q set Master 1%-
bindsym XF86AudioMute exec amixer -q set Master toggle

bindsym Alt+XF86AudioRaiseVolume exec pactl set-sink-volume 2 +5%
bindsym Alt+XF86AudioLowerVolume exec pactl set-sink-volume 2 +5%
bindsym Alt+XF86AudioMute exec pactl set-sink-mute 2 toggle

# Screen brightness controls
bindsym XF86MonBrightnessUp exec ${pkgs.light}/bin/light -A 2 # increase screen brightness
bindsym XF86MonBrightnessDown exec ${pkgs.light}/bin/light -U 2 # decrease screen brightness

# Media player controls
bindsym XF86AudioPlay exec ${pkgs.playerctl}/bin/playerctl play-pause 2> /dev/null || mpc toggle
bindsym XF86AudioNext exec ${pkgs.playerctl}/bin/playerctl next 2> /dev/null || mpc next
bindsym XF86AudioPrev exec ${pkgs.playerctl}/bin/playerctl previous 2> /dev/null || mpc prev


# ====== ROFI ======
bindsym $mod+space exec rofi -show run
bindsym $mod+Shift+d exec rofi -show drun
bindsym $mod+w exec rofi -show window
bindsym $mod+Shift+x exec loginctl lock-session
bindsym $mod+c exec rofi -show calc -modi "calc:qalc +u8 -nocurrencies"

# ======= AUTORUNS =======
exec_always ${pkgs.feh}/bin/feh --bg-fill ${wallpaper} &
exec_always ${pkgs.dunst}/bin/dunst -config /etc/nixos/dots/dunstrc
exec ${pkgs.xorg.xrdb}/bin/xrdb -load /etc/nixos/dots/Xresources
exec export KDEWM=${pkgs.i3-gaps}/bin/i3
exec export QT_QPA_PLATFORMTHEME="qt5ct"
${if isVm then "" else ''
  exec_always ${pkgs.xss-lock}/bin/xss-lock ${pkgs.writeScript "lock.fish" ''
    #!${pkgs.fish}/bin/fish
    ${pkgs.playerctl}/bin/playerctl pause
    ${pkgs.i3lock-fancy}/bin/i3lock-fancy -f Overpass-Black -t ${lockMessage} -- ${pkgs.maim}/bin/maim;
  '' }
'' }

# ======= APPEARANCE =======
for_window [class="^.*"] border pixel 6
gaps inner 0
gaps outer 9
smart_gaps on
smart_borders on

# ======= Plasma Integration
# Try to kill the wallpaper set by Plasma (it takes up the entire workspace and hides everythiing)
exec --no-startup-id wmctrl -c Plasma
for_window [title="Desktop — Plasma"] kill; floating enable; border none

## Avoid tiling popups, dropdown windows from plasma
# for the first time, manually resize them, i3 will remember the setting for floating windows
for_window [class="plasmashell"] floating enable;
for_window [class="Plasma"] floating enable; border none
for_window [title="plasma-desktop"] floating enable; border none
for_window [class="Klipper"] floating enable; border none
for_window [class="Kmix"] floating enable; border none
for_window [class="Plasmoidviewer"] floating enable; border none
for_window [class="krunner"] floating enable; border none
for_window [title="win7"] floating enable; border none

# ======= Colors
set $base0 #032c36
set $base1 #065f73
set $base2 #c2454e
set $base3 #ef5847
set $base4 #7cbf9e
set $base5 #a2d9b1
set $base6 #8a7a63
set $base7 #beb090
set $base8 #2e3340
set $base9 #61778d
set $baseA #ff5879
set $baseB #ff99a1
set $baseC #44b5b1
set $baseD #9ed9d8
set $baseE #f2f1b9
set $baseF #f6f6c9

client.focused $baseD $baseD $base0 $baseD
client.focused_inactive $base1 $base1 $base3 $base1
client.unfocused $base1 $base1 $base3 $base1
client.urgent $baseE $baseE $base0 $baseE
''
