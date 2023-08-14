#/vendor/bin/sh

sleep 5

startlog_flag=`getprop persist.vendor.asus.startlog`
if test "$startlog_flag" -eq 0; then
echo 0 > /sys/fs/selinux/log
else
echo 1 > /sys/fs/selinux/log
fi

