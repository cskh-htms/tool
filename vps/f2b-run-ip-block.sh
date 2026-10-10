#!/bin/bash

#!/bin/bash
#
#
#
#
#
#
#
# Script để chặn các IP từ danh sách
iptables -I INPUT -s 103.116.8.31 -j ACCEPT
FILE="./f2b-ip-block.txt"
while IFS= read -r line
do
    IP=$(echo $line | awk '{print $1}')
    iptables -A INPUT -s $IP -j DROP
    echo "Blocked IP: $IP"
done < "$FILE"
