#!/system/bin/sh

echo "PCBID TEST: +++"

rm /data/data/pcbid_status_str_tmp

PROP_STAGE=$(getprop ro.boot.id.stage)
PROP_PROJECT=$(getprop ro.boot.id.prj)

STAGE=
PROJECT=

case $PROP_PROJECT in
	"0" )
		PROJECT='ZS673KS_Entry'
		echo "PCBID TEST: PROJECT="$PROJECT
		;;
	"1" )
		PROJECT='ZS673KS_Ultimate/Elite'
		echo "PCBID TEST: PROJECT="$PROJECT
		;;
	"9" )
		PROJECT='ZS676KS_2.0C_Entry'
		echo "PCBID TEST: PROJECT="$PROJECT
		;;
	"a" | "A" )
		PROJECT='ZS676KS_2.0C_Ultimate/Elite'
		echo "PCBID TEST: PROJECT="$PROJECT
		;;
	"b" | "B" )
		PROJECT='ZS676KS_2.0A_Entry'
		echo "PCBID TEST: PROJECT="$PROJECT
		;;
	"c" | "C" )
		PROJECT='ZS676KS_2.0D_Entry'
		echo "PCBID TEST: PROJECT="$PROJECT
		;;
	"d" | "D" )
		PROJECT='ZS676KS_2.0D_Ultimate/Elite'
		echo "PCBID TEST: PROJECT="$PROJECT
		;;
	"e" | "E" )
		PROJECT='ZS676KS_PX_Entry'
		echo "PCBID TEST: PROJECT="$PROJECT
		;;
	"f" | "F" )
		PROJECT='ZS676KS_PX_Ultimate/Elite'
		echo "PCBID TEST: PROJECT="$PROJECT
		;;
	 *  )
		PROJECT='Unknown'
		echo $PROJECT
		;;
esac

if [ $PROP_PROJECT -ge A ] || [ $PROP_PROJECT -eq 9 ]; then
	case $PROP_STAGE in
		"0" )
			STAGE='ER'
			echo "PCBID TEST: STAGE="$STAGE
			;;
		"1" )
			STAGE='PR'
			echo "PCBID TEST: STAGE="$STAGE
			;;
		"2" )
			STAGE='MP'
			echo "PCBID TEST: STAGE="$STAGE
			;;
		 *  )
			STAGE='Unknown('$PROP_STAGE')'
			echo "PCBID TEST: STAGE="$STAGE
			;;
	esac
else
	case $PROP_STAGE in
		"0" )
			STAGE='EVB'
			echo "PCBID TEST: STAGE="$STAGE
			;;
		"1" )
			STAGE='EVB2'
			echo "PCBID TEST: STAGE="$STAGE
			;;
		"2" )
			STAGE='SR1'
			echo "PCBID TEST: STAGE="$STAGE
			;;
		"3" )
			STAGE='ER1'
			echo "PCBID TEST: STAGE="$STAGE
			;;
		"4" )
			STAGE='ER2'
			echo "PCBID TEST: STAGE="$STAGE
			;;
		"5" )
			STAGE='PR1'
			echo "PCBID TEST: STAGE="$STAGE
			;;
		"6" )
			STAGE='PR2'
			echo "PCBID TEST: STAGE="$STAGE
			;;
		"7" )
			STAGE='MP'
			echo "PCBID TEST: STAGE="$STAGE
			;;
		 *  )
			STAGE='Unknown('$PROP_STAGE')'
			echo "PCBID TEST: STAGE="$STAGE
			;;
	esac
fi

echo $PROJECT"_"$STAGE > /data/data/pcbid_status_str_tmp
chmod 00777 /data/data/pcbid_status_str_tmp

echo "PCBID TEST: ---"
