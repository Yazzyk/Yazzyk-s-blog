---
title: next不蒜子不显示
comments: true
id: busuanzi
categories:
  - 解决问题
date: 2018-10-11 22:57:03
tags: [解决问题]
---
# 问题原因
开始以为是自己吧服务器重装了一次的原因，但最后发现是`不蒜子`的在今年（2018）10月初更新域名了，导致`next`自带的地址404，以下是来自[不蒜子官网](http://ibruce.info/2015/04/04/busuanzi/)的告示
```zsh
！！！！2018年9月 - 重要提示 ！！！！
大家好，因七牛强制过期原有的『dn-lbstatics.qbox.me』域名（预计2018年10月初），与客服沟通数次无果，即使我提出为此付费也不行，只能更换域名到『busuanzi.ibruce.info』！因我是最早的一批七牛用户，为七牛至少带来了数百个邀请用户，很痛心，很无奈！
各位继续使用不蒜子提供的服务，只需把原有的：
<script async src="//dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
域名改一下即可：
<script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
只需要修改该js域名，其他均未改变。若有疑问，可以加入不蒜子交流QQ群：`419260983`，对您带来的不便，非常抱歉！！！还是那句话，不蒜子不会中断服务！！！！
```
# 解决办法1
找到`themes/next/_third-party/analyics/busuanzi-counter.swig`  
将
```html
<script async src="//dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
```
修改为
```html
<script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
```

# 解决办法2
到next主题目录下
```zsh
git pull
```
说白了就是更新一下主题
