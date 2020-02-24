---
title: spring boot和React跨域请求解决
comments: true
categories:
  - spring_boot
date: 2019-04-10 18:12:01
id: springboot&react
tags: [SpringBoot]
---
首先是在React，前端上只需要注意请求是POST请求，因为GET请求会有一个错误，然后就是用fetch传输了
```jsx
    handleSubmit = (e) => {
        e.preventDefault();
        this.props.form.validateFields((err, values) => {
            if (!err) {
                console.log('Received values of form: ', values);
                let data = new FormData();
                data.append("userName",values.userName);
                data.append("password",values.password);
                data.append("remember",values.remember);
                fetch("http://localhost:8080/post",{
                    method: 'POST',
                    body : data
                }).catch();
            }
        });
    };
```
然后主要是在spring boot这里，后端控制器要写入一行
```java
@CrossOrigin(origins = "http://localhost:3000")
```
然后就可以了

# (2019.05.22)
我发现似乎还是有问题，后来又有了新的方法
新建一个`CrosFilter`类，实现`Filter`接口
```java
import org.springframework.stereotype.Component;
import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author blankyk
 */
@Component
public class CrosFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        response.setHeader("Access-Control-Allow-Origin", "http://localhost:3000");
        response.setHeader("Access-Control-Allow-Methods", "*");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "*");
        response.setHeader("Access-Control-Allow-Credentials","true");
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }
}
```