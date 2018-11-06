#!/bin/bash


# get the response based on return code - follow links to get 200 if up
response=$(curl --write-out %{http_code} -sILo /dev/null daxko.izz.lan)

# format time now for logging
nowTime=`date -u '+%Y %b %d %H:%M:%S %Z'`
#echo -e "The current response code at $nowTime is $response\n\n"

# alert user and write to log
if [ $response == 200 ]
then
    echo -e "UP - $nowTime\n"
else
    echo -e "DOWN - $nowTime\n"
fi



