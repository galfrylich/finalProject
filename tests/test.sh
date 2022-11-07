#!/bin/bash -ex 


STATUS_CODE=$(curl -Is 127.0.0.1:5000 | head -n 1)
if [ "$STATUS_CODE" == "HTTP/1.1 200 OK" ]; then
    echo "App is running"
else 
    echo "response code:" + $STSTUS_CODE + ", exit pipline"
    exit 1 
fi 
