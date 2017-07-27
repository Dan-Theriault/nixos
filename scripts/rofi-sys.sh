#!/usr/bin/env bash
{
  action=$( echo 'Suspend,Lock,Hibernate,Logout,Restart,Shutdown' | rofi -dmenu -sep ',' -p 'System:' -i -no-custom)
} && {
  case $action in 
      Suspend) systemctl suspend && lock -f Source-Sans-Pro-Light -- maim && sleep 2 && ~/Scripts/resume.sh;;
      Lock) lock -f Iosevka -- maim && ~/Scripts/resume.sh;;
      Hibernate) systemctl hibernate;;
      Restart) systemctl reboot;;
      Logout) i3-msg exit;;
      Shutdown) systemctl poweroff;;
      # *) break;;
  esac
}
