---
title: BigDecimal总结
comments: true
categories:
  - Java
tags: [Java]
date: 2019-03-12 19:35:34
id: lanqiao
tags:
---
>参考：[https://www.jianshu.com/p/2947868d76eb](https://www.jianshu.com/p/2947868d76eb)
# 导包

```java
import java.math.BigDecimal;
```

# 构建

```java
BigDecimal BigDecimal(String s);
static BigDecimal valueOf(double d);
```

# 方法

 方法 | 描述 
--- | ----
 add(BigDecimal) | BigDecimal对象中的值相加，然后返回这个对象
 subtract(BigDecimal) | BigDecimal对象的值相减，然后返回这个对象
 multiply(BigDecimal) | BigDecimal对象中的值相乘，然后返回这个对象
 divide(BigDecimal) | BigDecimal对象中的值相除，然后返回这个对象
 toString() | 将BigDecimal对象的数值转换成字符串
 doubleValue() | 将BigDecimal对象的值以双精度数返回
 floatValue() | 将BigDecimal对象的值以单精度数返回
 longValue() | 将BigDecimal对象的值以长整型返回
 intValue() | 将BigDecimal对象的值以整数返回

# 格式化和四舍五入
```java
// 格式化：保留2为小数
DecimalFormat df = new DecimalFormat("#.##");
// 四舍五入，默认五舍六入
df.setRoundingMode(RoundingMode.HALF_UP);
```