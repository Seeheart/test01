#!/bin/bash
cp /etc/sysconfig/network-scripts/ifcfg-ens33 /etc/sysconfig/network-scripts/ens33.bak
sed -i  's/dhcp/static/' /etc/sysconfig/network-scripts/ifcfg-ens33
sed -i '/^UUID/d' /etc/sysconfig/network-scripts/ifcfg-ens33

echo -n "Please enter IPADDR: " 
read ip
sed -i 's/IPADDR=/IPADDR='$ip'/' /etc/sysconfig/network-scripts/ifcfg-ens33
echo -n "Please enter GATEWAY: "
read ga
sed -i 's/GATEWAY=/GATEWAY='$ga'/' /etc/sysconfig/network-scripts/ifcfg-ens33
sed -i 's/DNS1=/DNS1='$ga'/' /etc/sysconfig/network-scripts/ifcfg-ens33
echo -n "Please enter DNS2: "
read d2
sed -i 's/DNS2=/DNS2='$d2'/' /etc/sysconfig/network-scripts/ifcfg-ens33

systemctl stop NetworkManager
systemctl disable NetworkManager
systemctl restart network

echo -n "Please enter Hostname: "
read na
hostnamectl set-hostname $na
bash


