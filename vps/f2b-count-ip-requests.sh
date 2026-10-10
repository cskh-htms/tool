#!/bin/bash
#
#
#
#
#
#
#
# theo dõi 1 ip thời gian bao nhiêu phút truy cập bao nhiểu lần
# ví dụ trong 1 phút truy cập bao nhiêu 

INTERFACE="eth0"
IP="51.79.248.208"
DURATION=1  # Thời gian theo dõi (giây)

while true; do
    COUNT=$(sudo timeout $DURATION tcpdump -i $INTERFACE src host $IP -nn 2>/dev/null | wc -l)
    echo "Yêu cầu từ IP $IP trong $DURATION giây: $COUNT"
    sleep $DURATION
done
