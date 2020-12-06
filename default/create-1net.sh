#!/bin/bash
if [ $# != 9 ]; then 
	echo "Usage: $0 filename admin_ip admin_ip_mask data_ip data_ip_mask vlan_number data_bridge delay loss"
else
	FILE="$1"
	BASENAME=`basename $FILE`
	NAME=${BASENAME%.*}
	SOURCE="template-1NET.conf"
ADMIN_IP=$2
ADMIN_MASK=$3
DATA_IP=$4
DATA_MASK=$5
VLAN=$6
BRIDGE=$7
DELAY=$8
LOSS=$9
sed  -e "s/XVLANY/$VLAN/g" -e "s/NAME-CONT/$NAME/g" -e "s/IP-ADM/$ADMIN_IP\/$ADMIN_MASK/g" -e "s/IP-DATA/$DATA_IP\/$DATA_MASK/g" ${SOURCE} > $FILE
PASS="`pwd`/ifup-vlan_obj"
PASS_FINAL="${PASS//\//\\\/}"
sed -i "s/IFUP_SCRIPT/$PASS_FINAL/g" $FILE
sed -i "s/BRIDGE_PARAM/$BRIDGE/g" $FILE

	if [ $DELAY != 0 ]; then
	        sed -i "s/DELAY_PARAM/$DELAY/g" $FILE
	else
	        sed -i "s/DELAY_PARAM/0/g" $FILE
	fi;

	if [ $LOSS != 0 ]; then
		sed -i "s/LOSS_PARAM/$LOSS/g" $FILE
	else
	        sed -i "s/LOSS_PARAM/0/g" $FILE
	fi;

fi;
