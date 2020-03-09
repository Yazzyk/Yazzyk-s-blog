---
title: 学校Linux，Samba服务器搭建
comments: true
id: linux-samba
categories:
  - Linux
date: 2018-12-08 14:25:42
tags: [蓝桥杯]
---
# 基于我学院机房搭建的Samba服务器傻瓜式教程
感谢班上学习委员大佬的笔记
# 一、挂载光盘
```bash
mount #查看光盘所在的设备位置
mount -t iso9660 /dev/hdc /mnt  #挂载光盘(/dev/hdc)到 /mnt目录
```

# 二、软件包安装
- 所有的软件包都在Server目录(`/mnt/Server`)
- `rpm -ivh` (`-i`安装、`-v`显示安装过程、`-h`以“#”符号表示安装进度）
- samba服务器需要安装两个软件包：
```bash
rpm -ivh /mnt/Server/perl-Convert-ASNI-0.20-1.1.noarch.rpm
rpm -ivh /mnt/Server/samba-3.0.33-3.14.e15.i386.rpm
```
> 注：使用tab键自动补全，更方便  

检查是否安装成功：`service smb start`（`Samba`服务器使用`smb`协议）

# 三、设置防火墙
`setup`（将`samba`设为通过）

# 四、网络IP相关设置
- VMWARE软件 虚拟机设置：`虚拟机`-`设置`-`适配器`-自定义`VMNET1`
- 关闭虚拟机自带的`DHCP`:`编辑`-`虚拟机网络编辑器`-`VMNET1`，`关闭DHCP`选项
```bash
ifconfig eth0  #查看网卡接口etho的IP
ifconfig eth0 10.10.10.10  #设置虚拟机eth0的IP地址，Linux
#（主机地址这时一般为10.10.10.1，为了便捷可以不进行修改）
```
## 检查是否设置成功
- 物理机：(Windows+R运行)cmd (调出命令提示符)  
进行ping测试  
```bash
        ping 10.10.10.10  
```
- 虚拟机：
```bash
ping 10.10.10.10 # 按ctrl+C终止ping命令，不然会一直运行
```

五、配置文件：`/etc/samba/smb.conf`  
共享文件自己创建，这里我创建的是`book`
```bash
mkdir /etc/book #在根目录下etc目录下创建book文件夹
```
### （1）配置共享级别:`[global]`和`[自定义目录名]`必须有  
```bash
vi /etc/samba/smb.conf #利用vi编辑器打开配置文件
```
命令模式下输入`/global`快速查找关键字'global'(`vi/vim`的部分使用：[Linux vi/vim笔记](../linux-vi-vim/))
按`i`切换到文本编辑模式
```bash
[global]
   workgroup=workgroup
   netbios name=centos
   security=share
[book]
   path=/etc/book
   writable=yes
   guest ok=yes
```
按`esc`切换到命令模式  
`：wq`存盘退出  
重启服务器：
```bash
service smb restart  
```
在物理机测试：
Windows+R(运行)或资源管理器:
```bash
\\10.10.10.10
```
或浏览器输入`file://10.10.10.10`

### （2）配置用户级别:`[global]`和`[homes]`必须有
> 只有Linux系统本身的用户才能成为samba用户  

```bash
useradd jerry #创建系统本身用户jerry
passwd jerry #设置密码
pdbedit -a jerry #添加samba用户jerry
vi /etc/samba/smb.conf #利用vi编辑器打开配置文件
```
- 按`i`切换到文本编辑模式
```bash
[global]
   workgroup=workgroup
   netbios name=centos
   security=user
[homes]
   comment=Home Directory
   browseable=no
   writable=yes
```
按`esc`切换到命令模式  
`：wq`存盘退出  
重启服务器：`service smb restart`  
在物理机测试：`\\10.10.10.10`


