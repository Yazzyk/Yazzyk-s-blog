---
title: Java 全排列
comments: true
categories:
  - 蓝桥杯,经验
date: 2019-03-18 17:58:38
id: algorithm
tags: [蓝桥杯]
---
> 学习视频：[bilibili](https://www.bilibili.com/video/av22391189/?p=2)p2

# 代码
```java
public class 递归全排列 {
    public static void main(String[] args) {
		// TODO 自动生成的方法存根
		char[] data = {'A','B','C'};
		fun(data, 0);
	}

  public static void fun(char[] data,int n) {
    if(n == data.length) {
      for(int i=0;i<data.length;i++) {
        System.out.print(data[i]+" ");
      }
      System.out.println();
    }
  
      for(int i=n;i<data.length;i++) {
      //试探  
      char t = data[n];  
      data[n] = data[i];  
      data[i] = t;  

      fun(data, n+1);
      //回溯  
      t = data[n];  
      data[n] = data[i];
      data[i] = t;
    }
  }
}

```
# output
```java
A B C 
A C B 
B A C 
B C A 
C B A 
C A B 

```