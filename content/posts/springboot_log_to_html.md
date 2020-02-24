---
title: "Springboot日志显示到Web"
date: 2019-06-15T20:05:13+08:00
hidden: false
draft: false
tags: [web]
keywords: [springboot,log,web,html]
description: ""
slug: ""
---

# 0x01
首先要在服务器端运行打包好的jar包，并将log打印到指定文件中
```shell
nohup java -jar /www/wwwroot/air.css0209.cn/air-0.0.1-SNAPSHOT.jar > /www/wwwroot/air.console.css0209.cn/nohup.txt
```
`具体是什么文件，根据你自己的情况来改`  

# 0x02
在`HTML`文件中写入
```html
<!DOCTYPE html>
<html lang="zh-Hans">
<head>
    <meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
  	<meta name="theme-color" content="#222">
    <title>后端输出内容</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <style>
        html{
            padding: 0;
            margin: 0;
            overflow-x: hidden;
        }
      	h1{
      		padding: 0;
            margin: 0;
          	text-align: center;
        }
        body{
            padding: 0;
            margin: 0;
          background-color: #222;
        }
        #main{
            width: 100%;
            height: 100%;
            background-color: #222;
            
            color: #fff;
            padding: 20px 0;
            min-height: 800px;
        }
        textarea{
            width: 100%;
            height: 100%;
            background: #222;
            color: #fff;
            border: none;
          	padding: 30px;
            min-height: 820px;
          	font-family: Monaco;
        }
      @media screen and (max-width: 700px){
        textarea{
        	padding: 0;
        }
      }
      textarea:focus{
      	outline: none;
      }
    </style>
</head>
<body>
    <div id="main">
        <h1>后端输出</h1>
        <textarea id="info" readonly=""></textarea>
    </div>
    <script>
      var line = 1;
        setInterval(function(){
    	$.ajax({
          url: 'nohup.txt',
          dataType: 'text',
          success: function(data) {
            $('#info').html(data);
            var scrollTop = $("#info")[0].scrollHeight;
            if(line != scrollTop){
              line = scrollTop;
              console.log("new log"+line);
              $("#info").scrollTop(line);
            }
          }
    });
},1000);
    </script>
</body>
</html>
```
然后边可以在web端查看你的springboot的log内容了。