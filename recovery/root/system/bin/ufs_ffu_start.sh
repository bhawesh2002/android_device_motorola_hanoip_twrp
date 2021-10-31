#!/system/bin/sh
#
# Copyright (c) 2013-2019, Motorola LLC  All rights reserved.
#

SCRIPT=${0#/system/bin/}
MODEL=`cat /sys/block/sda/device/model | tr -d ' '`
REV=`cat /sys/block/sda/device/rev`

if [ "$MODEL" == "KLUBG4G1CE-B0B1" -o "$MODEL" == "KLUCG4J1CB-B0B1" ] ; then
	UFS_SIZE="32G"
	VENDOR="SAMSUNG"
elif [ "$MODEL" == "KLUCG4J1ED-B0C1" ] ; then
	UFS_SIZE="64G"
	VENDOR="SAMSUNG"
elif [ "$MODEL" == "KLUDG8V1EE-B0C1" ] ; then
	UFS_SIZE="128G"
	VENDOR="SAMSUNG"
elif [ "$MODEL" == "KM5V7001DM-B621" ] ; then
	UFS_SIZE="128G"
	VENDOR="SAMSUNG"
elif [ "$MODEL" == "SDINDDC4-128G" ] ; then
	UFS_SIZE="128G"
	VENDOR="WDC"
fi

FW_FILE=/vendor/firmware/$VENDOR-$MODEL-$UFS_SIZE.fw

# Flash the firmware
echo "Starting upgrade..." > /dev/kmsg
echo $FW_FILE > /dev/kmsg
sync
if [ "$VENDOR" == "WDC" ] ; then
	./system/bin/ufs_wd  ffu -t 0 -p ./dev/block/sda -w $FW_FILE
else
	/system/bin/sg_write_buffer -v -m dmc_offs_defer -I $FW_FILE  /dev/block/sda
fi

if [ $? -eq "0" ];then
	kmsg_print "UFS $FW_FILE updated done, reboot now !"
	sleep 1
	echo b >/proc/sysrq-trigger
else
	kmsg_print "Error: fails to send $FW_FILE "
fi
exit
