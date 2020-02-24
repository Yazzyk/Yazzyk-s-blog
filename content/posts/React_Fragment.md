---
title: "React Fragment"
date: 2019-05-27T15:12:56+08:00
hidden: false
draft: true
tags: [React]
keywords: []
description: ""
slug: ""
---

> [https://react.docschina.org/docs/fragments.html](https://react.docschina.org/docs/fragments.html)

`Fragment`相当于占位符吧，正常情况下，`React`中子组件只能返回一个Dom节点,而`Fragment`可以让你的子组件返回多个Dom节点  

父组件  
```js
import React, { Fragment } from 'react';
import ToDoItem from './ToDoItem';

class ToDoList extends React.Component {
    constructor(props) {
        super(props);
        //组价状态
        this.state = {
            inputValue: '',
            list: []
        }
        this.handleInputChange = this.handleInputChange.bind(this);
        this.handleBtnClick = this.handleBtnClick.bind(this);
        this.handleItemDel = this.handleItemDel.bind(this);
    }

    handleInputChange(msg) {
        this.setState({
            inputValue: msg.target.value
        })
    }

    handleBtnClick() {
        this.setState({
            list: [...this.state.list, this.state.inputValue],
            inputValue: ''
        })
    }

    handleItemDel(index) {
        const list = [...this.state.list];
        list.splice(index, 1);
        this.setState({
            list: list
        })
        // console.log(index);
    }

    getToDoItem(){
        return this.state.list.map((item, index) => {
            return (
                <div key={index}>
                    <ToDoItem 
                    content={item} 
                    handleItemDel={this.handleItemDel} 
                    />
                </div>
            )
        })
    }

    render() {

        return (
            <Fragment>
                <input 
                    type="text"
                    value={this.state.inputValue}
                    onChange={this.handleInputChange}
                />
                <button 
                onClick={this.handleBtnClick}
                >
                    提交
                </button>
                <ul>
                    {this.getToDoItem()}
                </ul>
            </Fragment>
        )
    }
}

export default ToDoList;
```  

子组件  
```js
import React,{Fragment} from 'react';

class ToDoItem extends React.Component{
    constructor(props){
        super(props);
        this.handleClick = this.handleClick.bind(this);
    }

    handleClick(){
        const {handleItemDel,indexKey} = this.props;
        handleItemDel(indexKey);
    }

    render(){
        const {content} = this.props;
        return(
            <Fragment>
                <div 
                onClick={this.handleClick}
                > 
                {content} 
                </div>
            </Fragment>
        )
    }
}

export default ToDoItem;
```