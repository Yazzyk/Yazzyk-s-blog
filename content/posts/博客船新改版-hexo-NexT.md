---
title: 博客船新改版 hexo+NexT
date: 2018-09-19 00:02:19
comments: true
id: hexo-next
categories:
  - web
tags: [Web]
---
# 搭建
搭建直接看[官方文档](https://hexo.io/zh-cn/docs/)  
本文就直接写搭建后的美化啊，部署什么的

# 部署到服务器
我看了不少文章，但是总是有什么权限之类的问题，要不然创建的git账号无法访问，要不然宝塔的www账号无法访问，最后自己还是按照那个意思上传上去了，
不过这样是 **不安全的!** **不安全的!** **不安全的!**


## 服务器上操作
我的服务器环境：
使用宝塔面板搭建的网站


```zsh
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
```zsh
# 先找到服务器上宝塔存网站的位置
cd ../www/wwwroot/
# 然后创建一个文件夹
mkdir blogName
# 进入文件夹初始化裸库
cd blogName
$ git init --bare hexo.git
Initialized empty Git repository in /www/wwwroot/hexo.git/
# 创建Git钩子(hook)
vim ./hexo.git/hook/post-receive
```
接下来输入一下内容：
```zsh
GIT_REPO=/www/wwwroot/blogName/hexo.git
TMP_GIT_CLONE=/tmp/HexoBlog
PUBLIC_WWW=/www/wwwroot/blogName/www
rm -rf ${TMP_GIT_CLONE}
git clone $GIT_REPO $TMP_GIT_CLONE
rm -rf ${PUBLIC_WWW}/*
cp -rf ${TMP_GIT_CLONE}/* ${PUBLIC_WWW}
```

保存退出后：执行
`chmod +x /data/GitLibrary/hexo.git/hooks/post-receive`
赋予执行权限

## 本地操作
在最后找到`deploy`，修改如下：
```zsh
 # Deployment
    ## Docs: https://hexo.io/docs/deployment.html
    deploy:
      type: git
      repo: <你服务器的用户名>@服务器ip:/www/wwwroot/blogName/hexo.git
      branch: master
```
## 免去密码验证(2019.01.26更新)
> 参考：[荔枝](https://blog.yizhilee.com/post/deploy-hexo-to-vps/)  

之前的登陆每次都要验证服务器的密码，真的是麻烦,然后参考了一下，找到了免去验证的方法  
首先要在本地生成一个公钥
```bash
ssh-keygen -t rsa -C "email@example.com"
```
然后将你的公钥复制到服务器上
```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub git@服务器ip地址
```
这里注意一下你自己的公钥的位置，以及服务器的用户名，ip地址
## 常用操作
> 具体请参考[hexo官方文档](https://hexo.io/zh-cn/docs/commands)

### 新建一篇文章
如果没有设置 layout 的话，默认使用 _config.yml 中的 
default_layout 参数代替。如果标题包含空格的话，请使用引号括起来。
```zsh
hexo new [layout] <title>
```
### 生成静态文件
```zsh
hexo generate
```
可简写为
```zsh
hexo g
```
选项	| 描述
--- | ---
-d,–deploy | 文件生成后立即部署
-w,–watch | 监视文件变动
### 启动服务器
访问网址为：http://localhost:4000/
```zsh
hexo s
```
选项 | 描述
--- | ---
-p,–port | 重设端口
-s,–static | 只使用静态文件
-l,–log |	启动日志，使用覆盖记录格式
### 清除缓存
hexo clean
# 使用gulp压缩代码
> 参考：[WDC’s Blog](http://cqwdc.com/post/6861cde8.html)

安装这个东西我之前一直报错，最后发现是版本的问题，网上大部分都是3.x的版本，而我用的是4.0的版本
最后我找到了参考博客给出的完整的安装
还有就是`xxx.js`和`xxx.min.js`

# 安装gulp
博客目录下使用 `npm install xxx --save`命令安装如下工具
```zsh
npm install gulp@next              # gulp4.0 因为 gulp-debug 需要 gulp 版本大于等于 4.0  
npm install -–save-dev gulp-debug  gulp-clean-css gulp-uglify gulp-htmlmin gulp-htmlclean gulp-imagemin gulp-changed 
gulp-if gulp-plumber run-sequence del
```

建立`gulpfile.js` 文件 在`Hexo`的根目录建立`gulpfile.js`
```zsh
var gulp        = require('gulp');
var debug       = require('gulp-debug');
var cleancss    = require('gulp-clean-css'); //css压缩组件
var uglify      = require('gulp-uglify');    //js压缩组件
var htmlmin     = require('gulp-htmlmin');   //html压缩组件
var htmlclean   = require('gulp-htmlclean'); //html清理组件
var imagemin    = require('gulp-imagemin');  //图片压缩组件
var changed     = require('gulp-changed');   //文件更改校验组件
var gulpif      = require('gulp-if')         //任务 帮助调用组件
var plumber     = require('gulp-plumber');   //容错组件（发生错误不跳出任务，并报出错误内容）
var runSequence = require('run-sequence');   //异步执行组件
var isScriptAll = true;  //是否处理所有文件，(true|处理所有文件)(false|只处理有更改的文件)
var isDebug     = true;  //是否调试显示 编译通过的文件
var del         = require('del');
var Hexo        = require('hexo');
var hexo        = new Hexo(process.cwd(), {}); // 初始化一个hexo对象

// 清除public文件夹
gulp.task('clean', function() {
    return del(['public/**/*']);
});

