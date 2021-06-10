#!/bin/bash

echo  "Webaccess of the last hour:"
echo 
echo 

docker logs proxy_web_auto --since 1h |grep -i "overleaf."

echo 
echo 
echo 
echo 
echo 

echo  "\"POST\" entries in the last 30 min in log:"
echo 

docker logs proxy_web_auto --since 30m | grep "overleaf." | \grep  "\"POST"

echo 
echo 
echo 
echo 
echo 




