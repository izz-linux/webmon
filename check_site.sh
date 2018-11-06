#!/bin/bash

LOGFILE=/home/izz/scripts/daxko/webcheck.log

if [ ! -f $LOGFILE ]
then
    touch $LOGFILE
fi

# run until stopped - custom log
while true
do
    # get the response based on return code - follow links to get 200 if up
    response=$(curl --write-out %{http_code} -sILo /dev/null daxko.izz.lan)

    # format time now for logging UTC
    #nowTime=`date -u '+%Y %b %d %H:%M:%S %Z'`
    nowTime=`date -u '+%Y %b %d %H:%M:%S'`

    isDown=0

    # alert user and write to log
    if [ $response != 200 ]
    then
        echo -e "$nowTime : FAILED - WEB CHECK" >> $LOGFILE
	mail -s "ALERT - WEB CHECK FAILURE!" -r IzzAlert@daxko.com izz@linux.com < $LOGFILE
	isDown=1
	#echo -e "DOWN - $nowTime\n"

    else
        if [ $isDown == 1 ]
	then
	    echo -e "$nowTime : RECOVERY - WEB CHECK" >> $LOGFILE
            mail -s "RECOVERY NOTIFICATION - WEB CHECK" -r IzzAlert@daxko.com izz@linux.com < $LOGFILE
    	    isDown=0
    	fi
    fi

    sleep 5
done

