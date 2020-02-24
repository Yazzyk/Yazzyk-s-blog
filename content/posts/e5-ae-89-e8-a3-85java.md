---
title: 安装JAVA
url: 68.html
id: 68
comments: true
categories:
  - Java
date: 2018-03-24 07:37:22
tags: [Java]
---

> 参考来自[菜鸟教程](https://www.runoob.com/java/java-tutorial.html)

##  下载JDK包

[前往官网下载](https://www.oracle.com/technetwork/java/javase/downloads/jdk9-downloads-3848520.html) JDK  
[![](https://cloud.css0209.cn/css0209img/java1.png)](https://cloud.css0209.cn/css0209img/java1.png)  
然后选择你的安装包的位置，点击保存,下载可能比较慢，请耐心等待  
[![](https://cloud.css0209.cn/css0209img/java2.png)](https://cloud.css0209.cn/css0209img/java2.png)  
下一步,如果你要安装到其它地方也可以  
[![](https://cloud.css0209.cn/css0209img/java3.png)](https://cloud.css0209.cn/css0209img/java3.png)   

[![](https://cloud.css0209.cn/css0209img/java4.png)](https://cloud.css0209.cn/css0209img/java4.png)  

安装JDK，安装过程中可以自定义安装目录等信息，例如我们选择安装目录为
C:\\Program Files\\Java\\jdk-9.0.4

##  环境配置

我的电脑鼠标右键，点击属性打开“系统”，点击“高级系统设置” 
[![](https://cloud.css0209.cn/css0209img/java5.png)](https://cloud.css0209.cn/css0209img/java5.png)  
弹出对话框，点击环境变量  
[![](https://cloud.css0209.cn/css0209img/java6.png)](https://cloud.css0209.cn/css0209img/java6.png)  
在"系统变量"中设置3项属性，JAVA_HOME,PATH,CLASSPATH(大小写无所谓),若已存在则点击"编辑"，不存在则点击"新建"。 变量设置参数如下：  

```zsh
  变量名：JAVA_HOME
  变量值：C:\Program Files\Java\jdk-9.0.4
  变量名：CLASSPATH
  变量值：.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar; //记得前面有个"."
  变量名：Path
  变量值：%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;

  如果你是Win10，因为系统的限制，path 变量只可以使用 JDK 的绝对路径。
  %JAVA_HOME% 会无法识别，导致配置失败。 将Path变量值改为以下的绝对路径：
  变量值：C:\Program Files\Java\jdk-9.0.4\bin;C:\Program Files\Java\jre-9.0.4\bin;
```  


[![](https://cloud.css0209.cn/css0209img/java7.png)](https://cloud.css0209.cn/css0209img/java7.png) 

# JAVA_HOME设置 

[![](https://cloud.css0209.cn/css0209img/java8.png)](https://cloud.css0209.cn/css0209img/java8.png) 

# PATH配置 

[![](https://cloud.css0209.cn/css0209img/java9.png)](https://cloud.css0209.cn/css0209img/java9.png) 

# CLASSPATH配置 

[![](https://cloud.css0209.cn/css0209img/java10.png)](https://cloud.css0209.cn/css0209img/java10.png)

#  测试环境变量是否成功安装

按下win键+R键打开运行窗口输入cmd并回车  
[![](https://cloud.css0209.cn/css0209img/java11.png)](https://cloud.css0209.cn/css0209img/java11.png)  
输入：java -version  
[![](https://cloud.css0209.cn/2018/03/QQ20180830-203008.png)](https://cloud.css0209.cn/2018/03/QQ20180830-203008.png)  
如果出现以上一些关于JAVA的信息则说明安装成功  

