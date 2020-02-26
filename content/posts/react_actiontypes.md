---
title: "React&Redux ActionTypes"
date: 2019-05-27T22:54:38+08:00
hidden: false
draft: false
tags: [react]
keywords: [react,ActionTypes]
description: ""
slug: ""
---

# 0x00 前言
`ActionTypes`是为了防止在大型项目的开发中`action`中的`type`出现打错字之类的错误，此时，控制台不会报错，但功能异常。使用`ActionTypes`后，页面将会出现报错，减少排错时间

# 0x01 创建
创建`ActionTypes.js`文件
```js
export const INPUT_VALUE_CHANGE = 'input_value_change';
export const ADD_TODO_ITEM = 'add_todo_item';
export const DEL_TODO_ITEM = 'del_todo_item';
```
# 0x02 使用
在需要使用的文件中先引入
```js
import {INPUT_VALUE_CHANGE,ADD_TODO_ITEM,DEL_TODO_ITEM} from './store/ActionTypes';
```

接下来在`reducer.js`引入
```js
import {INPUT_VALUE_CHANGE,ADD_TODO_ITEM,DEL_TODO_ITEM} from './ActionTypes';
```

然后修改之前的内容