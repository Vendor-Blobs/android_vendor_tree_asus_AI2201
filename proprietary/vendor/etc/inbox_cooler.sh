#!/vendor/bin/sh

dongle_type=`getprop vendor.asus.dongletype`
csc_test_val=`getprop persist.vendor.asus.coolerstage_csc`

if [ "$csc_test_val" == "0" ] || [ "$csc_test_val" == "45" ]; then
	echo "[ROG6_INBOX] CSC set cooler stage to $csc_test_val, skip command from AC" > /dev/kmsg
	exit
fi

if [ "$dongle_type" == "1" -o "$dongle_type" == "8" ]; then
	cooler_stage=`getprop persist.vendor.asus.coolerstage`
	echo "[ROG6_INBOX] set cooler stage = $cooler_stage" > /dev/kmsg
	
	if [ "$cooler_stage" == "0" ]; then
		echo 0 > /sys/class/leds/aura_inbox/cooling_en
	else
		echo 1 > /sys/class/leds/aura_inbox/cooling_en
		sleep 0.1
		echo $cooler_stage > /sys/class/leds/aura_inbox/cooling_stage
	fi
fi

