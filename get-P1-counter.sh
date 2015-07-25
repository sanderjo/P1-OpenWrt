date > /www/P1/date-lastrun.txt
stty 9600 cs7 parenb -cstopb  -F /dev/ttyUSB0

TMPFILE=/tmp/P1-raw-output.txt	# the raw stuff from the USB / P1 port
MULTIP1FILE=/www/P1/teller5.txt	# cleaned up TMPFILE, to be published too for reference
RESULTFILE=/www/P1/result.txt 	# control file for humans
P1FILE=/www/P1/P1.txt		# the beautiful stuff we want

# starting copying stuff from USB port, and kill that process after 55 seconds:
# Warning: because of the $1, only put ONE command within the () !!!
(cat /dev/ttyUSB0 > $TMPFILE ) & pid=$! ; (sleep 55 && kill -9 $pid)

# remove strange characters and empty lines:
cat $TMPFILE | tr -d '\000' | grep -vi "^$" > $MULTIP1FILE 

if [ -s $MULTIP1FILE ]
then
	echo "file has some data." > $RESULTFILE
	# Find first '/' (=start of telegram) and print everything starting from there
	# Find '!' (=end of telegram), and start everyting before
        cat $MULTIP1FILE | sed -n '/\//,200 p' | sed -n '1,/\!/ p' > $P1FILE
        date >> $P1FILE
else
	echo "file is empty." > $RESULTFILE
fi
