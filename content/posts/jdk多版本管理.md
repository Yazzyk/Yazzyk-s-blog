---
title: "JDK多版本管理"
date: 2019-07-11T10:52:03+08:00
hidden: false
draft: false
tags: [Java]
keywords: ['jdk','多版本管理']
description: "jdk的多版本管理"
slug: ""
---
> 参考：[Bobness](https://www.jianshu.com/p/1a147d5515f0)
[install-openjdk-versions-on-the-mac](https://dzone.com/articles/install-openjdk-versions-on-the-mac)

# 安装jenv
```shell
brew install jenv
```
# 环境配置
```shell
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
```
# 查看找到的Java版本
```shell
jenv version
system (set by /Users/kointernet/.jenv/version) # 反馈信息,不输入该行
```
# 安装OpenJDK
## 添加tap
```shell 
brew tap AdoptOpenJDK/openjdk
```
## 查看JDK版本
```shell
brew search /adoptopenjdk/
## 以下为返回信息
==> Casks
adoptopenjdk ✔                adoptopenjdk11                adoptopenjdk11-openj9         adoptopenjdk11-openj9-large   adoptopenjdk12-jre            adoptopenjdk12-openj9-jre     adoptopenjdk8-jre             adoptopenjdk8-openj9-jre      adoptopenjdk9
adoptopenjdk10                adoptopenjdk11-jre            adoptopenjdk11-openj9-jre     adoptopenjdk12                adoptopenjdk12-openj9         adoptopenjdk8                 adoptopenjdk8-openj9          adoptopenjdk8-openj9-large
```
## 安装OpenJDK
```shell
brew install adoptopenjdk/openjdk/adoptopenjdk-openjdk8
```
JAVA_HOME目录：`/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home`

# 将OpenJDK添加到jenv中
```shell
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
```

# 查看添加成功的JDK版本
```shell
jenv versions
# 以下为反馈信息
system (set by /Users/kointernet/.jenv/version)
1.8
1.8.0.212
openjdk64-1.8.0.212
```
# 切换版本
```shell
jenv local 1.8
```
# 查看切换版本
```shell
java -version
openjdk version "1.8.0_212"
OpenJDK Runtime Environment (AdoptOpenJDK)(build 1.8.0_212-b04)
OpenJDK 64-Bit Server VM (AdoptOpenJDK)(build 25.212-b04, mixed mode)
```