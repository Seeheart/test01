#!/bin/bash
yum install -y wget gcc gcc-c++ pcre pcre-devel zlib zlib-devel openssl openssl-devel
wget https://nginx.org/download/nginx-1.22.0.tar.gz
groupadd -r nginx
useradd -r -g nginx -s /sbin/nologin -d /usr/local/nginx -M nginx
tar -zxvf nginx-1.22.0.tar.gz 
mv nginx-1.22.0 nginx
cd nginx
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx
make & make install
cat ./auto/options|grep YES
