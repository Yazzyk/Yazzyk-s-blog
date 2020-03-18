---
title: "Mysql连接失败(61)"
date: 2020-03-19T02:15:47+08:00
draft: false
hidden: false
tags: [mysql,linux]
keywords: [mysql,61,error,centos7]
---
# 0x01
这个问题已经存在很久了,首先排除掉一些已存在的可能性:
- 用户没有远程登录权限
- 端口不是3306
- 配置文件中注释`bind-address`
# 0x02
排除以上信息后,我在一片文章中找到答案[MySQL 连接错误Can't connect to MySQL server on ' '(61)](https://my.oschina.net/Laily/blog/712958)  
由于我重置了服务器系统,升级为了`centos7`所以忘记了防火墙的设置
```bash
➜  ~ sudo firewall-cmd --zone=public --permanent --add-service=mysql
success
➜  ~ sudo systemctl restart firewalld
```
重启防火墙后,`Nacicat`连接成功!