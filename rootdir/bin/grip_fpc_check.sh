#!/vendor/bin/sh

export PATH=/vendor/bin
GRIP_CAL_FILE="/vendor/factory/snt_reg_init"
GRIP_GOLDEN_CAL_FILE="/vendor/etc/grip_cal/snt_reg_init_golden_ER"
GRIP_GOLDEN_CAL_ID0_FILE="/vendor/etc/grip_cal/snt_reg_init_golden_id0"
GRIP_CAL_VERSION_FILE="/vendor/factory/fw_version.txt"
GRIP_PANEL_FILE="/vendor/factory/grip_panel_id"
CUR_PANEL_FILE="/proc/lcd_unique_id"
GRIP_CAL_DATA_READ="/proc/driver/grip_cal_read"
GRIP_APPLY_GOLDEN=0
GRIP_CHECK_K_VERSION="149"
GRIP_ID_PATH="/proc/driver/grip_id_status"
COUNT=0

Apply_Golden(){
	cat $GRIP_GOLDEN_CAL_FILE > /proc/driver/Grip_ReadK
}

Apply_Golden_ID0(){
	cat $GRIP_GOLDEN_CAL_ID0_FILE > /proc/driver/Grip_ReadK
}

Read_K_data(){
	cat $GRIP_CAL_FILE > /proc/driver/Grip_ReadK
}

Check_Cal_File(){
	if [ -f $GRIP_CAL_FILE ]; then
		setprop vendor.grip.calibration.file "Exist"
	else
		GRIP_APPLY_GOLDEN=`expr $GRIP_APPLY_GOLDEN + 1`
		setprop vendor.grip.calibration.file "None"
	fi
}

Check_Zero_String(){
	while [ COUNT != ]
	do
		if [ "0" == "$TEMP_STR" ]; then
			COUNT=`expr $COUNT + 1`
			TEMP_STR=`echo ${GRIP_K_VER_STR:$COUNT:1}`
			echo ===$TEMP_STR
		else
			COUNT=2000
		fi
	done
}
Check_Cal_Version(){
	if [ -f $GRIP_CAL_VERSION_FILE ]; then
		setprop vendor.grip.fw_version.file "Exist"
		GRIP_K_VER_STR=`cat $GRIP_CAL_VERSION_FILE | grep "FW Version"`
		echo $GRIP_K_VER_STR
		GRIP_K_VER_STR=`echo $GRIP_K_VER_STR | cut -d '.' -f3`
		echo $GRIP_K_VER_STR
		TEMP_STR=`echo ${GRIP_K_VER_STR:$COUNT:1}`
		#echo $TEMP_STR
		while [ "0" == "$TEMP_STR" ]
		do
			COUNT=`expr $COUNT + 1`
			TEMP_STR=`echo ${GRIP_K_VER_STR:$COUNT:1}`
			#echo ===$TEMP_STR
		done
		GRIP_K_VER_STR=`echo ${GRIP_K_VER_STR:$COUNT:3}`
		setprop vendor.grip.K.fw_ver.file "$GRIP_K_VER_STR"
		if [ $GRIP_K_VER_STR -gt $GRIP_CHECK_K_VERSION ]; then
			echo "$GRIP_K_VER_STR > $GRIP_CHECK_K_VERSION, Read K data"
			setprop vendor.grip.K.fw_ver.result "K_fw_version > $GRIP_CHECK_K_VERSION, good"
		else
			echo "$GRIP_K_VER_STR <= $GRIP_CHECK_K_VERSION, Apply golden!"
			GRIP_APPLY_GOLDEN=`expr $GRIP_APPLY_GOLDEN + 1`
			setprop vendor.grip.K.fw_ver.result "K_fw_version <= $GRIP_CHECK_K_VERSION, bad K version"
		fi
	else
		echo "No file"
		Apply_Golden
		setprop vendor.grip.fw_version.file "None"
	fi
}
Check_Panel_ID(){
	if [ -f "$GRIP_PANEL_FILE" ]; then
		setprop vendor.grip.panel_file "exist"
		Panel_ID_now="`cat $CUR_PANEL_FILE`"
		Panel_ID_orig="`cat $GRIP_PANEL_FILE`"
		setprop vendor.grip.panel.now.id $Panel_ID_now
		setprop vendor.grip.panel.orig.id $Panel_ID_orig
		echo "orig:$Panel_ID_orig now:$Panel_ID_now"
		if [ "$Panel_ID_orig" == "$Panel_ID_now" ]; then
			setprop vendor.grip.panel.changed 0
			echo "panel id not change"
		else
			setprop vendor.grip.panel.changed 1
			GRIP_APPLY_GOLDEN=`expr $GRIP_APPLY_GOLDEN + 1`
			echo "get changed panel id"
		fi
	else
		# if no panel_id, skip panel_id check
		setprop vendor.grip.panel_file "None"
	fi
}

Read_Cal_Data(){
	cal_data="`cat $GRIP_CAL_DATA_READ`"
	cala_part1=`echo $cal_data | cut -d '&' -f1`
	cala_part2=`echo $cal_data | cut -d '&' -f2`
	calc=`echo $cal_data | cut -d '&' -f3`
	calb=`echo $cal_data | cut -d '&' -f4`
	setprop vendor.grip.CalDataA1 $cala_part1
	setprop vendor.grip.CalDataA2 $cala_part2
	setprop vendor.grip.CalDataC $calc
	setprop vendor.grip.CalDataB $calb
	setprop vendor.grip.CalData5 1
}
##############################################
########## Apply Calibration data ############
##############################################
Check_Cal_File
Check_Cal_Version
Check_Panel_ID

##### Read ID #####
GRIP_ID_STATUS="`cat $GRIP_ID_PATH`"
setprop vendor.grip.id.status $GRIP_ID_STATUS

if [ $GRIP_APPLY_GOLDEN -eq 0 ]; then
	setprop vendor.grip.apply_golden 0
	Read_K_data
else
	setprop vendor.grip.apply_golden 1
	if [ $GRIP_ID_STATUS -eq 1 ]; then
		Apply_Golden
	else
		Apply_Golden_ID0
	fi
fi

##### Check FW Result #####
FW_Check="`cat /proc/driver/grip_fw_result`"
setprop vendor.grip.fw.result $FW_Check
#setprop grip.fw.result $FW_Check

#### Check FW Version #### 
echo "setprop fw_result"
FW_VER="`cat /proc/driver/grip_fw_ver| cut -d ":" -f 2`"
FW_VER=`echo $FW_VER | cut -d ' ' -f 1`
setprop vendor.grip.fw.version $FW_VER
#setprop grip.fw.version $FW_VER

#### Check FPC Status ####
Bar0="`cat /proc/driver/Grip_FPC_Check`"
setprop vendor.grip.bar.result $Bar0
if [ "$Bar0" == "0xffff" ]; then
    setprop vendor.grip.bar.status 1
else
    setprop vendor.grip.bar.status 0
fi

#### Check Golden K apply status ####
setprop vendor.grip.b0.30N.val $B0_F
setprop vendor.grip.b1.30N.val $B1_F

#### Read Cal Data ####
Read_Cal_Data
