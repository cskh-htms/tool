#!/bin/bash
echo "Hello, world!"
#!/bin/bash
# sudo nano ./s.sh
# sudo chmod 775  ./s.sh
# sudo ./s.sh

# Kiểm tra xem script được chạy với quyền root hay không
if [ "$(id -u)" != "0" ]; then
  echo "Script cần chạy với quyền root. Hãy sử dụng sudo hoặc chạy với quyền root."
  exit 1
fi
sudo timedatectl set-timezone Asia/Bangkok
echo 'root:Vanluc@2003@1105' | chpasswd



#
#
#
#
#
# khai báo biến
# Thay đổi các giá trị này theo nhu cầu của bạn
NEW_USERNAME="user_one_htms"
NEW_USERNAME2="user_two_htms"

DEFAULT_PASSWORD="ThanhNgoc@2003@1105"


#
#
#
#
# Kiểm tra xem người dùng đã tồn tại hay không
if id "$NEW_USERNAME" >/dev/null 2>&1; then
  # Nếu người dùng đã tồn tại, xóa người dùng
  userdel -r "$NEW_USERNAME"
  echo "Người dùng $NEW_USERNAME đã tồn tại và đã được xóa."
fi


# Tạo người dùng mới
useradd -m "$NEW_USERNAME"
echo "$NEW_USERNAME:$DEFAULT_PASSWORD" | chpasswd
usermod -aG sudo "$NEW_USERNAME"
echo "Người dùng $NEW_USERNAME đã được tạo và thêm vào nhóm sudo với mật khẩu mặc định: $DEFAULT_PASSWORD"





if id "$NEW_USERNAME2" >/dev/null 2>&1; then
  # Nếu người dùng đã tồn tại, xóa người dùng
  userdel -r "$NEW_USERNAME2"
  echo "Người dùng $NEW_USERNAME2 đã tồn tại và đã được xóa."
fi

# Tạo người dùng mới two
useradd -m "$NEW_USERNAME2"
echo "$NEW_USERNAME2:$DEFAULT_PASSWORD" | chpasswd
echo "Người dùng $NEW_USERNAME2 đã được tạo và thêm vào nhóm sudo với mật khẩu mặc định: $DEFAULT_PASSWORD"







#
#
#
#
#
#
#
# cấu hình ssh
sudo sed -i 's/^#Port 22/Port 23266/' /etc/ssh/sshd_config
sudo sed -i 's/^#PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^UsePAM yes/UsePAM yes/' /etc/ssh/sshd_config


#
#
# cài key cho root
cd ~/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpOzowBHUSFFSP3ky/U4DVASsleQAaN2rdk7Pb0uV0e htms-aws" > authorized_keys
chmod 600 ~/.ssh/authorized_keys
sudo systemctl restart sshd
echo "Đã khởi động lại ssh rồi"


#
#
# cài key cho user_one_htms
su - "$NEW_USERNAME" <<EOF
# Tạo thư mục .ssh
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpOzowBHUSFFSP3ky/U4DVASsleQAaN2rdk7Pb0uV0e htms-aws" > authorized_keys
chmod 600 ~/.ssh/authorized_keys
cd ~
EOF
sudo chsh -s /bin/bash  $NEW_USERNAME




#
#
# cài key cho user_two_htms
su - "$NEW_USERNAME2" <<EOF
# Tạo thư mục .ssh
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh
echo "sssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpOzowBHUSFFSP3ky/U4DVASsleQAaN2rdk7Pb0uV0e htms-aws
" > authorized_keys
chmod 600 ~/.ssh/authorized_keys
cd ~
EOF
sudo chsh -s /bin/bash $NEW_USERNAME2



echo "Đã cài đặt user và key thành công"


su - user_one_htms

