#!/bin/bash

# run until stopped - stdout
while true
do
    # get the response based on return code - follow links to get 200 if up
    response=$(curl --write-out %{http_code} -sILo /dev/null daxko.izz.lan)

    # format time now for logging
    nowTime=`date -u '+%Y %b %d %H:%M:%S %Z'`

    # alert user and write to log
    if [ $response != 200 ]
    then
        echo -e "DOWN - $nowTime\n"
    else
        echo -e "UP - $nowTime\n"
    fi

    sleep 5
done

