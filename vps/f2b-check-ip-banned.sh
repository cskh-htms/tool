#!/bin/bash
# 
# 
# 
# 
# 
# 
# 
# kiểm tra xem ip này bị chặn bởi ai
IP="171.247.245.154"

# Lấy danh sách tất cả các jail và loại bỏ ký tự không mong muốn
jails=$(sudo fail2ban-client status | grep "Jail list:" | sed 's/^.*: //;s/,//g;s/`-//g')

# Kiểm tra từng jail
for jail in $jails; do
    jail=$(echo $jail | tr -d '[:space:]')  # Loại bỏ khoảng trắng
    echo "Checking jail: $jail"
    if sudo fail2ban-client status $jail | grep -q "$IP"; then
        echo "IP $IP is banned in jail $jail"
    else
        echo "IP $IP is not banned in jail $jail"
    fi
done
