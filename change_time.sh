#!/usr/bin/env sh

flag="$1"
tmp_notification_file="/tmp/change_time_notification.txt"

set_time_to_target_time() {
  month_day=0206
  year=23
  current_hour_min=$(date +%H:%m | tr -d :)
  target_date="${month_day}${current_hour_min}${year}"
  sudo date $target_date >> /dev/null
}

case $flag in
  "--reset")
    echo "🔄 Resetting system time 🔄"
    if [[ -f $tmp_notification_file ]]; then 
      pid=$(cat $tmp_notification_file) 
      rm $tmp_notification_file
      echo "💀 killing background job ${pid} 💀"
      kill -9 $pid 
    fi
    sudo sntp -sS time1.facebook.com >> /dev/null
    echo "✅ Done ✅"
    ;;

  "--set")
    set_time_to_target_time
    (while true; do 
      current_time=$(date +%Y-%m-%d)
      if [[ $current_time != "2023-02-06" ]]; then
        set_time_to_target_time
        osascript -e 'display notification "Time was reset unintentionally" with title "Changed time"'
      fi
      sleep 5
    done) &
    
    echo $! >> $tmp_notification_file
    echo "🕣 Set system time 🕞"
    ;;

  *)
    echo "__________________________________________________"
    echo "   --reset     | set systime to time1.facebook.com"
    echo "   --set       | set time February 6th"
    echo "   --*         | print help menu"
    ;;
esac