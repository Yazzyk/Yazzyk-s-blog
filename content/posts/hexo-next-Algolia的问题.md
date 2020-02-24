---
title: hexo-next Algolia的问题
comments: true
categories:
  - 解决问题
date: 2019-01-26 02:15:09
id: q01
tags: [解决问题]
---
# 遇到问题的环境
hexo版本：3.8.0
Next版本：6.4.1
Algolia版本：1.3.1

# Algolia Settings are invalid(Aloglia设置无效)
## 问题分析
网上大概的搜一下，没有相关的信息，然后就只有自己看源码了，找到`next/source/aloglia-search.js`搜索`Algolia Settings are invalid`会发现是一个和`applicationID`,`apiKey`,`indexName`有关的错误  
那么我就把这三个值都输出看看，修改输出错误信息为：
```javascript
window.console.error('Algolia Settings are invalid.\n'+algoliaSettings.applicationID+'\n'+algoliaSettings.apiKey+'\n'+algoliaSettings.indexName);
```
然后启动服务器测试，发现`algoliaSettings.apiKey`的值那行为空，检查了配置是按照官方的配置来的
## 问题解决
最后找来找去，是因为官方的那个站点设置没有更新，我吧上面的apiKey也当成了`Search-Only API key`，而那个就是apiKey  
正确的设置应为
```yml
algolia:
  applicationID: 'applicationID'
  apiKey: 'apiKey'
  indexName: 'indexName'
  chunkSize: 5000
```
这里我看到有些文章说要加引号，有些又没说，反正我没加
# instantsearch is not defined
## 问题分析
这个在网上查了一下，然后发现其实是自己傻*了，没装依赖，在`algolia_search`上面其实写着的`Dependencies`,所以到[theme-next-algolia-instant-search](https://github.com/theme-next/theme-next-algolia-instant-search)按照上面操作就完事了
## 问题解决
```zsh
cd themes/next&&git clone https://github.com/theme-next/theme-next-algolia-instant-search source/lib/algolia-instant-search
```
# 优化
这里每次写文章都要进行一次`hexo algolia`就很麻烦，所以我修改了zsh的配置,如果已经有的话修改一下就好，没有的话，在最后一行添加  
请参考[zsh简化命令](https://www.css0209.cn/20180919hexo-next/#zsh简化命令)
```zsh
alias hexotest='hexo algolia && hexo g && gulp && hexo s'
alias hexopush='hexo algolia && hexo g && gulp && hexo d'
```
`hexotest`是用于测试的
`hexopush`是用于部署的  
`gulp`是用于压缩代码的，请参考[安装gulp](https://www.css0209.cn/20180919hexo-next/#安装gulp)