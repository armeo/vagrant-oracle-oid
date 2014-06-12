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

cd /etc/yum.repos.d
sudo wget http://public-yum.oracle.com/public-yum-ol6.repo
sudo wget http://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol6 -O /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
sudo yum install oracle-rdbms-server-11gR2-preinstall

echo -e "${red}Install necessary package for oracle${NC}"
sudo yum -y install wget vim xterm unzip xorg-x11-apps xorg-x11-xauth xorg-x11-utils xorg-x11-fonts-* java-1.7.0-openjdk-devel.x86_64
sudo yum -y install binutils compat-libstdc++-33 elfutils-libelf elfutils-libelf-devel glibc glibc-common glibc-devel gcc gcc-c++ libaio libaio-devel libgcc libstdc++ libstdc++-devel make sysstat unixODBC unixODBC-devel ksh
sudo yum -y update

echo -e "${red}X11 Configuration${NC}"
sudo sed -i 's/#X11Forwarding yes/X11Forwarding yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#X11DisplayOffset/X11DisplayOffset/g' /etc/ssh/sshd_config
sudo sed -i 's/#X11UseLocalhost/X11UseLocalhost/g' /etc/ssh/sshd_config

sudo echo "*          -       nproc     16384" >> /etc/security/limits.d/90-nproc.conf

echo -e "${red}change oracle password${NC}"
echo -e "oracle@dm1n\noracle@dm1n" | sudo passwd oracle

sudo mkdir -p /u01/app/oracle/product/11.2.0/dbhome_1
sudo chown -R oracle:oinstall /u01
sudo chmod -R 775 /u01

echo -e "${red}set oracle profile${NC}"
sudo su - oracle
cat >> .bash_profile << EOF

export TMP=/tmp
export TMPDIR=$TMP

export ORACLE_HOSTNAME=oid.fico.com
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_UNQNAME=orcl
export ORACLE_SID=orcl
export PATH=/usr/sbin:$PATH
export PATH=$ORACLE_HOME/bin:$PATH

export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

EOF
