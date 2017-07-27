#!/usr/bin/env bash
{
  action=$( echo 'Suspend,Lock,Hibernate,Logout,Restart,Shutdown' | rofi -dmenu -sep ',' -p 'System:' -i -no-custom)
} && {
  case $action in 
      Suspend) systemctl suspend && i3lock-fancy -f Overpass-Black -t "TYPE TO UNLOCK" -- maim -u && sleep 2 && ~/Scripts/resume.sh;;
      Lock) i3lock-fancy -f Overpass-Black -t "TYPE TO UNLOCK" -- maim -u && ~/Scripts/resume.sh;;
      Hibernate) systemctl hibernate;;
      Restart) systemctl reboot;;
      Logout) i3-msg exit;;
      Shutdown) systemctl poweroff;;
      # *) break;;
  esac
}
