#!/bin/bash

while :
    do
        echo $(date "+%Y-%m-%d %H:%M:%S")
        ~/Documents/hugo_extended_0.86.1_macOS-64bit/hugo list all | awk 'BEGIN{FS=",";OFS="/"}{print $8}' | sed 's/https:\/\//https:\/\//gp;d' > urls.txt
        curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://shroot.dev&token=7v3EGPAwTPTXamcW"
        sleep 1d
done