// 下面几个跟hexo有关的操作，主要通过hexo.call()去执行，注意return

// 创建静态页面 （等同 hexo generate）
gulp.task('generate', function() {
    return hexo.init().then(function() {
        return hexo.call('generate', {
            watch: false
        }).then(function() {
            return hexo.exit();
        }).catch(function(err) {
            return hexo.exit(err);
        });
    });
});

// 启动Hexo服务器
gulp.task('server',  function() {
    return hexo.init().then(function() {
        return hexo.call('server', {});
    }).catch(function(err) {
        console.log(err);
    });
});

// 部署到服务器
gulp.task('deploy', function() {
    return hexo.init().then(function() {
        return hexo.call('deploy', {
            watch: false
        }).then(function() {
            return hexo.exit();
        }).catch(function(err) {
            return hexo.exit(err);
        });
    });
});

// 压缩public目录下的js文件
gulp.task('compressJs', function () {
    var option = {
        // preserveComments: 'all',//保留所有注释
        mangle: true,           //类型：Boolean 默认：true 是否修改变量名
        compress: true          //类型：Boolean 默认：true 是否完全压缩
    }
    return gulp.src(['./public/**/*.js','!./public/**/*.min.js'])  //排除的js
        .pipe(gulpif(!isScriptAll, changed('./public')))
        .pipe(gulpif(isDebug,debug({title: 'Compress JS:'})))
        .pipe(plumber())
        .pipe(uglify(option))                //调用压缩组件方法uglify(),对合并的文件进行压缩
        .pipe(gulp.dest('./public'));         //输出到目标目录
});

// 压缩public目录下的css文件
gulp.task('compressCss', function () {
    var option = {
        rebase: false,
        //advanced: true,               //类型：Boolean 默认：true [是否开启高级优化（合并选择器等）]
        compatibility: 'ie7',         //保留ie7及以下兼容写法 类型：String 默认：''or'*' [启用兼容模式； 'ie7'：IE7兼容模式，'ie8'：IE8兼容模式，'*'：IE9+兼容模式]
        //keepBreaks: true,             //类型：Boolean 默认：false [是否保留换行]
        //keepSpecialComments: '*'      //保留所有特殊前缀 当你用autoprefixer生成的浏览器前缀，如果不加这个参数，有可能将会删除你的部分前缀
    }
    return gulp.src(['./public/**/*.css','!./public/**/*.min.css'])  //排除的css
        .pipe(gulpif(!isScriptAll, changed('./public')))
        .pipe(gulpif(isDebug,debug({title: 'Compress CSS:'})))
        .pipe(plumber())
        .pipe(cleancss(option))
        .pipe(gulp.dest('./public'));
});

