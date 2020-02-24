---
title: '问题解决：java.lang.ClassNotFoundException: com.mysql.jdbc.Driver'
comments: true
id: java-mysql
categories:
  - 解决问题
  - java
date: 2018-12-05 15:21:40
tags: [Java]
---
# 遇到问题是的环境：
- jdk1.8
- 远程连接服务器mysql
- macOS High Sierra
- idea
# 解决：
前往MySQL官网下载[所需的jar](https://dev.mysql.com/downloads/connector/j/)
![](https://cloud.css0209.cn/2018/12/java-mysql01.png)
下载完解压到一个位置  
idea点击file->Project Structure->Modules->Dependencies
![](https://cloud.css0209.cn/2018/12/java-mysql02.png)
点击“+”选择"JARs or directories"然后选择你解压的文件夹中的jar文件
![](https://cloud.css0209.cn/2018/12/java-mysql03.png)
然后打钩点ok就行
