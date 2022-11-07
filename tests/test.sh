#!/bin/bash -ex 


STATUS_CODE=$(curl -Is 127.0.0.1:5000 | head -n 1)
echo $STATUS_CODE
if [ "$STATUS_CODE" = "$STATUS_CODE" ]; then
    echo "App is running"
else 
    echo "response code: $STATUS_CODE , exit pipline"
    exit 1 
fi 
