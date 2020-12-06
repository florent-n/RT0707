#!/bin/bash
./create-1net.sh template.conf 10.22.135.1 24 172.15.14.1 24 2 lxc-ovs1 0 0
ovs-vsctl add-br lxc-ovs1
lxc-start -n template -f template.conf -o template.log
lxc-ls -f