// 压缩public目录下的html文件
gulp.task('compressHtml', function () {
    var cleanOptions = {
        protect: /<\!--%fooTemplate\b.*?%-->/g,             //忽略处理
        unprotect: /<script [^>]*\btype="text\/x-handlebars-template"[\s\S]+?<\/script>/ig //特殊处理
    }
    var minOption = {
        collapseWhitespace: true,           //压缩HTML
        collapseBooleanAttributes: true,    //省略布尔属性的值  <input checked="true"/> ==> <input />
        removeEmptyAttributes: true,        //删除所有空格作属性值    <input id="" /> ==> <input />
        removeScriptTypeAttributes: true,   //删除<script>的type="text/javascript"
        removeStyleLinkTypeAttributes: true,//删除<style>和<link>的type="text/css"
        removeComments: true,               //清除HTML注释
        minifyJS: true,                     //压缩页面JS
        minifyCSS: true,                    //压缩页面CSS
        minifyURLs: true                    //替换页面URL
    };
    return gulp.src('./public/**/*.html')
        .pipe(gulpif(isDebug,debug({title: 'Compress HTML:'})))
        .pipe(plumber())
        .pipe(htmlclean(cleanOptions))
        .pipe(htmlmin(minOption))
        .pipe(gulp.dest('./public'));
});

// 压缩 public/uploads 目录内图片
gulp.task('compressImage', function() {
    var option = {
        optimizationLevel: 5, //类型：Number  默认：3  取值范围：0-7（优化等级）
        progressive: true,    //类型：Boolean 默认：false 无损压缩jpg图片
        interlaced: false,    //类型：Boolean 默认：false 隔行扫描gif进行渲染
        multipass: false      //类型：Boolean 默认：false 多次优化svg直到完全优化
    }
    return gulp.src('./public/uploads/**/*.*')
        .pipe(gulpif(!isScriptAll, changed('./public/uploads')))
        .pipe(gulpif(isDebug,debug({title: 'Compress Images:'})))
        .pipe(plumber())
        .pipe(imagemin(option))
        .pipe(gulp.dest('./public/uploads'));
});

// 用run-sequence并发执行，同时处理html，css，js，img
gulp.task('compress', function(cb) {
    runSequence.options.ignoreUndefinedTasks = true;
    runSequence(['compressHtml', 'compressCss', 'compressJs'],cb);
});

// 执行顺序： 清除public目录 -> 产生原始博客内容 -> 执行压缩混淆 -> 部署到服务器
gulp.task('build', function(cb) {
    runSequence.options.ignoreUndefinedTasks = true;
    runSequence('clean', 'generate', 'compress', 'deploy', cb);
});

// 默认任务
gulp.task('default', 
	gulp.series('clean','generate',
		gulp.parallel('compressHtml','compressCss','compressImage')
	)
);
//Gulp4最大的一个改变就是gulp.task函数现在只支持两个参数，分别是任务名和运行任务的函数
```

## 压缩生成代码
使用`hexo g && gulp`压缩生成代码
生成的代码会在`public`文件夹下

# 优化篇
## 安装NexT主题
这个其实NexT官方文档也有，我这里只说安装过程
```zsh
cd your-hexo-site
git clone https://github.com/iissnan/hexo-theme-next themes/next
```
然后到`你的站点文件夹/_config.yml`文件找到`theme`修改如下
```zsh
# Extensions
## Plugins: https://hexo.io/plugins/
## Themes: https://hexo.io/themes/
theme: next
# 注意，这里的next即是主题的名字
```
## NexT的主题切换
搜索关键词：`scheme`
这里有4个主题，自己试吧
要用的主题直接去掉前面的`#`号即可
```zsh
# ---------------------------------------------------------------
# Scheme Settings
# ---------------------------------------------------------------

# Schemes
#scheme: Muse
#scheme: Mist
scheme: Pisces
#scheme: Gemini
```


