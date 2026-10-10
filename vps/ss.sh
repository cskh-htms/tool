#!/bin/bash

# Tạo tệp c.sh và p.sh
touch ./clone.sh
touch ./pull.sh

# Ghi nội dung vào tệp c.sh
echo '#!/bin/bash
rm -rf my-tools
git clone https://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@github.com/api-htms-vn/my-tools.git
chmod -R 777 my-tools/*' > ./clone.sh

# Ghi nội dung vào tệp p.sh
echo '#!/bin/bash
cd ~/
cd ./my-tools
git pull https://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@github.com/api-htms-vn/my-tools.git
cd ~/' > ./pull.sh

# Cấp quyền thực thi cho các tệp
chmod 775 ./clone.sh
chmod 775 ./pull.sh




echo "Tạo và thiết lập xong các tệp clone.sh và pull.sh"






