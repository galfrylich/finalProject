#!/bin/bash -ex 

curl  http://checkip.amazonaws.com
curl -Is http://checkip.amazonaws.co | head -n 1

