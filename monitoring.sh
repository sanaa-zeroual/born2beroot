#!/bin/bash

fram=$(free -m | awk '$1 == "Mem:" {print $2"MB"}')
uram=$(free -m | awk '$1 == "Mem:" {print $3}')
pram=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
udisk=$(df -BM | grep '/dev/' | grep -v '/boot' | awk '{ut += $3} END {print ut}')
tdisk=$(df -BG | grep '/dev/' | grep -v '/boot' | awk '{ft += $2} END {printf("%dGB"), ft }')
pdisk=$(df -BM | grep '/dev/' | grep -v '/boot' | awk '{ut += $3} {ft+= $2} END {printf("%d%%"), ut/ft*100}')
wall "
	#Architecture: $(uname -a)
	#CPU physical: $(cat /proc/cpuinfo |grep processor | wc -l)
	#vCPU: $(nproc)
	#Memory Usage: $(echo "$uram/$fram ($pram%)")
	#Disk usage: $(echo "$udisk/$tdisk ($pdisk)")
	#cpu load: $(mpstat | grep all | awk '{VAR=100-($13)} END {printf("%.1f"), VAR}')
	#Last boot: $(who -b | awk '{print $3, $4}')
	#LVM use: $(if [ $(lsblk | grep -c "lvm") -gt 0 ]; then echo "yes" ; else echo "no" ; fi)
	#Connexions TCP: $(netstat -an | grep ESTABLISHED |  wc -l) ESTABLISHED
	#User Log: $(who |awk '{print $1}'|sort -u|wc -l)
	#Netwerk: IP $(hostname -I) ($(ip a | awk '/link\/ether/ {print $2}'))	#Sudo: $(journalctl -q _COMM=sudo | grep COMMAND |wc -l) cmd "

