{ config, pkgs,
  terminal ? ''${pkgs.alacritty}/bin/alacritty --config-file \
    ${pkgs.writeText "alacritty.yml" (import ../dots/alacritty.nix {inherit config pkgs;})
  }'',
  shell ? "${pkgs.fish}/bin/fish",
  wallpaper ? "~/.wallpaper",
  isVm ? false,
  lockMessage ? "\"DO NOT DISTURB\""
}:

let
  waybarConfig = import ../dots/waybar.nix {inherit config pkgs;};
  theme = import ../theme.nix;
in
''
# i3 config file (v4)
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

# ======= OUTPUT =======
output * background ${wallpaper} fill
output * scale 2

# ======= INPUTS =======
input * xkb_layout us
input * xkb_options "compose:ralt,caps:escape"
input "Logitech USB Receiver Mouse" {
  pointer_accel 0.8
}

# ====== BINDINGS =======
set $mod Mod4
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec ${terminal} -e ${shell}
bindsym $mod+Shift+Return exec emacsclient -cne '(switch-to-buffer nil)'

# kill focused window
${if isVm then "bindsym $mod+Shift+c kill" else "bindsym $mod+Shift+q kill"}

# toggle scale
bindsym $mod+shift+s exec /etc/nixos/scripts/toggle-scale.sh

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

bindsym Alt+XF86AudioRaiseVolume exec pactl set-sink-volume 0 +5%
bindsym Alt+XF86AudioLowerVolume exec pactl set-sink-volume 0 +5%
bindsym Alt+XF86AudioMute exec pactl set-sink-mute 0 toggle

# Screen brightness controls
bindsym XF86MonBrightnessUp exec ${pkgs.light}/bin/light -A 2 # increase screen brightness
bindsym XF86MonBrightnessDown exec ${pkgs.light}/bin/light -U 2 # decrease screen brightness

# Media player controls
bindsym XF86AudioPlay exec ${pkgs.playerctl}/bin/playerctl play-pause 2> /dev/null 
bindsym XF86AudioNext exec ${pkgs.playerctl}/bin/playerctl next 2> /dev/null 
bindsym XF86AudioPrev exec ${pkgs.playerctl}/bin/playerctl previous 2> /dev/null 

# ====== ROFI ======
bindsym $mod+space exec rofi -show run
bindsym $mod+Shift+d exec rofi -show drun
bindsym $mod+w exec rofi -show window
bindsym $mod+Shift+x exec loginctl lock-session
bindsym $mod+c exec rofi -show calc -modi "calc:${pkgs.libqalculate}/bin/qalc +u8 -nocurrencies"

# ======= AUTORUNS =======
exec ${pkgs.waybar}/bin/waybar -c ${waybarConfig.config} -s ${waybarConfig.style}
exec ${pkgs.mako}/bin/mako
exec ${pkgs.xorg.xrdb}/bin/xrdb -load /etc/nixos/dots/Xresources
exec ${pkgs.swayidle}/bin/swayidle -w \
  timeout 600 '/etc/nixos/scripts/lock.sh' \
  lock '/etc/nixos/scripts/lock.sh' \
  before-sleep 'swaymsg "output * dpms off"' \
  after-resume 'swaymsg "output * dpms on"' 

# ======= APPEARANCE =======
font pango:IBMPlexMono 12, FontAwesome 10 # Font for window titles. 
default_border pixel
for_window [tiling] border pixel 3
for_window [floating] border pixel 7
gaps inner 7
gaps outer 0
smart_gaps off
smart_borders off

# ======= Colors
set $focused ${theme.cyan2}
set $unfocused ${theme.black2}
set $urgent ${theme.magenta2}

client.focused $focused $focused $focused $focused $focused 
client.focused_inactive $unfocused $unfocused $unfocused $unfocused $unfocused 
client.urgent $urgent $urgent $urgent $urgent $urgent 
client.unfocused $unfocused $unfocused $unfocused $unfocused $unfocused 
''
