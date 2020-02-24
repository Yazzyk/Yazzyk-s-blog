---
title: 使用js渲染HTML表格
comments: true
categories:
  - web
date: 2019-03-04 14:44:10
id: js_to_table
tags: [Web]
---
# 突发奇想
那天，老师在上面讲一个HTML的表格，然后过于无聊的我，突发奇想，能不能用js来渲染繁琐复杂的表格，减少HTML的代码了量。
# HTML
``` HTML
<!DOCTYPE html>
<html lang="zh-Hans">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        table{
            border: 1px solid #000;
        }
        th,tr,td{
            border: 1px solid #000;
            text-align: center;
            padding: .5rem;
        }
    </style>
    <script src="js/index.js"></script>
</head>

<body>
    <script>
        context = [
            ['Name', 'Math', 'English', 'IT'],
            ['张三', 60, 80, 90],
            ['李四', 90, 80, 89],
            ['王五', 70, 89, 78]
        ]
        table(context);
    </script>
</body>
</html>
```
# JS
``` javascript
function table(context) {
    document.write('<table>');
    for (var i = 0; i < context.length; i++) {
        document.write('<tr>');
        for (var j = 0; j < context[i].length; j++) {
            if (i == 0) {
                document.write('<th>' + context[0][j] + '</th>');
            }else{
                document.write('<td>' + context[i][j] + '</td>');
            }
        }
        document.write('</tr>');
    }
    document.write('</table>');
}
```