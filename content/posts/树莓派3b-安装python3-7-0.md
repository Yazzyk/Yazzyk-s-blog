---
title: 树莓派3b+安装python3.7.0
comments: true
categories:
  - 树莓派
date: 2019-01-30 11:53:50
id: Raspberry-Pi
tags: [树莓派]
---
>参考：[https://my.oschina.net/mengyoufengyu/blog/2248239](https://my.oschina.net/mengyoufengyu/blog/2248239)  
[https://blog.csdn.net/wang725/article/details/79905612](https://blog.csdn.net/wang725/article/details/79905612)
# 更新系统
```zsh
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
```
# 安装依赖
```zsh
sudo apt-get install build-essential libsqlite3-dev sqlite3 bzip2 libbz2-dev
sudo apt-get install build-essential python-dev python-setuptools python-pip python-smbus
sudo apt-get install build-essential libncursesw5-dev libgdbm-dev libc6-dev
sudo apt-get install zlib1g-dev libsqlite3-dev tk-dev
sudo apt-get install libssl-dev openssl
sudo apt-get install libffi-dev
```
# Python3.7.0源码下载，解压
```zsh
cd download
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz
tar zxvf Python-3.7.0.tgz
```
# 编译安装
```zsh
sudo mkdir /usr/local/python370
cd Python-3.7.0
sudo ./configure --prefix=/usr/local/python370
sudo make
sudo make install
```
# 创建符号链接
```zsh
sudo ln -s /usr/local/python370/bin/python3 /usr/bin/python370
sudo ln -s /usr/local/python370/bin/python3 /usr/bin/python3.7.0
sudo ln -s /usr/local/python370/bin/pip3 /usr/bin/pip370
sudo ln -s /usr/local/python370/bin/pip3 /usr/bin/pip3.7.0
```