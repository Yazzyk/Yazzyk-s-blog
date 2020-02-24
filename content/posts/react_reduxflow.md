---
title: "React之Redux工作流程"
date: 2019-05-27T19:13:18+08:00
hidden: false
draft: false
tags: [react]
keywords: [redux]
description: ""
slug: ""
---

> [阮一峰](http://www.ruanyifeng.com/blog/2016/09/redux_tutorial_part_one_basic_usages.html)  

![](http://www.ruanyifeng.com/blogimg/asset/2016/bg2016091802.jpg)

# 0x000
`render`函数
```js
render() {
    return (
        <div style={{ width: '500px', padding: '10px' }}>
            <Input
                value={this.state.inputValue}
                style={{ width: "400px", marginRight: "15px" }}
                onChange={this.handleInputChange}
            />
            <Button
                type="primary"
            >
                提交
            </Button>
            <List
                bordered
                dataSource={this.state.list}
                renderItem={item => (
                    <List.Item> {item} </List.Item>
                )}
            />
        </div>
    )
}
```

# 0x001
在`src`下创建`store/index.js`  
这里就创建好了Store
```js
import {createStore} from 'redux';
import reducer from './reducer';

const store = createStore();

export default store;
```
# 0x002
在`src/store`下创建`reducer.js`
```js
const defaultState={};

export default (state = defaultState,action)=>{
    return state;
}
```

# 0x003
发送`action`
```js
handleInputChange(e){
    // console.log(e.target.value);
    const action = {
        type:'input_value_change',
        value: e.target.value
    }
    store.dispatch(action);
}
```

# 0x004
检测数据的传递
```js
constructor(props) {
    super(props);
    store.subcribe(this.handleStoreChange)
}
handleStoreChange(){
    this.setState(store.getState());
}
```