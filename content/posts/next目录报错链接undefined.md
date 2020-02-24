---
title: next目录报错链接undefined
comments: true
categories:
  - 解决问题
date: 2019-01-23 23:18:08
id: ques01
tags: [解决问题]
---
# 错误原因
很简单，这是由于hexo-toc插件导致的。也许，其他的主题需要这个插件，但是next不需要
# 解决方案
卸载掉插件即可
```zsh
npm remove hexo-toc --save
```