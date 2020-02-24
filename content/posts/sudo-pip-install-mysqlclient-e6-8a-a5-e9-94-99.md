---
title: sudo pip install mysqlclient报错
url: 247.html
id: 247
comments: true
categories:
  - 解决问题
  - Python
date: 2018-09-10 22:05:33
tags: [Python]
---

今天在学习Django时遇到一个问题
==================

\# 首先安装Mysql驱动
`brew install mysql-connector-c`
\# 第一条到没什么问题，但是第二条命令。。。
`sudo pip install mysqlclient`

当我按下`Enter`键后，出现了以下的报错：
````shell
Password:
The directory '/Users/blankyk/Library/Caches/pip/http' or its parent directory is not owned by the current user and the cache has been disabled. Please check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag.
The directory '/Users/blankyk/Library/Caches/pip' or its parent directory is not owned by the current user and caching wheels has been disabled. check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag.
Collecting mysqlclient
  Downloading https://files.pythonhosted.org/packages/ec/fd/83329b9d3e14f7344d1cb31f128e6dbba70c5975c9e57896815dbb1988ad/mysqlclient-1.3.13.tar.gz (90kB)
    100% |████████████████████████████████| 92kB 147kB/s 
    Complete output from command python setup.py egg_info:
    Traceback (most recent call last):
      File "", line 1, in 
      File "/private/tmp/pip-install-2m1bow3w/mysqlclient/setup.py", line 18, in 
        metadata, options = get_config()
      File "/private/tmp/pip-install-2m1bow3w/mysqlclient/setup\_posix.py", line 60, in get\_config
        libraries = \[dequote(i\[2:\]) for i in libs if i.startswith('-l')\]
      File "/private/tmp/pip-install-2m1bow3w/mysqlclient/setup_posix.py", line 60, in 
        libraries = \[dequote(i\[2:\]) for i in libs if i.startswith('-l')\]
      File "/private/tmp/pip-install-2m1bow3w/mysqlclient/setup_posix.py", line 13, in dequote
        raise Exception("Wrong MySQL configuration: maybe https://bugs.mysql.com/bug.php?id=86971 ?")
    Exception: Wrong MySQL configuration: maybe https://bugs.mysql.com/bug.php?id=86971 ?
    
    ----------------------------------------
Command "python setup.py egg_info" failed with error code 1 in /private/tmp/pip-install-2m1bow3w/mysqlclient/
````
首先我用的是macOS Height Sierra 10.13.6(黑苹果) 然后，我就日常Google了，然后在[www.easegamer.com/?p=545](https://www.easegamer.com/?p=545)找到了解决方案和答案 这个问题出现的原因是mysql-connector-c中配置项有误 mysqlclient开发小组的核心成员，来自日本的大神INADA Naoki给出了临时性的解决办法，具体可以去看[GitHub上mysqlclient的issue](https://github.com/PyMySQL/mysqlclient-python/issues/169#issuecomment-299778504) 针对于Mac的话我参照[此博客](https://www.easegamer.com/?p=545)中的方法解决如下：

\# 找到mysql\_config文件，我的电脑上地址为：/usr/local/Cellar/mysql-connector-c/6.1.11/bin/mysql\_config
\# 然后我是用vscode打开的文件，不知道为什么，就算我用`sudo vim`打开这个文件，也只有只读权限，打开后找到114行：
````shell
Create options 
libs="-L$pkglibdir"
libs="$libs -l"
````


\# 修改为：

````shell
Create options 
libs="-L$pkglibdir"
libs="$libs -lmysqlclient -lssl -lcrypto"
````
保存，然后提示只读，点击覆盖即可，退出 再次执行
````zsh
(venv) ➜  curriculum sudo pip install mysqlclient
Password:
The directory '/Users/blankyk/Library/Caches/pip/http' or its parent directory is not owned by the current user and the cache has been disabled. Please check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag.
The directory '/Users/blankyk/Library/Caches/pip' or its parent directory is not owned by the current user and caching wheels has been disabled. check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag.
Collecting mysqlclient
  Downloading https://files.pythonhosted.org/packages/ec/fd/83329b9d3e14f7344d1cb31f128e6dbba70c5975c9e57896815dbb1988ad/mysqlclient-1.3.13.tar.gz (90kB)
    100% |████████████████████████████████| 92kB 124kB/s 
Installing collected packages: mysqlclient
  Running setup.py install for mysqlclient ... done
Successfully installed mysqlclient-1.3.13
````
大概就是这么肥事。[](https://cloud.css0209.cn/2018/09/9150e4e5ly1fkzc8c405bj20e80cjaab.jpg)