#!/bin/bash
cd /usr/local
tar -zxvf redis-7.0.4.tar.gz
mv ./redis-7.0.4 ./redis7
yum install -y gcc-c++ make
cd redis7/
make & make install

cp /usr/local/redis7/redis.conf /usr/local/redis7/redis.conf.bak
mkdir -p /etc/redis
cp /usr/local/redis7/redis.conf /etc/redis/6379.conf
cp /usr/local/redis7/utils/redis_init_script /etc/init.d/redis 
sed -i 's/daemonize no/daemonize yes/' /etc/redis/6379.conf
chkconfig redis on
service redis start

