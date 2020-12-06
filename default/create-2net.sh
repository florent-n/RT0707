#!/bin/bash
#    Copyright (C) 2020 Florent NOLOT
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
###########################################################################
if [ $# != 12 ]; then
echo "Usage: $0 filename admin_ip mask data_ip1 mask data_ip2 mask vlan_number1 vlan_number2 data_bridge delay loss"
else
FILE="$1"
BASENAME=`basename $FILE`
NAME=${BASENAME%.*}
SOURCE="template-2NET.conf"
ADMIN_IP=$2
ADMIN_MASK=$3
DATA_IP1=$4
DATA_IP1_MASK=$5
DATA_IP2=$6
DATA_IP2_MASK=$7
VLAN1=$8
VLAN2=$9
BRIDGE=${10}
DELAY=${11}
LOSS=${12}

sed -e "s/XVLANY1/$VLAN1/g" -e "s/XVLANY2/$VLAN2/g" -e "s/NAME-CONT/$NAME/g" -e "s/IP-ADM/$ADMIN_IP\/$ADMIN_MASK/g" -e "s/IP-DATA1/$DATA_IP1\/$DATA_IP1_MASK/g" -e "s/IP-DATA2/$DATA_IP2\/$DATA_IP2_MASK/g" ${SOURCE} > $FILE

PASS="`pwd`/ifup-vlan_obj"
#WORK ONLY IN BASH
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
