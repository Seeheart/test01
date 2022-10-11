#!/bin/bash
cat >/etc/yum.repos.d/mongodb-org.repo <<EOF
[mongodb-org] 
name = MongoDB Repository
baseurl = https://mirrors.aliyun.com/mongodb/yum/redhat/$releasever/mongodb-org/3.6/x86_64/
gpgcheck = 1 
enabled = 1 
gpgkey = https://www.mongodb.org/static/pgp/server-3.6.asc
EOF

yum install -y mongodb-org
service mongod start

