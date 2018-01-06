#!/usr/bin/env bash
{
  action=$( echo 'Suspend,Lock,Hibernate,Logout,Restart,Shutdown' | rofi -dmenu -sep ',' -p 'System:' -i -no-custom)
} && {
  case $action in 
      Suspend) systemctl suspend;;
      Lock) loginctl lock-session;;
      Hibernate) systemctl hibernate;;
      Restart) systemctl reboot;;
      Logout) i3-msg exit;;
      Shutdown) systemctl poweroff;;
  esac
}
