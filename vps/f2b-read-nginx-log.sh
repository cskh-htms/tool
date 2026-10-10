#!/bin/bash



# 
# 
# 
# 
# 
# 
# 
# đọc file log của nginx
# sau đ1o lấy kết quả qua file f2b-ip-block.txt
# sau đó cấu chặc các ip nghi ngờ ddos 
#
# hãy sữa thời gian theo dỗi 10 là 10 p  (ví dụ 20) * 20
# rounded_minute = int(minute / 10) * 10;






ACCESS_LOG="/var/log/nginx/access.log"
RESULT_FILE="f2b-ip-block.txt"
IP_BLOCK_SCRIPT="f2b-ip-block.sh"

# Mã AWK
awk_script='
{
    split($4, datetime, "[:/]");
    split($5, timeparts, ":");
    date = datetime[1] "/" datetime[2] "/" datetime[3];
    hour = timeparts[1];
    minute = timeparts[2];
    rounded_minute = int(minute / 10) * 10;
    rounded_time = date " " hour ":" sprintf("%02d", rounded_minute);
    ip = $1;
    five_min_count[rounded_time " " ip]++;
}

END {
    # Biến để đếm tổng số IP
    ip_count = 0;
    
    for (entry in five_min_count) {
        if (five_min_count[entry] >= 1000) {
            split(entry, parts, " ");
            ip = parts[3];
            print ip;
            ip_count++;
        }
    }
    
    # Thêm tổng số IP vào cuối file
    print "Tổng số IP:" ip_count > "/dev/stderr";
}
'

# Chạy AWK script và ghi kết quả ra file
awk "$awk_script" "$ACCESS_LOG" > "$RESULT_FILE"

# Chạy các lệnh iptables
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X
sudo iptables -t raw -F
sudo iptables -t raw -X

# Chạy script f2b-ip-block.sh để đưa rule vào iptables
sudo bash "$IP_BLOCK_SCRIPT"

# Lưu cấu hình iptables và khởi động lại dịch vụ netfilter-persistent
sudo netfilter-persistent save
sudo systemctl restart netfilter-persistent

echo "Đã hoàn thành việc xử lý log và cập nhật iptables."
