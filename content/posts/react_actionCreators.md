---
title: "React&Redux actionCreators"
date: 2019-05-27T23:20:12+08:00
hidden: false
draft: false
tags: [react]
keywords: [react,redux,actionCreators]
description: ""
slug: ""
---

# 0x01 创建文件 
创建`actionCreators.js`
```js
import {INPUT_VALUE_CHANGE,ADD_TODO_ITEM,DEL_TODO_ITEM} from './ActionTypes';

export const getInputChangeAction = (value) =>({
    type : INPUT_VALUE_CHANGE,
    value
});

export const getAddItemAction = () =>({
    type: ADD_TODO_ITEM
});

export const getDelItemAction = (index)=>({
    type: DEL_TODO_ITEM,
    index
});
```
# 0x02 修改
修改`ToDoList.js`相关的地方
```js
    handleInputChange(e) {
        const action = getInputChangeAction(e.target.value);
        store.dispatch(action);
    }

    handleBtnClick() {
        const action = getAddItemAction();
        store.dispatch(action);
    }

    handleItemClick(index) {
        const action = getDelItemAction(index);
        store.dispatch(action);
    }
```