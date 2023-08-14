#!/system/vendor/bin/sh

echo 1 > /sys/fs/selinux/log
startlog_flag=`getprop persist.vendor.asus.startlog`
/vendor/bin/disableSavelogPermissive.sh &

/system/bin/logcat  -b main -b system -b crash  -v threadtime -f /proc/last_logcat


