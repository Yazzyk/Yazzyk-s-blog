---
title: "Hugo_blog搭建"
date: 2019-05-21T12:43:10+08:00
hidden: false
draft: false
tags: [Web]
keywords: [hugo,blog]
description: "hugo博客搭建"
slug: ""
---

> CodeSheep[视频](https://www.bilibili.com/video/av51574688?t=223)
[Hugo中文文档](https://www.gohugo.org/)
我的环境为MacOS

# 安装 Hugo
```shell
brew install hugo
```

# 生成站点
```shell
hugo new site hugo_blog
cd hugo_blog
```

# 安装一个主题
> [hugo的主题](https://themes.gohugo.io)

从官网选用一个主题  
例如我选的[zozo](https://themes.gohugo.io/hugo-theme-zozo/)  
看到insetallation  
执行命令  

```shell
git clone https://github.com/imzeuk/hugo-theme-zozo themes/zozo
```


# 写一篇文章
```shell
hugo new posts/mypost.md
```
然后打开文件用[markdown](https://segmentfault.com/markdown)写就行
我的文章之前是`hexo`的，可以直接复制粘贴文件到`posts`目录下

# 本地运行
```shell
hugo server --theme=hyde --buildDrafts
```
浏览器打开：`http://localhost:1313`

# 主题调整
## 配置文件
> [zozo主题中文文档](https://github.com/imzeuk/hugo-theme-zozo/blob/master/README-zh.md)

作者明确说了有一个`exampleSite`放着示例站点，依葫芦画瓢，我们修改一下站点根目录下的`config.toml`文件  
具体改成什么样看你自己
```toml
baseURL = "https://blog.css0209.cn"
languageCode = "zh-cn"
defaultContentLanguage = "zh-cn"
title = "BlankYk"                    # site title  # 网站标题
theme = "zozo"
hasCJKLanguage = true                # has chinese/japanese/korean ? # 自动检测是否包含 中文\日文\韩文
summaryLength = 100
paginate = 6                         # shows the number of articles  # 首页显示文章数量
enableEmoji = true
# googleAnalytics = ""                 # your google analytics id
# disqusShortname = ""                 # your discuss shortname

[author]                             # essential                     # 必需
  name = "BlankYk"

[blackfriday]
  smartypants = false

[[menu.main]]                        # config your menu  # 配置菜单
  name = "首页"
  weight = 10
  identifier = "home"
  url = "/"
[[menu.main]]
  name = "归档"
  weight = 20
  identifier = "archive"
  url = "/posts/"
[[menu.main]]
  name = "标签"
  weight = 30
  identifier = "tags"
  url = "/tags/"
[[menu.main]]
  name = "关于"
  weight = 40
  identifier = "about"
  url = "/about/"

  [params]
  subTitle = "年少无为,不自卑"                                       # site's subTitle  # 网站二级标题
  footerSlogan = "做一个真实的Loser"                                          # site's footer slogan  # 网站页脚标语
  keywords = ["Hugo", "BlankYk","Java"]                                  # site's keywords  # 网站关键字
  description = "BlankYk's Blog."                        # site's description  # 网站描述


# mathjax
  enableMathJax = true                                                 # enable mathjax  # 是否使用mathjax（数学公式）

  enableSummary = true                                                 # display the article summary  # 是否显示文章摘要
  
# Valine.
# You can get your appid and appkey from https://leancloud.cn
# more info please open https://valine.js.org
[params.valine]
  enable = false
  appId = ""
  appKey = ""
  placeholder = "瞅啥呢？"
  visitor = true

[social]
  github = "https://github.com/blankyk"
  qq="tencent://Message/?Uin=917885215&amp;websiteName=q-zone.qq.com&amp;Menu=yes"
  tv="https://space.bilibili.com/10061915"
  mail="mailto:blankyk@css0209.cn"
  # twitter = " "
  # facebook = " "
  # weibo = " "
  # instagram = " "
```
## 修改logo
到主题的images文件夹下将`logo.svg`、`favicon.ico`修改成你自己的图像

# 添加备案号
在主题文件夹下找到`zozo/layouts/partials/footer.html`然后直接把你备案信息那个a标签放进去

# 部署到服务器上
很多人都已经讲过如何部署到github之类的仓库了  
我这里部署到服务器上  
先说一下我的服务器环境
```shell
screenfetch
                  ..                    ****
                .PLTJ.                  OS: CentOS 7.5.1804 Core
               <><><><>                 Kernel: x86_64 Linux 3.10.0-693.21.1.el7.x86_64
      KKSSV' 4KKK LJ KKKL.'VSSKK        Uptime: 4d 15h 13m
      KKV' 4KKKKK LJ KKKKAL 'VKK        Packages: 597
      V' ' 'VKKKK LJ KKKKV' ' 'V        Shell: zsh 5.0.2
      .4MA.' 'VKK LJ KKV' '.4Mb.        CPU: Intel Xeon Platinum 8163 @ 2.494GHz
    . KKKKKA.' 'V LJ V' '.4KKKKK .      GPU: cirrusdrmfb
  .4D KKKKKKKA.'' LJ ''.4KKKKKKK FA.    RAM: 533MiB / 1839MiB
 <QDD ++++++++++++  ++++++++++++ GFD>  
  'VD KKKKKKKK'.. LJ ..'KKKKKKKK FV    
    ' VKKKKK'. .4 LJ K. .'KKKKKV '     
       'VK'. .4KK LJ KKA. .'KV'        
      A. . .4KKKK LJ KKKKA. . .4       
      KKA. 'KKKKK LJ KKKKK' .4KK       
      KKSSA. VKKK LJ KKKV .4SSKK       
               <><><><>                
                'MKKM'                 
                  ''
```
服务器上装有[宝塔面板](https://www.bt.cn/),`centos7`系统  

然后开始命令
```shell
# 先找到服务器上宝塔存网站的位置
cd ../www/wwwroot/
# 然后创建一个文件夹
mkdir hugo_blog
# 进入文件夹初始化裸库
cd hugo_blog
$ git init --bare hugo.git

Initialized empty Git repository in /www/wwwroot/hugo.git/

```

编辑Git钩子
```shell
# 创建Git钩子(hook)
vim ./hugo.git/hooks/post-receive
```
编辑内容
```shell
GIT_REPO=/www/wwwroot/hugo_blog/hexo.git
TMP_GIT_CLONE=/tmp/HugoBlog
PUBLIC_WWW=/www/wwwroot/hugo_blog/www
rm -rf ${TMP_GIT_CLONE}
git clone $GIT_REPO $TMP_GIT_CLONE
rm -rf ${PUBLIC_WWW}/*
cp -rf ${TMP_GIT_CLONE}/* ${PUBLIC_WWW}
```

给予权限
```shell
chmod +x /www/wwwroot/hugo_blog/hexo.git/hooks/post-receive
```

创建`www`文件夹
```shell
cd /www/wwwroot/hugo_blog && mkdir www
```

# 部署
```shell
hugo --theme=zozo --baseUrl="https://blog.css0209.cn" --buildDrafs
```
命令执行完后会在站点根目录生成一个`public`文件
```shell
cd public
```
```shell
git init
git remote add origin <你服务器的用户名>@服务器ip:/www/wwwroot/hugo_blog/hugo.git 
git add .
git commit -m 'blog push'
git push -u origin master
```
剩下的就是在宝塔面板添加站点了，网站目录指向`/www/wwwroot/hugo_blog/www`,具体情况根据你自己的调整

# 命令简化
这里我使用的[oh-my-zsh](https://ohmyz.sh/)
```shell
vim ~/.zshrc
```

在最后添加
```shell
alias hugotest="cd ~/hugo_blog && open http://localhost:1313 && hugo server --theme=zozo --buildDrafts"
alias hugopush="cd ~/hugo_blog &&hugo --theme=zozo --baseUrl='https://blog.css0209.cn' -D &&cd public && git add . && git commit -m 'blog auto push'&&git push && cd ~/hugo_blog"
```
