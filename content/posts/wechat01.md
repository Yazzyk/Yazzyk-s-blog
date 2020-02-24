---
title: "微信开发 - 环境搭建"
date: 2019-12-25T20:18:14+08:00
hidden: false
draft: false
tags: [Java, Wechat, ngrok, SpringBoot, WebFlux, MyBatis]
keywords: [Java, Wechat, ngrok, SpringBoot, WebFlux, MyBatis]
description: ""
slug: ""
---
## 环境搭建

前往[ngrok](http://www.ngrok.cc)下载指定客户端到本地  

注册并登陆,开通一个隧道  

<a href="https://img.css0209.cn/wechat/wechat01.png" target="_blank">![](https://img.css0209.cn/wechat/wechat01.png)
</a>  
到隧道管理可编辑自定义域名,复制隧道id  

通过客户端启动隧道即可,以MacOS为例,在下载的客户端目录下,终端输入

```bash
./sunny clientid 隧道id
```
> [文档](http://ngrok.cc/_book/start/ngrok_linux.html)

输入后`status`显示为`online`即可通过域名访问到本地对应端口

## 使用SpringBoot开始搭建后端

这里因为公司用的`Gradle`,为了学习,我也使用的`Gradle`

使用到的技术:

- Spring WebFlux
- Lombok
- hutool
- 通用mapper
- mapper自动生成器

`build.gradle`文件:

```txt
plugins {
    id 'org.springframework.boot' version '2.2.2.RELEASE'
    id 'io.spring.dependency-management' version '1.0.8.RELEASE'
    id 'java'
}

group = 'cn.css0209'
version = '0.0.1-SNAPSHOT'
sourceCompatibility = '1.8'

configurations {
    developmentOnly
    runtimeClasspath {
        extendsFrom developmentOnly
    }
    compileOnly {
        extendsFrom annotationProcessor
    }
    mybatisGenerator
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-jdbc'
    implementation 'org.springframework.boot:spring-boot-starter-webflux'
    implementation 'org.mybatis.spring.boot:mybatis-spring-boot-starter:2.1.1'
    compileOnly 'org.projectlombok:lombok'
    developmentOnly 'org.springframework.boot:spring-boot-devtools'
    compile 'mysql:mysql-connector-java'
    annotationProcessor 'org.projectlombok:lombok'
    testImplementation('org.springframework.boot:spring-boot-starter-test') {
        exclude group: 'org.junit.vintage', module: 'junit-vintage-engine'
    }
    testImplementation 'io.projectreactor:reactor-test'
    compile 'cn.hutool:hutool-all:5.0.7'
    // https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-configuration-processor
    annotationProcessor "org.springframework.boot:spring-boot-configuration-processor"
    compile 'org.mybatis.generator:mybatis-generator-core:1.3.6'
    compile 'tk.mybatis:mapper:4.0.0'
    // https://mvnrepository.com/artifact/tk.mybatis/mapper-core
    compile group: 'tk.mybatis', name: 'mapper-core', version: '1.1.5'
    // https://mvnrepository.com/artifact/tk.mybatis/mapper-weekend
    compile group: 'tk.mybatis', name: 'mapper-weekend', version: '1.1.5'
    compile 'cn.hutool:hutool-all:5.0.7'
    mybatisGenerator 'org.mybatis.generator:mybatis-generator-core:1.3.6'
    mybatisGenerator 'mysql:mysql-connector-java'
    mybatisGenerator 'tk.mybatis:mapper:4.0.0'
}


test {
    useJUnitPlatform()
}

def getDbProperties = {
    def properties = new Properties()
    file("src/main/resources/conf/jdbc.properties").withInputStream { inputStream ->
        properties.load(inputStream)
    }
    properties
}

task mybatisGenerate {
    def properties = getDbProperties()
    ant.properties['targetProject'] = projectDir.path
    ant.properties['driverClass'] = properties.getProperty("jdbc.driverClassName")
    ant.properties['connectionURL'] = properties.getProperty("jdbc.url")
    ant.properties['userId'] = properties.getProperty("jdbc.username")
    ant.properties['password'] = properties.getProperty("jdbc.password")
    ant.properties['src_main_java'] = sourceSets.main.java.srcDirs[0].path
    ant.properties['src_main_resources'] = sourceSets.main.resources.srcDirs[0].path
    ant.properties['modelPackage'] = properties.getProperty("package.model")
    ant.properties['mapperPackage'] = properties.getProperty("package.mapper")
    ant.properties['sqlMapperPackage'] = properties.getProperty("package.xml")
    ant.taskdef(
            name: 'mbgenerator',
            classname: 'org.mybatis.generator.ant.GeneratorAntTask',
            classpath: configurations.mybatisGenerator.asPath
    )
    ant.mbgenerator(overwrite: true,
            configfile: 'src/main/resources/conf/generator.xml', verbose: true) {
        propertyset {
            propertyref(name: 'targetProject')
            propertyref(name: 'userId')
            propertyref(name: 'driverClass')
            propertyref(name: 'connectionURL')
            propertyref(name: 'password')
            propertyref(name: 'src_main_java')
            propertyref(name: 'src_main_resources')
            propertyref(name: 'modelPackage')
            propertyref(name: 'mapperPackage')
            propertyref(name: 'sqlMapperPackage')
        }
    }
}

```

在`resource`文件下创建`conf`文件夹,在文件夹下创建`generator.xml`和`jdbc.properties`两个文件  

文件内容如下:

`generator.xml`:

```
<!DOCTYPE generatorConfiguration
        PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">

<!--suppress MybatisGenerateCustomPluginInspection -->
<generatorConfiguration>
    <context id="Mysql" targetRuntime="MyBatis3Simple" defaultModelType="flat">
        <property name="javaFileEncoding" value="UTF-8"/>
        <property name="useMapperCommentGenerator" value="false"/>

        <plugin type="tk.mybatis.mapper.generator.MapperPlugin">
            <property name="mappers" value="tk.mybatis.mapper.common.Mapper"/>
            <property name="caseSensitive" value="true"/>
            <property name="forceAnnotation" value="true"/>
            <property name="beginningDelimiter" value="`"/>
            <property name="endingDelimiter" value="`"/>
        </plugin>

        <jdbcConnection driverClass="${driverClass}"
                        connectionURL="${connectionURL}"
                        userId="${userId}"
                        password="${password}">
        </jdbcConnection>

        <!--MyBatis 生成器只需要生成 Model-->
        <javaModelGenerator targetPackage="${modelPackage}"
                            targetProject="${src_main_java}">
            <property name="enableSubPackages" value="true"/>
            <property name="trimStrings" value="true"/>
        </javaModelGenerator>

        <sqlMapGenerator targetPackage="${sqlMapperPackage}"
                         targetProject="${src_main_resources}">
            <property name="enableSubPackages" value="true"/>
        </sqlMapGenerator>

        <javaClientGenerator targetPackage="${mapperPackage}"
                             targetProject="${src_main_java}" type="XMLMAPPER">
            <property name="enableSubPackages" value="true"/>
        </javaClientGenerator>
<!--        根据自己需求修改 -->
        <table tableName="表名" domainObjectName="实体类名"
               enableCountByExample="false" enableUpdateByExample="false"
               enableDeleteByExample="false" enableSelectByExample="false"
               selectByExampleQueryId="false">
            <generatedKey column="主键名" sqlStatement="Mysql" identity="true"/>
        </table>
    </context>
</generatorConfiguration>
```

生成器在默认情况下会生成一个Example类，使用

```xml
enableCountByExample="false" enableUpdateByExample="false"
enableDeleteByExample="false" enableSelectByExample="false"
selectByExampleQueryId="false"
```

可以避免生成

`jdbc.properties`:

```properties
# JDBC 驱动类名
jdbc.driverClassName=com.mysql.cj.jdbc.Driver
# JDBC URL: jdbc:mysql:// + 数据库主机地址 + 端口号 + 数据库名
jdbc.url=
# JDBC 用户名及密码
jdbc.username=
jdbc.password=

# 生成实体类所在的包
package.model= cn.css0209.wechat.entity
# 生成 mapper 类所在的包
package.mapper= cn.css0209.wechat.mapper
# 生成 mapper xml 文件所在的包，默认存储在 resources 目录下
package.xml=mybatis
```

重新加载`gradle`后,应该就会自动生成一个实体类,一个mapper接口,一个在resources下的xml文件。

最后在`application.java`中加入注解

```java
@EnableWebFlux
@MapperScan("cn.css0209.wechat.mapper")
```

这样自动生成器的搭建就完成了  

## 微信公众号接入

前往[微信公众平台](https://mp.weixin.qq.com/),登陆后到`基本配置页面`->`服务器配置`->`修改配置`,在url填入之前ngrok的域名,随便输一个`token`随机生成一个`EncodingAESKey`,消息加密方式根据自身情况选择,我选安全模式这里先不提交,将页面保留,去完善java代码

`application.properties`文件名改为`application.yml`

文件内容如下:

```yaml
wechat:
  appid: 微信公众号appid
  secret: AppSecret
  token: token
  aesKey: EncodingAESKey

server:
  port: ngrok注册时的端口号
  
spring:
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: 数据库地址
    username: 数据库用户名
    password: 数据库密码
```

接下来先检查是否在`build.gradle`中引入了`spring-boot-configuration-processor`

```
// https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-configuration-processor
    annotationProcessor "org.springframework.boot:spring-boot-configuration-processor"
```

创建一个`config`包,在包下创建`Wechat.java`

这个使用了`lombok`,注意装插件

```java
@Component
@Data
@ConfigurationProperties(prefix = "wechat")
public class WeChatConfig {
    private String appid;
    private String secret;
    private String token;
    private String aesKey;
}
```

创建`controller`包,创建`WeChatValidationController`控制器

```java
@RestController
@RequestMapping("/")
public class WeChatValidationController {
    @Autowired
    private WeChatValidationService servcie;

    /**
     * 微信接入验证
     *
     * @param signature  微信加密签名，signature结合了开发者填写的token参数和请求中的timestamp参数、nonce参数。
     * @param timestamp 时间戳
     * @param nonce     随机数
     * @param echostr   随机字符串
     * @return
     */
    @GetMapping
    public Mono<String> validation(@RequestParam(name = "signature") String signature,
                                   @RequestParam(name = "timestamp") String timestamp,
                                   @RequestParam(name = "nonce") String nonce,
                                   @RequestParam(name = "echostr") String echostr) {
        return servcie.validation(signature, timestamp, nonce, echostr);
    }
}
```

创建`service`包,创建`WeChatValidationService`类

根据[官方文档](https://developers.weixin.qq.com/doc/offiaccount/Basic_Information/Access_Overview.html)

```java
@Service
@Slf4j
public class WeChatValidationService {
    private final WeChatConfig config;

    public WeChatValidationService(WeChatConfig config) {
        this.config = config;
    }

    public Mono<String> validation(String signture, String timestamp, String nonce, String echostr) {
        return Mono.just(1).map(n -> {
            String[] checkArr = new String[]{config.getToken(), timestamp, nonce};
            Arrays.sort(checkArr);
            String mySign = SecureUtil.sha1(checkArr[0] + checkArr[1] + checkArr[2]);
            return signChect(signture, mySign, echostr);
        }).doOnError(Throwable::printStackTrace);
    }

    private String signChect(String signture, String mySign, String echostr) {
        log.info("微信signture:{},我的sign:{}", signture, mySign);
        if (signture.equals(mySign)) {
            log.info("接入成功");
            return echostr;
        } else {
            log.info("接入失败");
            return "接入失败";
        }
    }
}
```

最后加上个骚气的`banner.txt`

在`resource`下创建`banner.txt`文件

```
${AnsiColor.BLUE}
 _______            __            _______   __
/       \          /  |          /       \ /  |
$$$$$$$  | ______  $$ |  ______  $$$$$$$  |$$ | __    __   ______
$$ |__$$ |/      \ $$ | /      \ $$ |__$$ |$$ |/  |  /  | /      \
$$    $$/ $$$$$$  |$$ |/$$$$$$  |$$    $$< $$ |$$ |  $$ |/$$$$$$  |
$$$$$$$/  /    $$ |$$ |$$    $$ |$$$$$$$  |$$ |$$ |  $$ |$$    $$ |
$$ |     /$$$$$$$ |$$ |$$$$$$$$/ $$ |__$$ |$$ |$$ \__$$ |$$$$$$$$/
$$ |     $$    $$ |$$ |$$       |$$    $$/ $$ |$$    $$/ $$       |
$$/       $$$$$$$/ $$/  $$$$$$$/ $$$$$$$/  $$/  $$$$$$/   $$$$$$$/

SpringBoot Version: ${spring-boot.version}

```