#!/vendor/bin/sh

#setprop vendor.sys.asus.setenforce 1
#echo "[check key status] setenforce: permissive" > /proc/asusevtlog
sleep 5
echo 1 > /sys/fs/selinux/log
startlog_flag=`getprop persist.vendor.asus.startlog`
setprop vendor.atd.keybox.ready false

/vendor/bin/is_keybox_valid
#/vendor/bin/is_keymaster_valid
#/vendor/bin/is_hdcp_valid
#/vendor/bin/check_widevine_level

#ret=$(/vendor/bin/hdcp2p2prov -verify)
#if [ "${ret}" = "Verification succeeded. Device is provisioned." ]; then
#	setprop "vendor.atd.hdcp2p2.ready" TRUE
#else
#	setprop "vendor.atd.hdcp2p2.ready" FALSE
#fi

#ret=$(/vendor/bin/hdcp1prov -verify)
#if [ "${ret}" = "Verification succeeded. Device is provisioned." ]; then
#	setprop "vendor.atd.hdcp1.ready" TRUE
#else
#	setprop "vendor.atd.hdcp1.ready" FALSE
#fi

ifaa_count=0
ifaa=`getprop vendor.asus.ifaa`
while [ "$ifaa" != "1" ] && [ $ifaa_count -le 10 ]; do
	sleep 1
	echo 1 > /sys/fs/selinux/log
	/vendor/bin/ifaa_product 2
       ifaa_count=$(($ifaa_count+1))
done

soter_count=0
soter=`getprop vendor.asus.soter`
while [ "$soter" != "1" ] && [ $soter_count -le 10 ]; do
	sleep 1
	echo 1 > /sys/fs/selinux/log
	/vendor/bin/vendor.qti.hardware.soter@1.0-provision 2
       soter_count=$(($soter_count+1))
done

i=0
Km=`getprop vendor.atd.keybox.ready`
while [ "$Km" != "TRUE" ] && [ $i -le 10 ]; do
	sleep 2
	echo 1 > /sys/fs/selinux/log
	/vendor/bin/is_keybox_valid
       i=$(($i+1))
done
#sleep 20

if test "$startlog_flag" -eq 0; then
echo 0 > /sys/fs/selinux/log
else
echo 1 > /sys/fs/selinux/log
fi
#echo 0 > /sys/fs/selinux/log

#setprop vendor.sys.asus.setenforce 0
#echo "[check key status] setenforce: enforcing" > /proc/asusevtlog
