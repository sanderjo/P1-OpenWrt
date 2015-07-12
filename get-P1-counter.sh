date > /www/P1/date.txt
stty 9600 crtscts cs7 parenb -cstopb -echo -F /dev/ttyUSB0
(cat /dev/ttyUSB0  > /tmp/teller5 ) & pid=$! ; (sleep 55 && kill -9 $pid)
#cat /tmp/teller5 | grep -vi "^$"

if [ -s /tmp/teller5 ]
then
	echo "file has some data." > /www/P1/result.txt
        # do something as file has data
        cat /tmp/teller5 | grep -vi "^$" | awk ' BEGIN {START=0}  /^\// {START=1}  { if (START==1) print $0 } /^!/ { if (START==1) exit 0 }  '  > /www/P1/P1.txt
        date >> /www/P1/P1.txt
else
	echo "file is empty." > /www/P1/result.txt
        # do something as file is empty 
fi
