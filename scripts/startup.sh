#!\usr\bin\env bash

# Display
redshift &

# Settings
# gnome-settings-daemon &
eval "$(/usr/bin/gnome-keyring-daemon --start)" &
export SSH_AUTH_SOCK

export QT_QPA_PLATFORMTHEME=gtk2

# Input
synclient VertScrollDelta=-110 HorizScrollDelta=-110
synclient TapButton1=1 TapButton2=3 TapButton3=2 #tap to click
synclient CoastingSpeed=0 #no coasting
synclient HorizTwoFingerScroll=1
setxkbmap -option compose:ralt

# Audio
pacmd load-module module-switch-on-connect

# PATH
#export PATH=$PATH:/usr/sbin:/sbin:$HOME/bin:/usr/local/bin:$HOME/Android/Sdk/platform-tools:

