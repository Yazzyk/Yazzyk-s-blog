---
title: Chrome/Firefox非安全端口问题
url: 251.html
id: 251
comments: true
categories:
  - 日常
date: 2018-09-10 22:51:49
tags: [Web]
---

学校的端口号为95，是非安全端口，这里我来说一下这样用Chrome或者Firefox进入非安全端口

# Firefox:(Windows和Linux、macOS通用)

   (1) 地址栏输入`about:config`进入参数设置界面  
   (2) 鼠标右键新建新的字符串设置项，名称为：`network.security.ports.banned.override`  
   (3) 为新参数设定要允许的端口或端口范围，如：`95`  

# Chrome

## Windows下：

对Chrome的快捷方式右键，属性，在目标对应的文本框最后添加`--explicitly-allowed-ports=95` 这里的95就是需要访问的非安全端口如：   
`“C:\Program Files (x86)\Google\Chrome\Application\chrome.exe” --explicitly-allowed-ports=95`   
![](https://cloud.css0209.cn/2018/09/Windows_chrome.png)

## macOS下：

打开`Terminal`(终端) 输入命令：`/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --explicitly-allowed-ports=95` 这里的95就是需要访问的非安全端口
```zsh
1,    // tcpmux
7,    // echo
9,    // discard
11,   // systat
13,   // daytime
15,   // netstat
17,   // qotd
19,   // chargen
20,   // ftp data
21,   // ftp access
22,   // ssh
23,   // telnet
25,   // smtp
37,   // time
42,   // name
43,   // nicname
53,   // domain
77,   // priv-rjs
79,   // finger
87,   // ttylink
95,   // supdup
101,  // hostriame
102,  // iso-tsap
103,  // gppitnp
104,  // acr-nema
109,  // pop2
110,  // pop3
111,  // sunrpc
113,  // auth
115,  // sftp
117,  // uucp-path
119,  // nntp
123,  // NTP
135,  // loc-srv /epmap
139,  // netbios
143,  // imap2
179,  // BGP
389,  // ldap
465,  // smtp+ssl
512,  // print / exec
513,  // login
514,  // shell
515,  // printer
526,  // tempo
530,  // courier
531,  // chat
532,  // netnews
540,  // uucp
556,  // remotefs
563,  // nntp+ssl
587,  // stmp?
601,  // ??
636,  // ldap+ssl
993,  // ldap+ssl
995,  // pop3+ssl
2049, // nfs
3659, // apple-sasl / PasswordServer
4045, // lockd
6000, // X11
6665, // Alternate IRC \[Apple addition\]
6666, // Alternate IRC \[Apple addition\]
6667, // Standard IRC \[Apple addition\]
6668, // Alternate IRC \[Apple addition\]
6669, // Alternate IRC \[Apple addition\]
6669, // Alternate IRC \[Apple addition\]
```


当然，你用IE的话应该也是可以进去的，毕竟，你懂得 ![](https://cloud.css0209.cn/2018/09/chromefirefox.jpg)
