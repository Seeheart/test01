#!/bin/bash
#This is a script for install python3.8.13
yum install -y wget 
wget https://www.python.org/ftp/python/3.8.13/Python-3.8.13.tgz

tar -zxvf Python-3.8.13.tgz

cd ./Python-3.8.13/

yum install libffi-devel zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make -y

./configure --prefix=/usr/local/python3

make && make install

ln -s /usr/local/python3/bin/python3 /usr/bin/python3
ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3
pip3 install --upgrade pip

pip3 install ipython
ln -s /usr/local/python3/bin/ipython3 /usr/bin/ipython3

