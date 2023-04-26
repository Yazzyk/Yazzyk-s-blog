---
title: "golang makefile模板"
date: 2023-01-31T17:20:31+08:00
comments: true
id: makefile-tmp
categories:
  - 
tags: [go]
---

```makefile
.PHONY: build build_linux

APPNAME = wechatbot

all: build

build:
	rm -rf ./build/
	make build_linux

build_linux:
	@echo "linux版"
	export GO111MODULE=on; \
	export GOPROXY="https://goproxy.cn,direct"; \
	export GOOS=linux; \
	export GOARCH=amd64; \
	go mod tidy -compat=1.17; \
	go build -o ./build/$(APPNAME)_linux/$(APPNAME) main.go
	cp outText.txt ./build/$(APPNAME)_linux/outText.txt
```