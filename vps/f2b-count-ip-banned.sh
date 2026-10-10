#!/bin/bash
# 
# 
# 
# 
# 
# 
# 
# Xem có bao nhiêu ip đang bị chặn
total_banned=0

for jail in $(sudo fail2ban-client status | grep 'Jail list' | cut -d ':' -f2 | tr ',' ' '); do
    count=$(sudo fail2ban-client status $jail | grep 'Currently banned' | awk '{print $4}')
    total_banned=$((total_banned + count))
    echo "Jail $jail: $count IP(s) banned"
done

echo "Total IP(s) banned: $total_banned"
