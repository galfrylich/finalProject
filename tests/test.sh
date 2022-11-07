#!/bin/bash -ex 

curl  http://checkip.amazonaws.com
curl -Is http://checkip.amazonaws.com | head -n 1

