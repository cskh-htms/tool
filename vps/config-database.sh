#!/bin/bash
#
#
#
#
#
#
#
#
#
#
#
#
#
#!/bin/bash

# Sao chép file mysqld.cnf và ghi đè file cũ nếu có
if sudo cp -f ~/my-tools/vps/database/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf; then
    echo "Sao chép file mysqld.cnf thành công!"
    sudo nano  /etc/mysql/mysql.conf.d/mysqld.cnf
else
    echo "Sao chép file mysqld.cnf thất bại!"
fi





sudo systemctl restart mysql;