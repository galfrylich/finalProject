#!/bin/bash -ex 

URL=$(curl  'http://checkip.amazonaws.com')
STSTUS_CODE=$(curl -Is $URL:5000 | head -n 1)
if [ $STSTUS_CODE == "HTTP/1.1 200 OK" ]; then
    echo "App is running"
else 
    echo "response code:" + $STSTUS_CODE + ", exit pipline"
    exit 1 

