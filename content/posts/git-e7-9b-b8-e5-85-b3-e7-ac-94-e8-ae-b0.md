---
title: Git相关笔记
url: 301.html
id: 301
comments: true
categories:
  - Git
date: 2018-09-14 20:37:04
tags: [Git]
---

> 参考文章：[菜鸟教程](https://www.runoob.com/git/git-tutorial.html)

配置
==

用户信息
----

配置个人的用户信息和电子邮箱：

git config --global user.name ""
git config --global user.email 

文档编辑器
-----

一般会是vi/vim

git config --global core.editor vim

查看配置信息
------

git config --list

Git工作流
======

[![](https://cloud.css0209.cn/2018/09/git-process.png)](https://cloud.css0209.cn/2018/09/git-process.png) 工作流程：

*   克隆 Git 资源作为工作目录。
*   在克隆的资源上添加或修改文件。
*   如果其他人修改了，你可以更新资源。
*   在提交前查看修改。
*   提交修改
*   在修改完成后，如果发现错误，可以撤回提交并再次修改并提交。

Git的工作区，暂存区和版本库
===============

*   工作区：就是你在电脑里能看到的目录。
*   暂存区：英文叫stage, 或index。一般存放在 ".git目录下" 下的index文件（.git/index）中，所以我们把暂存区有时也叫作索引（index）。
*   版本库：工作区有一个隐藏目录.git，这个不算工作区，而是Git的版本库。

[![](https://www.runoob.com/wp-content/uploads/2015/02/1352126739_7909.jpg)](https://www.runoob.com/wp-content/uploads/2015/02/1352126739_7909.jpg) 
图中左侧为工作区，右侧为版本库。在版本库中标记为 "index" 的区域是暂存区（stage, index），标记为 "master" 的是 master 分支所代表的目录树。 图中我们可以看出此时 "HEAD" 实际是指向 master 分支的一个"游标"。所以图示的命令中出现 HEAD 的地方可以用 master 来替换。 图中的 objects 标识的区域为 Git 的对象库，实际位于 ".git/objects" 目录下，里面包含了创建的各种对象及内容。 当对工作区修改（或新增）的文件执行 "`git add`" 命令时，暂存区的目录树被更新，同时工作区修改（或新增）的文件内容被写入到对象库中的一个新的对象中，而该对象的ID被记录在暂存区的文件索引中。 当执行提交操作（git commit）时，暂存区的目录树写到版本库（对象库）中，master 分支会做相应的更新。即 master 指向的目录树就是提交时暂存区的目录树。 当执行 "`git reset HEAD`" 命令时，暂存区的目录树会被重写，被 master 分支指向的目录树所替换，但是工作区不受影响。 当执行 "`git rm --cached` " 命令时，会直接从暂存区删除文件，工作区则不做出改变。 当执行 "`git checkout .`" 或者 "`git checkout --` " 命令时，会用暂存区全部或指定的文件替换工作区的文件。这个操作很危险，会清除工作区中未添加到暂存区的改动。 当执行 "`git checkout HEAD .`" 或者 "`git checkout HEAD` " 命令时，会用 HEAD 指向的 master 分支中的全部或者部分文件替换暂存区和以及工作区中的文件。这个命令也是极具危险性的，因为不但会清除工作区中未提交的改动，也会清除暂存区中未提交的改动。


Git常用指令
=======

`git init`:在目录中创建一个新的Git仓库，可以在离线状态下进行，这是一个本地化的操作  
`git clone [url]`:将一个Git仓库克隆到本地  
`git add` :git add 命令可将该文件添加到缓存  
`git status`:查看项目当前状态  
`git status -s`:可获得最简短的输出结果  
`git diff`:显示已写入缓存与已修改但尚未写入缓存的改动的区别。  
`git diff --cached`:查看已缓存的改动 
`git diff HEAD`:查看已缓存和未缓存的所有改动 
`git diff --stat`:显示摘要 
`git commit`:使用 git add 命令将想要快照的内容写入缓存区， 而执行 git commit 将缓存区内容添加到仓库中。 
`git reset HEAD`:取消已缓存的内容 
`git rm`:从git中移除某个文件，且工作区中的也会被移除 
`git rm -f`:删除之前修改过并且已经放到暂存区域 
`git rm --cached`:把文件从暂存区域移除，但仍然希望保留在当前工作目录中 
`git mv` :移动或重命名一个文件、目录、软连接 
`git log`:查看提交历史 
`git branch [branchName]`:创建分支 
`git checkout [branchName]`:切换分支 
`git merge`:合并分支 
`git branch`:列出所有分支 
`git branch -d [branchName]`:删除分支 
`git remote`: 显示远程仓库
`git remote add [name] [url]`:添加远程仓库 
`git remote -v`:列出所有远程仓库 
`git remote show [remote-name]`:查看远程仓库信息 
`git fetch [remote-name]`:从远程仓库抓取数据 
`git push [remote-name] [branch-name]`:推送数据到远程仓库 
`git pull [remote-name] [branch-name]`:住区数据合并到本地 
`git rename [old remote-name] [new remote-name]`:远程查库重命名 
`git rm [remote-name]`:删除远程仓库