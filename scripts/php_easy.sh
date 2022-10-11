#!/bin/bash
yum install epel-release -y
rpm -ivh https://mirrors.tuna.tsinghua.edu.cn/remi/enterprise/remi-release-7.rpm
yum remove -y php*
yum repolist all | grep php
yum install -y yum-utils
yum-config-manager --enable remi-php70
yum install -y php
yum install -y php-fpm php-devel

systemctl start php-fpm
