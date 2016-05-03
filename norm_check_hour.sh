#!/bin/bash

#cur1h=`date -u +%Y/%m/%d:%H`
past1h=`date -u +%Y/%m/%d:%H -d "1 hour ago"`

# web traffic
/usr/local/bin/rwfilter --start-date=$past1h --type=inweb --dport=80,443,8080 --pass=stdout | /usr/local/bin/rwcount --bin-size=60 --no-title > inweb.txt

/home/HSCNET/yli/RITA/p27/bin/python insert_data.py inweb.txt 

/usr/local/bin/rwfilter --start-date=$past1h --type=outweb --sport=80,443,8080 --pass=stdout | /usr/local/bin/rwcount --bin-size=60 --no-title > outweb.txt

/home/HSCNET/yli/RITA/p27/bin/python insert_data.py outweb.txt

# dns traffic
/usr/local/bin/rwfilter --start-date=$past1h --type=in --dport=53 --pass=stdout | /usr/local/bin/rwcount --bin-size=60 --no-title > indns.txt

/home/HSCNET/yli/RITA/p27/bin/python insert_data.py indns.txt

/usr/local/bin/rwfilter --start-date=$past1h --type=out --sport=53 --pass=stdout | /usr/local/bin/rwcount --bin-size=60 --no-title > outdns.txt

/home/HSCNET/yli/RITA/p27/bin/python insert_data.py outdns.txt

# smtp traffic
/usr/local/bin/rwfilter --start-date=$past1h --type=in --dport=25 --pass=stdout | /usr/local/bin/rwcount --bin-size=60 --no-title > insmtp.txt

/home/HSCNET/yli/RITA/p27/bin/python insert_data.py insmtp.txt

/usr/local/bin/rwfilter --start-date=$past1h --type=out --sport=25 --pass=stdout | /usr/local/bin/rwcount --bin-size=60 --no-title > outsmtp.txt

/home/HSCNET/yli/RITA/p27/bin/python insert_data.py outsmtp.txt

# total traffic
/usr/local/bin/rwfilter --start-date=$past1h --type=in --all-destination=stdout | /usr/local/bin/rwcount --bin-size=60 --no-title > intotal.txt

/home/HSCNET/yli/RITA/p27/bin/python insert_data.py intotal.txt

/usr/local/bin/rwfilter --start-date=$past1h --type=out --all-destination=stdout | /usr/local/bin/rwcount --bin-size=60 --no-title > outtotal.txt

/home/HSCNET/yli/RITA/p27/bin/python insert_data.py outtotal.txt
