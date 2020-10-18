---
title: "Golang枚举实现，并制成字典反给前端使用"
date: 2020-10-18T16:30:50+08:00
draft: false
hidden: false
tags: [Golang]
keywords: [Golang]
---

# 方法  

```golang
package t

import (
	"reflect"
	"strconv"
)

type EnumType int8

func GetEnumMap(obj interface{}) (statusMap map[EnumType]string) {
	ta := reflect.TypeOf(obj)
	statusMap = make(map[EnumType]string)
	for i := 0; i < ta.NumField(); i++ {
		fl := ta.Field(i)
		statusNum, _ := strconv.Atoi(fl.Tag.Get("enum"))
		statusMap[EnumType(statusNum)] = fl.Tag.Get("desc")
	}
	return
}

func GetEnumByDesc(obj interface{}, desc string) EnumType {
	ta := reflect.TypeOf(obj)
	statusMap := make(map[string]EnumType)
	for i := 0; i < ta.NumField(); i++ {
		fl := ta.Field(i)
		statusNum, _ := strconv.Atoi(fl.Tag.Get("enum"))
		statusMap[fl.Tag.Get("desc")] = EnumType(statusNum)
	}
	return statusMap[desc]
}

func GetAllStatus() (statusList map[string]interface{}) {
	statusList = make(map[string]interface{})
	for _, v := range GetStatusObj() {
		statusList[reflect.TypeOf(v).Name()] = GetEnumMap(v)
	}
	return
}

```

# 枚举类

```golang
package t

func GetStatusObj() []interface{} {
	return []interface{}{
		UserStatus{},
		TaskStatus{},
	}
}

type UserStatus struct {
	InActivated EnumType `enum:"0" desc:"禁用"`
	Activated   EnumType `enum:"1" desc:"激活"`
}

func GetUserStatus() *UserStatus {
	return &UserStatus{
		InActivated: 0,
		Activated: 1,
	}
}

type TaskStatus struct {
	Waiting EnumType `enum:"0" desc:"排队中"`
	Working EnumType `enum:"1" desc:"处理中"`
	Finish  EnumType `enum:"2" desc:"已完成"`
}

func GetTaskStatus() *TaskStatus {
	return &TaskStatus{
		Waiting: 0,
		Working: 1,
		Finish:  2,
	}
}

```

# 使用
使用时，将后端的枚举返回给前端，如前端查询到的状态值为`1`,从字典中获取到`UserStatus[1]`  
前端返回后端时，直接使用`UserStatus[1]`返给后端，后端通过`GetEnumByDesc()`方法来获取到需要存入数据库的值
```golang
  bs, _ := json.Marshal(t.GetAllStatus())
  // 所有类型
	fmt.Println(t.GetAllStatus()) // map[TaskStatus:map[0:排队中 1:处理中 2:已完成] UserStatus:map[0:禁用 1:激活]]
  fmt.Println(string(bs[:])) // {"TaskStatus":{"0":"排队中","1":"处理中","2":"已完成"},"UserStatus":{"0":"禁用","1":"激活"}}
  // 后端使用，如存入数据库时
  fmt.Println(t.GetUserStatus().Activated) // 1
  // 从前端取得的值
  var descValue = "激活" // 前端传回值
	fmt.Println(t.GetEnumByDesc(t.UserStatus{}, descValue)) // 1
```
