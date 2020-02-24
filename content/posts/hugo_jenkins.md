---
title: "使用jenkins发布hugo博客"
date: 2020-02-24T22:36:47+08:00
draft: false
---

## 准备
1. jenkins 由于`jenkins`在我服务器上已经搭建好很久了,所以不讲解怎么搭建`jenkins`,详情可以去[jenkins官网](https://jenkins.io/zh/)查看  
2. 已经准备好发布的hugo博客
3. 一个git仓库,可以是`github`，`gitlab`等,我使用的是我自己服务器上的`gitea`
4. 服务器上已装好`hugo`
## 0x01
先在hugo博客根目录下创建`Jenkinsfile`文件,这个文件用于写Jenkinsfile的流水线,内容类似于：  
```json
#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        HUGO = '/bin/hugo'
        DEPLOY_DIR = '/www/wwwroot/css0209.cn/public'
    }
    stages {
          stage('Init') {
            steps {
                sh 'echo "hugo version:"'
                sh '$HUGO version'
            }
        }
        stage('Build') {
            steps {
                sh 'ls -a'
                sh '$HUGO --baseUrl="https://css0209.cn" -D'
                sh 'ls ./public'
            }
        }
        stage('Deploy') {
            steps {
                sh 'rm -rf $DEPLOY_DIR'
                sh 'mv ./public $DEPLOY_DIR'
                sh 'echo "deploy on $DEPLOY_DIR"'
            }
        }
    }
}
```
此处的`HUGO`是服务器上的`hugo的路径`,`DEPLOY_DIR`是`服务器上的部署位置`,关于`pipeline`可以参考[Jenkins官方文档 - 流水线](https://jenkins.io/zh/doc/book/pipeline/)  
写好`Jenkinsfile`后就可以`push到git仓库`去
## 0x02
push成功后,进入`jenkins`,点击`新建item`，选择`流水线`,输入`任务名称`,点击`确定`  
![](https://img.css0209.cn/hugo_jenkins/hugo_jenkins.png)  
然后进入`配置页面`前面的根据自己的需求勾选
![](https://img.css0209.cn/hugo_jenkins/hugo_jenkins02.png)  
重点在于下面的`流水线`
![](https://img.css0209.cn/hugo_jenkins/hugo_jenkins03.png)
具体参数根据自己修改,这里的`Credentials`是`git`的验证,似乎是公开库的话可以不用账号密码,但我也没试过公开仓库部署  
![](https://img.css0209.cn/hugo_jenkins/hugo_jenkins04.png)  
完成后`进入item`,点击`Build Now`即可开始构建,构建完成后会自动将新的博客部署到你的网站