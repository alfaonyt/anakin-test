#!/system/vendor/bin/sh

echo 1 > /sys/fs/selinux/log
sleep 5
startlog_flag=`getprop persist.vendor.asus.startlog`

rm -rf /data/system/graphicsstats/*

if test "$startlog_flag" -eq 0; then
sleep 5
echo 0 > /sys/fs/selinux/log
else
echo 1 > /sys/fs/selinux/log
fi
