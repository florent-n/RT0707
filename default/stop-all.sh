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
WORKING_DIR="lxc"
#Number of group you wanted
NB=$1

#Create each conf file for each LXC
GRP_NUM=1
j=1;
while [ $GRP_NUM -le $NB ]
do
	for i in "${OBJ[@]}"
	do
		lxc-stop -q -n $i-$GRP_NUM
		lxc-destroy -q -n $i-$GRP_NUM
		j=$((j+1))
	done

	NAME=passerelle
	lxc-stop -q -n $NAME-$GRP_NUM
	lxc-destroy -q -n $NAME-$GRP_NUM

	NAME=evt
	lxc-stop -q -n $NAME-$GRP_NUM
        lxc-destroy -q -n $NAME-$GRP_NUM

	NAME=buffer
	lxc-stop -q -n $NAME-$GRP_NUM
        lxc-destroy -q -n $NAME-$GRP_NUM

	NAME=srv_web
	lxc-stop -q -n $NAME-$GRP_NUM
        lxc-destroy -q -n $NAME-$GRP_NUM

	NAME=srv_backup
	lxc-stop -q -n $NAME-$GRP_NUM
        lxc-destroy -q -n $NAME-$GRP_NUM

	ovs-vsctl --if-exists del-br lxc-ovs$GRP_NUM

	GRP_NUM=$((GRP_NUM+1))
done;
fi;
