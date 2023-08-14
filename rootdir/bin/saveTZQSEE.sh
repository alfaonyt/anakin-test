#!/vendor/bin/sh

# savelog

echo 1 > /sys/fs/selinux/log


timeout 1 cat /proc/tzdbg/log > /asdf/tz_log.txt
timeout 1 cat /proc/tzdbg/qsee_log > /asdf/qsee_log.txt


