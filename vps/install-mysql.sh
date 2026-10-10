#
#
#
#
#
# khai báo biến 
MYSQL_CONFIG_FILE="/etc/mysql/mysql.conf.d/mysqld.cnf"








#
#
#
#mysql
wget https://dev.mysql.com/get/mysql-apt-config_0.8.30-1_all.deb 
sudo dpkg -i mysql-apt-config_0.8.30-1_all.deb 
sudo apt update


# Cài đặt MySQL Server
sudo apt install mysql-server -y
sudo apt install mysql-shell -y



# Tự động chạy các lệnh MySQL để tạo database và user
sudo mysql -u root -pThanhThao@2003@1105 <<EOF

CREATE USER 'root_sudo'@'localhost' IDENTIFIED BY 'Vanluc@2003@1105@sudo';
GRANT CREATE, SELECT, INSERT, DELETE, UPDATE ON *.* TO 'root_sudo'@'localhost';
FLUSH PRIVILEGES;




create database wpdb;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'Vanluc@2003';
GRANT CREATE, SELECT, INSERT, DELETE, UPDATE ON *.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;



EOF

# Kích hoạt MySQL để tự động khởi động cùng hệ thống
sudo systemctl enable mysql 
echo "đã cài mysql mysql-shell và tạo user thành công"



