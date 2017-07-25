with import <nixpkgs> {};

pkgs.writeText "i3Config" ''
    # i3 config file (v4)
    #
    # Please see http://i3wm.org/docs/userguide.html for a complete reference!

    set $mod Mod4
    # Font for window titles. Will also be used by the bar unless a different font
    # is used in the bar {} block below.
    font pango:Source Code Pro Light, FontAwesome 10

    # start a terminal
    bindsym $mod+Return exec termite -e fish

    # kill focused window
    bindsym $mod+Shift+q kill

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
    bindsym $mod+space focus mode_toggle

    # focus the parent container
    # bindsym $mod+a focus parent

    # focus the child container
    #bindsym $mod+d focus child

    # ======== WORKSPACE SETTINGS =======
    set $ws1 "1:desk"
    assign [class="google-chrome-beta"] $ws1
    assign [class="Firefox"] $ws1

    set $ws2 "2:term"
    # assign [class="Gnome-terminal"] $ws2

    set $ws3 "3:code"
    assign [class="jetbrains-studio"] $ws3
    assign [class="Atom"] $ws3
    assign [class="Gnome-builder"] $ws3

    set $ws4 "4:note"
    assign [class="Xournal"] $ws4

    set $ws5 "5:docs"

    set $ws6 "6:talk"
    assign [class="geary"] $ws6
    assign [class="Gnome-calendar"] $ws6
    assign [class="Gnome-contacts"] $ws6
    assign [class="Gnome-todo"] $ws6
    assign [class="evolution"] $ws6

    set $ws7 "7:pass"
    assign [class="Enpass-Desktop"] $ws7
    assign [class="Seahorse"] $ws7

    set $ws8 "8:read"
    assign [class="Liferea"] $ws8
    assign [class="Feedreader"] $ws8

    set $ws9 "9:game"
    # assign [class="Steam"] $ws9
    assign [class="stellaris"] $ws9
    assign [class="Civ5XP"] $ws9
    assign [class="eu4"] $ws9
    assign [class="Minetest"] $ws9

    set $ws0 "10:show"
    assign [class="mpv"] $ws0
    assign [class="nuvolaplayer3"] $ws0
    assign [class="netflix-nativefier-48dc18"] $ws0

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
    bindsym $mod+Shift+c reload
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

            # same bindings, but for the arrow keys
            #bindsym Left resize shrink width 10 px or 10 ppt
            #bindsym Down resize grow height 10 px or 10 ppt
            #bindsym Up resize shrink height 10 px or 10 ppt
            #bindsym Right resize grow width 10 px or 10 ppt

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
    bindsym XF86MonBrightnessUp exec light -A 1 # increase screen brightness
    bindsym XF86MonBrightnessDown exec light -U 1 # decrease screen brightness

    # Media player controls
    bindsym XF86AudioPlay exec playerctl play-pause
    bindsym XF86AudioNext exec playerctl next
    bindsym XF86AudioPrev exec playerctl previous

    # Fullscreen
    bindsym XF86Display fullscreen

    # Workspace sequencing
    bindsym $mod+Control+Left workspace prev
    bindsym $mod+COntrol+Right workspace next

    # ====== ROFI ======
    bindsym $mod+d exec rofi -show run
    bindsym $mod+Shift+d exec rofi -show combi
    bindsym $mod+w exec rofi -show window


    # ======= AUTORUNS =======
    exec_always feh --bg-fill /home/dtheriault3/Pictures/Wallpaper &
    # exec ~/Scripts/startup.sh
    # exec ~/Scripts/stylus-rc.sh
    # exec ~/bin/enpass &
    exec nm-applet &
    exec polybar main &

    # ======= APPEARANCE =======
    for_window [class="^.*"] border pixel 1

    # ~/.i3/config
    # i3 config template
    # Base16 Ashes by Jannik Siebert (https://github.com/janniks)
    # template by Matt Parnell, @parnmatt

    set $base00 #1C2023
    set $base01 #393F45
    set $base02 #565E65
    set $base03 #747C84
    set $base04 #ADB3BA
    set $base05 #C7CCD1
    set $base06 #DFE2E5
    set $base07 #F3F4F5
    set $base08 #C7AE95
    set $base09 #C7C795
    set $base0A #AEC795
    set $base0B #95C7AE
    set $base0C #95AEC7
    set $base0D #AE95C7
    set $base0E #C795AE
    set $base0F #C79595

    client.focused $base0D $base0D $base00 $base01
    client.focused_inactive $base02 $base02 $base03 $base01
    client.unfocused $base01 $base01 $base03 $base01
    client.urgent $base02 $base08 $base07 $base08
  ''

