#!/usr/bin/env bash

red='\e[0;31m'
green='\e[0;32m'
blue='\e[0;34m'
NC='\e[0m'

echo -e "${red}set hosts${NC}"
sudo echo "33.33.33.33    oid.fico.com    oid" >> /etc/hosts

echo -e "${red}Yum Repositories for CentOS6 (x85_64)${NC}"
sudo rpm -Uvh http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
#sudo rpm -Uvh http://mirror.sysadminguide.net/centalt/repository/centos/6/x86_64/centalt-release-6-1.noarch.rpm
sudo rpm -Uvh http://repo.webtatic.com/yum/el6/latest.rpm

echo -e "${red}Install necessary package for oracle${NC}"
sudo yum -y update
sudo yum -y install wget vim xterm unzip xorg-x11-apps xorg-x11-xauth xorg-x11-utils xorg-x11-fonts-* java-1.7.0-openjdk-devel.x86_64
sudo yum -y install binutils compat-libstdc++-33 elfutils-libelf elfutils-libelf-devel glibc glibc-common glibc-devel gcc gcc-c++ libaio libaio-devel libgcc libstdc++ libstdc++-devel make sysstat unixODBC unixODBC-devel ksh

echo -e "${red}X11 Configuration${NC}"
sudo sed -i 's/#X11Forwarding yes/X11Forwarding yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#X11DisplayOffset/X11DisplayOffset/g' /etc/ssh/sshd_config
sudo sed -i 's/#X11UseLocalhost/X11UseLocalhost/g' /etc/ssh/sshd_config

echo -e "${red}Create oracle user group${NC}"
sudo groupadd oinstall
sudo groupadd dba
sudo useradd -g oinstall -G dba -d /home/oracle oracle
echo -e "oracle@dm1n\noracle@dm1n" | sudo passwd oracle

sudo mkdir -p /home/oracle/app
sudo chown -R oracle:oinstall /home/oracle/app
sudo chmod -R 775 /home/oracle/app

sudo mkdir -p /u01/app/oracle/product/11.2.0/dbhome_1
sudo chown -R oracle:oinstall /u01
sudo chmod -R 775 /u01

