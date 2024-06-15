---
title: "企业微信代理搭建"
date: 2023-10-24T21:52:09+08:00
comments: true
id: wechat-proxy
categories:
  - 
tags: [Caddy,nas,MoviePilot]
---

在搭建某nas相关的工具时需要通过企业微信自建应用实现通知和下达命令的功能  

本文使用Caddy作为代理服务器  
 
代理思路如下:  
![](https://plantuml.shroot.dev/png/bL9BJy8m7B_tK_Gc7W0DjnqyUfFu0RpKhMZZrhqw7ZSW4HSJCacCYGHZa6Wq4eONKHJvCki6tyB1ek5bYBUslzU_ltRZc37D5999JKQKMOgS45KbQMBTmbJ4SOcW8mCf0332P0oypvBtLkTV7M_Oz3vQmKK5O2h120Jc2Q4Q2kbGmXbaoMnNfIoD50oHGP0C0BAOIYtb41lJ9H8PoIA6eKe1y1jjtkYcaUdRLtwZoi-R_FfnJyqIl4zabS7u3ingfjUl_O9GW2Etvx-Keqb2DRyfndBv1CuZHPFnv2QRO56qx2D04KbIWJlLq6XU7lbpktj0VthI2qWZYHmcUK8JkZvXhSgORMfkua6RExLniHxStlkljbzomMfgv16UyiwTR_U2PrU0aI0IWmNqpr01JWDBwzAMMfcJ_RF61V-P7ddbD1ZKWgVXkEXmzvttByFXkTFY3-LOAhMr7UrMljkQBoB0i9dHy2nZQBCXKVOt)


Caddy代理配置如下：
```txt
# 企业微信填写的代理地址
api.example.com {
    reverse_proxy 172.17.0.1:3301
}
# MP填写的微信服务器代理地址
wx.example.com {
    reverse_proxy https://qyapi.weixin.qq.com {
        header_up Host {upstream_hostport}
    }
}
```

将`api.example.com`和`wx.example.com`替换成自己的域名或不同的端口号

> 注: 企业微信需要添加服务器IP到IP白名单  
> 注: MP添加域名的地址为(以上面实例域名为例) `api.example.com/api/v1/message/    `
> 注意最后的`/`
