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
if [ $# != 1 ]; then
echo "Usage: $0 Num_Groupe"
else 
OBJ=( auto moto camion )
CREATE_1NET="./create-1net.sh"
CREATE_2NET="./create-2net.sh"
WORKING_DIR="lxc"
ADM_NET="10.22.135"
DATA_NET1="172.19.1"
DATA_NET2="172.19.2"
DATA_NET3="172.19.16"
DATA_NET4="172.19.32"
#Number of group you wanted
NB=$1

#if [ ! -e $WORKING_DIR ]; then
#	mkdir $WORKING_DIR
#else
#	rm $WORKING_DIR/*
#fi;

GRP_NUM=1
#Create each conf file for each LXC

while [ $GRP_NUM -le $NB ]
do
	j=1;
	echo "Start Group number $GRP_NUM"
	ovs-vsctl --may-exist add-br lxc-ovs$GRP_NUM
	for i in "${OBJ[@]}"
	do

	case $i in
	auto) 	DELAY=500
		LOSS=10;;
	moto) 	DELAY=1500
		LOSS=50;;
	camion) DELAY=100 
		LOSS=0;;
	*) 	DELAY=0
		LOSS=0;;

	esac
#		$CREATE_1NET lxc/$i-$GRP_NUM.conf $ADM_NET.$(((GRP_NUM-1)*10+j)) 24 $DATA_NET1.$j 24 2 lxc-ovs$GRP_NUM $DELAY $LOSS
#		lxc-destroy -q -n $i-$GRP_NUM
#		lxc-copy -n template -N $i-$GRP_NUM
#		lxc-stop -n $i-$GRP_NUM
		lxc-start -n $i-$GRP_NUM -f lxc/$i-$GRP_NUM.conf
		echo "$i-$GRP_NUM" started
		j=$((j+1))
	done

	NAME=passerelle
#	$CREATE_2NET lxc/$NAME-$GRP_NUM.conf $ADM_NET.$(((GRP_NUM-1)*10+j)) 24 $DATA_NET1.4 24 $DATA_NET2.1 28 2 3 lxc-ovs$GRP_NUM $DELAY $LOSS
#	lxc-destroy -q -n $NAME-$GRP_NUM
#	lxc-copy -n template -N $NAME-$GRP_NUM
#	lxc-stop -n $NAME-$GRP_NUM
	lxc-start -n $NAME-$GRP_NUM -f lxc/$NAME-$GRP_NUM.conf
	echo "${NAME}-${GRP_NUM}" started
                j=$((j+1))

	NAME=evt
#	$CREATE_2NET lxc/$NAME-$GRP_NUM.conf $ADM_NET.$(((GRP_NUM-1)*10+j)) 24 $DATA_NET2.2 28 $DATA_NET3.17 28 3 4 lxc-ovs$GRP_NUM $DELAY $LOSS
#        lxc-destroy -q -n $NAME-$GRP_NUM
#        lxc-copy -n template -N $NAME-$GRP_NUM
#	lxc-stop -n $NAME-$GRP_NUM
	lxc-start -n $NAME-$GRP_NUM -f lxc/$NAME-$GRP_NUM.conf
	echo "${NAME}-${GRP_NUM}" started
                j=$((j+1))

	NAME=buffer
#	$CREATE_2NET lxc/$NAME-$GRP_NUM.conf $ADM_NET.$(((GRP_NUM-1)*10+j)) 24 $DATA_NET3.19 28 $DATA_NET4.34 28 4 5 lxc-ovs$GRP_NUM $DELAY $LOSS
#        lxc-destroy -q -n $NAME-$GRP_NUM
#        lxc-copy -n template -N $NAME-$GRP_NUM
#	lxc-stop -n $NAME-$GRP_NUM
	lxc-start -n $NAME-$GRP_NUM -f lxc/$NAME-$GRP_NUM.conf
	echo "${NAME}-${GRP_NUM}" started
                j=$((j+1))

	NAME=srv_web
#	$CREATE_2NET lxc/$NAME-$GRP_NUM.conf $ADM_NET.$(((GRP_NUM-1)*10+j)) 24 $DATA_NET3.18 28 $DATA_NET4.33 28 4 5 lxc-ovs$GRP_NUM $DELAY $LOSS
#        lxc-destroy -q -n $NAME-$GRP_NUM
#        lxc-copy -n template -N $NAME-$GRP_NUM
#	lxc-stop -n $NAME-$GRP_NUM
	lxc-start -n $NAME-$GRP_NUM -f lxc/$NAME-$GRP_NUM.conf
	echo "${NAME}-${GRP_NUM}" started
                j=$((j+1))

	NAME=srv_backup
#	$CREATE_1NET lxc/$NAME-$GRP_NUM.conf $ADM_NET.$(((GRP_NUM-1)*10+j)) 24 $DATA_NET4.35 28 5 lxc-ovs$GRP_NUM $DELAY $LOSS
#        lxc-destroy -q -n $NAME-$GRP_NUM
#        lxc-copy -n template -N $NAME-$GRP_NUM
#	lxc-stop -n $NAME-$GRP_NUM
	lxc-start -n $NAME-$GRP_NUM -f lxc/$NAME-$GRP_NUM.conf
	echo "${NAME}-${GRP_NUM}" started
        j=$((j+1))

	GRP_NUM=$((GRP_NUM+1))
done;
fi;
