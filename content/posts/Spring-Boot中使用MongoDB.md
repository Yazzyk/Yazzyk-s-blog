---
title: Spring Boot中使用MongoDB
comments: true
categories:
  - SpringBoot
date: 2019-04-14 15:27:30
id: springboot&mongodb
tags: [SpringBoot]
---

# pom文件中
```xml
<dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-mongodb</artifactId>
        </dependency>
</dependencies>
```
# application.properties中
```config
##mongo配置
spring.data.mongodb.host=127.0.0.1
spring.data.mongodb.port=27017
spring.data.mongodb.database=test
```

# 主类中
```java
@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)
```
