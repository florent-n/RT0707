# How to use this script
Test on Ubuntu 18.04 LTS and 20.04 LTS
First task :
```
sudo apt-get install lxc git openvswitch-switch
sudo service openvswitch-switch
```

You need to have a LXC install and a container with the name "template". To do that, you can :
```
sudo lxc-create -t download -n template -- -d alpine -r edge -a amd64 --keyserver hkp://p80.pool.sks-keyservers.net:80
```
After this command, you will have 
```
NAME         STATE   AUTOSTART GROUPS IPV4                                    IPV6 UNPRIVILEGED 
template     STOPPED 0         -      -                                       -    false
```

You need also a bridge with the name adm-iot
```
sudo brctl addbr adm-iot
```
Clone this repository
```
git clone https://github.com/fnolot/RT0707.git
```

If you want to start only 1 group
```
cd ~/RT0707/default
sudo ./start-all.sh 1
```
The number of group you can start is between 1 and 25. The first group will have all their container in network 10.22.135.1 to 10.22.135.8, the group 2 in the range 10.22.135.11 to 10.22.135.18, and so on. So, the last group, the 25th, the range 10.22.135.241 to 10.22.135.248

You will have after 1 or 2 minutes something like that :
```
NAME         STATE   AUTOSTART GROUPS IPV4                                    IPV6 UNPRIVILEGED 
auto-1       RUNNING 0         -      10.22.135.1, 172.19.1.1                 -    false        
buffer-1     RUNNING 0         -      10.22.135.6, 172.19.16.19, 172.19.32.34 -    false        
camion-1     RUNNING 0         -      10.22.135.3, 172.19.1.3                 -    false        
evt-1        RUNNING 0         -      10.22.135.5, 172.19.16.17, 172.19.2.2   -    false        
moto-1       RUNNING 0         -      10.22.135.2, 172.19.1.2                 -    false        
passerelle-1 RUNNING 0         -      10.22.135.4, 172.19.1.4, 172.19.2.1     -    false        
srv_backup-1 RUNNING 0         -      10.22.135.8, 172.19.32.8                -    false        
srv_web-1    RUNNING 0         -      10.22.135.7, 172.19.16.18, 172.19.32.33 -    false        
template     STOPPED 0         -      -                                       -    false
```