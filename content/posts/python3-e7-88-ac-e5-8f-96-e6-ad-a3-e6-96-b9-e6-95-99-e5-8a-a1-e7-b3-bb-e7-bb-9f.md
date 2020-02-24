---
title: Python3 正方爬虫
url: 103.html
id: 103
comments: true
categories:
  - Python
date: 2018-08-11 19:52:13
tags: [Python]
---

# 本篇文章以我所用教务系统为例

由于学校把课表关闭了，所以我现在先爬取的成绩查询 本项目的完整代码地址：[Github-zhengfang](https://github.com/idoctype/zhengfang) 首先观察学校官网的地址： [![](https://cloud.css0209.cn/2018/08/Xnip2018-08-12_19-57-19.jpg)](https://cloud.css0209.cn/2018/08/Xnip2018-08-12_19-57-19.jpg) 原本的地址是 https://220.167.53.63:95/ 然后变成 https://220.167.53.63:95/(4eggunep4b4jhzfwhk4pva21)/default2.aspx 首先端口使用的95端口，95端口是非安全端口，现在的主流浏览器应该是无法访问的，这里我只提供要用到的Chrome的Mac版的解决方案,具体可以参考我的文章 [Chrome/Firefox非安全端口问题](https://css0209.cn/2018/09/10/251/) 打开终端复制以下命令，最后的`--explicitly-allowed-ports=95`中的95就是你想打开的非安全端口号

/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --explicitly-allowed-ports=95 

然后是`(4eggunep4b4jhzfwhk4pva21)`中间的这窜数字，刷新几次后发现这个是会变的，也就是不确定的 default2.aspx是登录页面 再来看看NetWork的信息 [![](https://cloud.css0209.cn/2018/08/8FF2E09F-E9C7-44AC-980E-204355B34118.jpg)](https://cloud.css0209.cn/2018/08/8FF2E09F-E9C7-44AC-980E-204355B34118.jpg) 在我们访问https://220.167.53.63:95/时进行了以个302跳转，那么在302跳转之前是个什么东西呢？ 我用Burp Suite Professional抓包工具来看看：  [![](https://cloud.css0209.cn/2018/08/F138B3AB-E6F8-4FFA-92F5-29F5C9744776.jpg)](https://cloud.css0209.cn/2018/08/F138B3AB-E6F8-4FFA-92F5-29F5C9744776.jpg) 得到上图中的信息然后我们可以发现`(bfpyl355aa3owdf50bdgfg55)`正好是我们需要的那段随机生成的值，也就是说，我们可以通过先爬取这个页面中的内容获得这个值，我们将这个值命名为token，然后代码如下： （由于这个博客的编辑器比较皮，所以格式可能有点不对，没法输制表符）

````python
-*- coding: UTF-8 -*-
    import urllib.parse
    import requests
    import re
    import PIL
    from PIL import Image
    from bs4 import BeautifulSoup

    session = requests.Session() # 初始化session

    class ZF:
     初始化
         def __init__(self):
               self.url = 'https://220.167.53.63:95/' # 链接
               s = session.get('{}default2.aspx'.format(self.url),allow_redirects=False) # allow_redirects:重定向；会话，get方法获取页面，防止302重定向
               pattern = re.compile("href='/\((\w*)\)") # 正则表达式
               token = pattern.findall(s.text) # 查询页面中信息，匹配正则表达式并保存到列表token
               self.token = token[0] # 取出列表中的token,并赋值
               self.index_url = "https://220.167.53.63:95/({})/default2.aspx".format(self.token) # 定义主页地址 
````
接下来我们登录观察并获取信息： [](https://www.css0209.cn/wp-content/uploads/2018/08/9F85AC9C-3E51-4AB2-B82A-0288A1C7A618-300x169.jpg)[![](https://cloud.css0209.cn/2018/08/9F85AC9C-3E51-4AB2-B82A-0288A1C7A618.jpg)](https://cloud.css0209.cn/2018/08/9F85AC9C-3E51-4AB2-B82A-0288A1C7A618-300x169.jpg) 通过观察发现url地址的`defult2.aspx`变成了`xs_main.aspx?xh=[学号]` 提交的表单信息中有6个值

# __VIEWSTATE

不知道是什么东西，但是会变，猜测和`csrf`类似  

值 | 内容  
--- | ---  
TextBox1 | 学号  
TextBox2 | 密码  
TextBox3 | 验证码  
RadioButtonList1 | 登录页面学生的那个选框
Button1 | 永远都是空白

学号，密码，可以通过用户输入得到 `Button1`,和`RadioButtonList1`的值是固定的，而且`RadioButtonList1`如果在表单中不存在就会默认为学生选项 也就是说我们只需要解决验证码和`__VIEWSTATE`的值

回到登录页面观察form表单 [](https://cloud.css0209.cn/2018/08/BD67EEAA-9F8A-4362-B9D2-9C34CB854145-300x163.jpg)[![](https://cloud.css0209.cn/2018/08/BD67EEAA-9F8A-4362-B9D2-9C34CB854145.jpg)](https://cloud.css0209.cn/2018/08/BD67EEAA-9F8A-4362-B9D2-9C34CB854145-300x163.jpg) 很快便可以发现在form标签后面紧跟了一个input标签里面的value就是我们要的__VIEWSTATE的值 那么代码如下:
````python3
# -*- coding: UTF-8 -*-
import urllib.parse
import requests
import re
import PIL
from PIL import Image
from bs4 import BeautifulSoup

session = requests.Session()  # 初始化session


class ZF:
    # 初始化
    def __init__(self):
        self.url = 'http://220.167.53.63:95/'  # 链接
        s = session.get('{}default2.aspx'.format(self.url),
                        allow_redirects=False)  # allow_redirects:重定向；会话，get方法获取页面，防止302重定向
        pattern = re.compile("href='/\((\w*)\)")  # 正则表达式
        token = pattern.findall(s.text)  # 查询页面中信息，匹配正则表达式并保存到列表token
        self.token = token[0]  # 取出列表中的token,并赋值
        self.index_url = "http://220.167.53.63:95/({})/default2.aspx".format(self.token)  # 定义主页地址
        # requests过去页面信息
        r = requests.get(self.index_url)
        r.encoding = r.apparent_encoding
        # beautifulsoup格式化内容，用lxml解析
        soup = BeautifulSoup(r.text, 'lxml')
        # 从页面中获取__VIEWSTATE
        self.__VIEWSTATE = soup.select_one('input[name="__VIEWSTATE"]').get("value")
        # 学号和密码
        # self.user = ''
        # self.pwd = ''
        self.user = input("请输入学号：")
        self.pwd = input("请输入密码：")
````
# 验证码

验证码获取很简单: 直接鼠标右键复制图片链接，复制下来会发现就是`default2.aspx`变成了`CheckCode.aspx` ![](https://cloud.css0209.cn/2018/08/F0696265-FDA9-49E9-A2EA-D9B041B8687E.jpg) 那么我们只需要把验证码以二进制的形式下载下来，需要的时候调用，能打开显示就行 代码如下:
```python3
# 获取验证码图片并保存至本地，再打开
    def captchas(self):
        try:
            url = "https://220.167.53.63:95/({})/CheckCode.aspx".format(self.token)  # 验证码图片地址
            img_r = requests.get(url)  # 获取验证码图片
            # 以二进制保存至本地
            with open('./img/captcha.jpg', 'wb') as f:
                f.write(img_r.content)
            # 利用PIL打开图片
            PIL.Image.open('./img/captcha.jpg').show()
            # 让用户输入验证码
            return input("请输入验证码：")
        except:
            print("error:获取验证码失败") 
```
获取了需要的信息，我们就可以进行模拟登陆了，这里我们登录后获取一下用户姓名并URL化，后面会用到:

# 模拟登陆
```python3
    def login(self):
        # http://220.167.53.63:95/(2gfd5m3bax5l2rigc0yfiofq)/xs_main.aspx?xh=201713013059
        try:

            url = "http://220.167.53.63:95/({})/default2.aspx".format(self.token)  # 生成登陆地址
            # 用字典保存data
            data = {
                '__VIEWSTATE': self.__VIEWSTATE,
                'TextBox1': self.user,
                'TextBox2': self.pwd,
                'TextBox3': self.captchas(),
                'Button1': ''
            }
            r = session.post(url, data=data)
            r.encoding = r.apparent_encoding  # 修改编码为网页编码
            # 检查提交后URL中是否含有'xs_main.aspx?xh='，如果有就表示登陆成功
            if 'xs_main.aspx?xh=' in r.url:
                soup = BeautifulSoup(r.text, 'lxml')
                print('登陆成功\n欢迎您：', soup.select_one('.info span#xhxm').text)
                # 获取姓名
                name = re.sub('同学', '', soup.select_one('.info span#xhxm').text)
                # 将姓名URL化
                xm = urllib.parse.quote(name)
                return xm
            else:
                print('登陆失败', r.url)
        except:
            print("error:登录出错")
```

接下来进行一次查询操作 ![](https://cloud.css0209.cn/2018/08/QQ20180812-183454.png) 
可以看到这个东西  
`https://220.167.53.63:95/(xg1yk155oifue555urpnb0ng)/xscjcx.aspx?xh=\[学号\]&xm=\[URL化的姓名\]&gnmkdm=N121605`   
这个地址是声明我们从哪里来的，我们可以由拼接生成
````python
 # 获取URL化后的姓名
            name = self.login()#这里是刚刚获取的URL话的名字
            grade_url = "{}({})/xscjcx.aspx?xh={}&xm={}&gnmkdm=N121605".format(self.url, self.token, self.user, name)  # 生成URL 

我们要把这个写入headers，这里要注意的是这个headers里Referer是一定要有的

    header = {
                    "Referer": grade_url,  # Referer必须有
                    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.110 Safari/537.36"
                }  # 生成header 
````
再来看下我们提交的东西   ![](https://cloud.css0209.cn/2018/08/QQ20180812-183734.png) 
这一看，妈哟！这么长的什么东西！？ 不要慌，回到之前页面看看 从表单那可以看到这么些东西   
![](https://cloud.css0209.cn/2018/08/QQ20180812-204015.png)   可以发现这些值就是我们需要的，那么爬取下来即可
````python
    r = requests.get(grade_url, headers=header)
                r.encoding = r.apparent_encoding
                """
                r = requests.get("{}/{}/xscjcx.aspx?{}".format(self.url, self.token, urllib.parse.urlencode({
                    'xh': self.user,
                    'xm': info[2],
                    'gnmkdm': 'N121603'
                })))
                """
                soup = BeautifulSoup(r.text, 'lxml')
                # 获取表单信息
                __EVENTTARGET = soup.select_one('input[name="__EVENTTARGET"]').get("value")
                __EVENTARGUMENT = soup.select_one('input[name="__EVENTARGUMENT"]').get("value")
                new__VIEWSTATE = soup.select_one('input[name="__VIEWSTATE"]').get("value") 
````
值 | 对应的value
--- | ---
那么还有4个值 | ddlXN
表单中的学年 | ddlXQ
表单中的学期 | ddl_kcxz
表单中的课程性质 | btn_xq
点击的哪个按钮，这里我默认用学期成绩按钮

这里的`ddlXN`和`ddlXQ`我们让用户来输入 `ddl_kcxz`设为空和`btn_xq`为URL化的“学期成绩” 把表单信息存入data
````python
 grade_data = {
                "__EVENTTARGET": __EVENTTARGET,
                "__EVENTARGUMENT": __EVENTARGUMENT,
                "__VIEWSTATE": new__VIEWSTATE,
                "ddlXN": input("请输入学年(如：2017-2018):"),
                "ddlXQ": input("请输入学期(如：1):"),
                "ddl_kcxz": "",
                "btn_xq": urllib.parse.quote("学期成绩")
            } 
````
有了信息后我们进行访问，会获得一些信息,然后我们将这些信息提取出来,然后写入HTML文档里
````python
            grade_html = session.post(grade_url, headers=header, data=grade_data)
            soup_grade = BeautifulSoup(grade_html.text, 'lxml')
            title = soup_grade.select('font[size="4"]')[0].text  # 标题
            xh = soup_grade.select_one('span#lbl_xh').text  # 学号
            xm = soup_grade.select_one('span#lbl_xm').text  # 姓名
            xy = soup_grade.select_one('span#lbl_xy').text  # 学院
            zy = '专业：{}'.format(soup_grade.select_one('span#lbl_zymc').text)  # 专业
            xzb = soup_grade.select_one('span#lbl_xzb').text  # 行政班
            table = soup_grade.select_one('table#Datagrid1').prettify()  # 成绩表
            grade_table = re.sub('"datelist"', '"mdui-table"', table)
            grade = title + "<br/>" + xh + "<br/>" + xm + "<br/>" + xy + "<br/>" + zy + "<br/>" + xzb + "<br/>" + grade_table
            html = '''<!doctype html>
    <html lang="zh-cn">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>{}同学的成绩单</title>
        <link rel="stylesheet" href="http://cdnjs.loli.net/ajax/libs/mdui/0.4.1/css/mdui.min.css">
    </head>
    <body>
            '''.format(urllib.parse.unquote(name))
            # 将内容写入html文件
            with open('./index.html', 'a+') as f:
                f.truncate(0)
                f.write(html + grade)
            print("it's done!")
        except:
            print("error:获取成绩单出错")
````
完整代码：  [GitHub](httpw://github.com/idoctype/zhengfang)
接下来，我想把这个用Django写成web端，但是验证码哪里给卡着了
