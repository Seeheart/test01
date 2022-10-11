#!/bin/bash

tar -xvf mysql-8.0.27-linux-glibc2.12-x86_64.tar.xz
mv  mysql-8.0.27-linux-glibc2.12-x86_64   mysql
mkdir /usr/local/mysql/data

groupadd mysql
useradd -g mysql mysql
chown mysql.mysql /usr/local/mysql

yum install  libaio-devel.x86_64 -y
cd /usr/local/mysql/mysql/bin
./mysqld --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data/ --initialize &>passwd.txt
tem_passwd=$(cat passwd.txt |grep "temporary"|awk '{print $NF}')

cat >/etc/my.cnf <<EOF
[mysqld]
basedir=/usr/local/mysql/mysql
datadir=/usr/local/mysql/data
socket=/usr/local/mysql/data/mysql.sock
character-set-server=utf8
EOF

cp -a /usr/local/mysql/mysql/support-files/mysql.server /etc/init.d/mysql
chmod +x /etc/init.d/mysql
chkconfig --add mysql

chown -R mysql:mysql /usr/local/mysql/data/
chmod -R 755 /usr/local/mysql/data/
service mysql start
service mysql status
ln -sf /usr/local/mysql/mysql/bin/mysql /usr/bin
ln -s /usr/local/mysql/data/mysql.sock /tmp/mysql.sock
mysql -uroot -p$tem_passwd --connect-expired-password   -e  "ALTER user 'root'@'localhost' IDENTIFIED BY '123456';"
mysql -uroot -p123456