## 语言切换
> 参考： [Bamboo Sticks](https://haowei.ch/2018/03/01/%E7%8E%AF%E5%A2%83%E9%83%A8%E7%BD%B2-20180301/)

关键字：`language`
这里要注意一下，很多都写的是`zh-Hans`,甚至是这个我也不知道是不是[官方文档](https://theme-next.iissnan.com/getting-started.html)的网站
实际上在NexT6.0后中文变成了`zh-CN`

## 打开文章版权信息
搜索关键字`post_copyright`
将`enable`修改为`true`
如果想修改，可以找到`themes/next/layout/_macro/post-copyright.swig`修改


## 打开字数统计
首先博客目录下执行命令
```zsh
npm install hexo-symbols-count-time --save
```
然后在`hexo`的`_config.yml`中修改：
修改此文件需要重启服务
```zsh
# 字数统计
symbols_count_time:
  symbols: true # 文章字数
  time: false # 阅读时长
  total_symbols: true # 所有文章总字数
  total_time: false # 所有文章阅读中时长
```
在next的_config.yml中修改
修改此文件不需要重启，只需刷新
```zsh
# Post wordcount display settings
# Dependencies: https://github.com/theme-next/hexo-symbols-count-time
symbols_count_time:
  separated_meta: false # 是否换行显示 字数统计 及 阅读时长
  item_text_post: true  # 文章 字数统计 阅读时长 使用图标 还是 文本表示
  item_text_total: true # 博客底部统计 字数统计 阅读时长 使用图标 还是 文本表示
  awl: 4
  wpm: 275
```

## 开启动态背景
关键字：`canvas_nest`
根据自己的需要开启
```zsh
# Canvas-nest
# Dependencies: https://github.com/theme-next/theme-next-canvas-nest
# 这个是2D
canvas_nest: false

# JavaScript 3D library.
# Dependencies: https://github.com/theme-next/theme-next-three
# three_waves
# 这个是3D，有三种
three_waves: false
# canvas_lines
canvas_lines: true
# canvas_sphere
canvas_sphere: false
```

### 2D背景安装
在博客根目录下进行以下操作
```zsh
cd themes/next
git clone https://github.com/theme-next/theme-next-canvas-nest source/lib/canvas-nest
```

### 3D背景安装
在博客根目录下进行以下操作
```zsh
cd themes/next
git clone https://github.com/theme-next/theme-next-three source/lib/three
```
### 关闭Google字体
国内访问的话由于谷歌字体无法加载，会在那加载半天打不开
关键字:`font`
将`enable`后面改为`false`即可，或者修改为其他国内可访问的资源

### 设置`sitemap`

> 参考: [hoxis](https://hoxis.github.io/Hexo+Next%20SEO%E4%BC%98%E5%8C%96.html)

#### 安装插件
在blog目录下执行
```zsh
npm install hexo-generator-sitemap --save
npm install hexo-generator-baidu-sitemap --save
```

#### 修改配置文件
在hexo的_config.yml中添加：
```zsh
# sitemap
sitemap:
  path: sitemap.xml
baidusitemap:
  path: baidusitemap.xml
```

安装完成后执行`hexo g`即可在`public`目录下生成`sitemap.xml`文件和`baidusitemap.xml`

#### robots协议
爬虫协议
在`source`目录下新建`robots.txt`文件，内容为：
```zsh
User-agent: *
Allow: /
Allow: /archives/
Allow: /categories/
Allow: /tags/ 
Allow: /resources/ 
Disallow: /vendors/
Disallow: /js/
Disallow: /css/
Disallow: /fonts/
Disallow: /vendors/
Disallow: /fancybox/

Sitemap: yoururl/sitemap.xml
Sitemap: yoururl/baidusitemap.xml
```
具体的seo优化请看参考的博客

## 开启打赏
next下`_config.yml`  
关键字：`Reward`
修改如下：
```zsh
# Reward
reward_comment: 支持我就赏点小钱钱吧~  # 文字 
wechatpay: /images/wechat_qcode.png  # 微信收款二维码
alipay: /images/alipay.jpg  # 支付宝收款二维码
#bitcoin: /images/bitcoin.png # 比特币
```
## favicon
关键字：`favicon`
```zsh
favicon:
  small: /images/logo.png
  medium: /images/logo.png
  apple_touch_icon: http://cloud.css0209.cn/css0209img/logo.png
  safari_pinned_tab: /images/logo.svg
```
## RSS
安装插件
```zsh
npm install hexo-generator-feed --save
```
在博客目录下的`_config.yml`添加
```zsh
# rss
feed:
  type: atom
  path: atom.xml
  limit: 20
  hub:
  content:
  content_limit: 140
  content_limit_delim: ' '
  order_by: -date
```

在主题目录下`_config.yml`找到关键字：`rss`
修改为：`rss: /atom.xml`

# 侧边栏
## 导航，菜单
关键字: `menu`
```zsh
menu:
  home: / || home
  about: /about/ || user
  #tags: /tags/ || tags
  #categories: /categories/ || th
  archives: /archives/ || archive
  #schedule: /schedule/ || calendar
  #sitemap: /sitemap.xml || sitemap
  #commonweal: /404/ || heartbeat
  本站的404: 404.html || exclamation-triangle
```
这里的home什么的可以在language文件夹下对应语言中修改  
`/about/`是指页面所在文件夹  
 `||` 后面 是图标的名字，NexT的图标名字可以从[Font Awesome](https://fontawesome.com/)找找到
 
 ## 社交链接
 关键字: `social`  
 ```zsh
 social:
   GitHub: https://github.com/idoctype || github
   E-Mail: mailto:917885215@qq.com || envelope
   Bilibili: https://space.bilibili.com/10061915/#/ || tv
   Bitbucket: https://bitbucket.org/blankyk/ || bitbucket
   Music163: https://music.163.com/#/user/home?id=311066699 || music
   Steam: http://s.team/p/khn-cnmp/KBHFMFJN || steam
 ```
 改法和菜单导航差不多

## 友情链接
关键字:`links`  
修改格式为：
```zsh
links:
  name: url
```
## 头像
关键字： `avatar`  
`url`后面改为你的头像的地址

## 颜色修改
***首先我要说一下，对于这块具体我不是很清楚，但是我是这样改的***   
在改颜色之前请打开`themes/source/css/_schemes/_varlabes/base.styl`  
这个文件里面有一些颜色已经定义了，反正你自己看着办吧，我是强迫症
这个`Pisces`应该是主题的名字，具体我不清楚，我没尝试过  
具体修改就太多了，我不想一一叙述，具体的，自己调试

# 评论系统
这个说来奇怪，其实我当时找的是next统计找到的这个
这里我只提供关键字：`valine`  
> 具体请参考:[为NexT主题添加文章阅读量统计功能](https://notes.doublemine.me/2015-10-21-%E4%B8%BANexT%E4%B8%BB%E9%A2%98%E6%B7%BB%E5%8A%A0%E6%96%87%E7%AB%A0%E9%98%85%E8%AF%BB%E9%87%8F%E7%BB%9F%E8%AE%A1%E5%8A%9F%E8%83%BD.html#%E9%85%8D%E7%BD%AELeanCloud)  

开启评论的话可能会是页面打开稍微慢一丢丢

# 404页面
> 参考：[SORA](http://mashirosorata.vicp.io/HEXO-NEXT%E4%B8%BB%E9%A2%98%E4%B8%AA%E6%80%A7%E5%8C%96%E9%85%8D%E7%BD%AE.html)

这个404是我参考的别人的
这里要注意的是在HTML页面导入这两个js
```zsh
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/velocity/1.5.0/velocity.min.js"></script>
```
不然会报错

# zsh简化命令
用vim打开zsh的配置文件
`vim ~/.zshrc`
添加内容
```zsh
# hexo清缓存，生成，压缩，部署
alias hexopush="hexo clean && hexo g && gulp && hexo d"
# hexo清缓存，生成，压缩，开启本地服务器测试
alias hexotest="hexo clean && hexo g && gulp && hexo s"
```
# 让markdown支持emoji表情
> 参考：[hexo-renderer-markdown-it](https://github.com/hexojs/hexo-renderer-markdown-it/wiki/Getting-Started)

说白了就是换个markdown的渲染引擎

```zsh
npm i hexo-renderer-markdown-it --save
```
然后进入`hexo`的`_config.yml`加入以下内容：
```zsh
# Markdown-it config
## Docs: https://github.com/celsomiranda/hexo-renderer-markdown-it/wiki
markdown:
  render:
    html: true
    xhtmlOut: false
    breaks: true
    linkify: true
    typographer: true
    quotes: '“”‘’'
  plugins:
    - markdown-it-abbr
    - markdown-it-footnote
    - markdown-it-ins
    - markdown-it-sub
    - markdown-it-sup
    - markdown-it-emoji  ## add emoji
  anchors:
    level: 2
    collisionSuffix: 'v'
    # If `true`, creates an anchor tag with a permalink besides the heading.
    permalink: false
    permalinkClass: header-anchor
    # The symbol used to make the permalink
    permalinkSymbol: ¶
```
这里面也有一些其他插件  
如果感兴趣可以到[hexo-renderer-markdown-it](https://github.com/hexojs/hexo-renderer-markdown-it/wiki/Advanced-Configuration)  
去了解，反正我是谷歌浏览器翻译着看的
