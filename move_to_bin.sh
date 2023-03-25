#!/usr/bin/env sh

sudo rm -f /usr/local/bin/change_time
sudo cp ./change_time.sh /usr/local/bin/change_time 
sudo change_time --help >> /dev/null
if [[ $? == 0 ]]
then
    echo "✅ Updated script in /usr/local/bin ✅"
else
    echo "❌ Updated failed ❌"
fi