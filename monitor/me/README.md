# Giám sát tài nguyên VPS

Cài trực tiếp trên Ubuntu/Debian có systemd; chỉ cần Python 3 tiêu chuẩn, không Docker/pip. Clone repo ở đường dẫn bất kỳ rồi chạy:

```bash
sudo bash /duong-dan/tool-daihung/scripts/monitor-me/install.sh
```

Installer chọn đúng `telegram/.env.telegram` trong home user triển khai: `DEPLOY_USER` nếu chỉ định, rồi user chạy sudo, rồi chủ sở hữu thư mục repo; sau cùng mới xét home của tài khoản chạy installer và đường dẫn đã lưu. Home được tra từ tài khoản Linux của từng VPS, không lấy user từ `website-ops.json`, không dựa vào thư mục hiện tại hoặc biến HOME của root. Không quét file backup hoặc toàn bộ user khác. File phải chứa `TOKEN_ADMIN_MONITOR` và `ID_CHANNEL_MONITOR`. Nếu cần dùng file khác, chỉ rõ:

```bash
sudo TELEGRAM_ENV=/home/USER/telegram/.env.telegram bash /duong-dan/tool-daihung/scripts/monitor-me/install.sh
```

Không gửi tin thử khi cài. File gốc được giữ nguyên; hai biến được sao chép riêng vào `/etc/vps-resource-monitor/telegram.env`, root và user dịch vụ mới đọc được. Sau khi sửa file gốc, chạy lại installer để cập nhật. Cài lại giữ cấu hình và database, không tạo lịch trùng. Dịch vụ chạy từ `/opt`, không phụ thuộc vị trí clone và tự chạy sau reboot.

Sau khi cài thành công có thể xóa toàn bộ thư mục clone. Mã chạy nằm ở `/opt/vps-resource-monitor/agent.py`, cấu hình và bản Telegram riêng nằm trong `/etc/vps-resource-monitor`, database nằm trong `/var/lib/vps-resource-monitor`. `telegram_env` trong cấu hình trỏ vào bản đã cài; `telegram_source` chỉ ghi nhớ file nguồn để cập nhật khi chạy installer, không được service đọc. Các lệnh quản lý đã copy độc lập:

```bash
sudo bash /opt/vps-resource-monitor/scripts/status.sh
bash /opt/vps-resource-monitor/scripts/test.sh
sudo bash /opt/vps-resource-monitor/scripts/uninstall.sh
```

Installer không tạo bytecode Python trong repo. Khi nâng cấp bản cũ, chỉ sửa chủ sở hữu các file cache Python của monitor do root tạo, về owner của thư mục `monitor/me`, để user xóa được repo. Không đổi quyền toàn bộ repo hoặc dùng chmod 777. File mã runtime thuộc root (644), script quản lý 755, cấu hình/Telegram root:group dịch vụ 640, thư mục database user dịch vụ 750.

Trên VPS dùng `user_one_htms`, script tự tìm home của `user_one_htms`; trên VPS dùng `ubuntu`/`ubunru`, script tự tìm home tài khoản tương ứng. Clone nguyên repo ở vị trí bất kỳ, file Telegram nằm trong `telegram/.env.telegram` của tài khoản đó, rồi chạy cùng installer. Khi clone ở vị trí khác `~/tool-daihung`, chỉ đổi đường dẫn lệnh gọi script, không sửa code.

Cài lại sử dụng cùng tên service/timer/slice cố định. Installer khóa chống hai lần cài đồng thời, kiểm tra file Telegram và chuẩn bị cấu hình trước khi dừng bộ monitor cũ; sau đó cập nhật mã/unit, xóa trạng thái failed và khởi động lại các dịch vụ/lịch cũ. Các thiết lập như cổng, ngưỡng, network và server_id được giữ; bổ sung mặc định cho field mới. Database không bị xóa hoặc tạo lại rỗng. Việc nâng cấp có gián đoạn ngắn riêng bộ monitor. Nếu thiếu Telegram, installer dừng trước khi thay đổi dịch vụ đang chạy.

## Lịch và dữ liệu

- Mỗi phút: thu thập CPU, RAM, swap, filesystem, network và số request từ Nginx access log. CPU/network dựa trên chênh lệch bộ đếm một phút; lần đầu hoặc sau reboot không có CPU/rate hợp lệ. Nginx đọc log tăng dần, lưu số request của từng phút vào SQLite; không lưu nội dung URL hoặc IP.
- Mỗi 2 phút, tại giây 15: xét trung bình 5 mẫu phút gần nhất cho CPU/RAM/dung lượng disk/network. Đồng thời kiểm tra hai phút hoàn chỉnh kể từ lần kiểm tra trước; nếu bất kỳ phút nào có hơn 1.000 request Nginx thì gửi cảnh báo Telegram. Ngưỡng nằm ở `nginx_alert_threshold_per_minute` trong config. Thiếu mẫu tài nguyên hoặc dữ liệu cũ quá 150 giây thì bỏ xét loại đó; không coi là 0%.
- Chỉ báo tài nguyên khi CPU >75%, RAM >90%, dung lượng ổ cứng >80%, network >80%. Đúng bằng ngưỡng không báo. Swap vẫn lưu nhưng không cảnh báo. Tin Telegram nêu riêng trung bình tài nguyên 5 phút và tổng request Nginx của phút vượt ngưỡng. Còn vượt ở lượt sau thì gửi tiếp. Bình thường hoặc phục hồi không gửi tin.
- Mỗi giờ: xóa thông số và lịch sử cảnh báo cũ hơn 5 ngày theo đợt 500 dòng. API luôn lọc giới hạn 5 ngày kể cả trước lượt dọn. Không lưu tổng hợp dài hạn, không VACUUM định kỳ.

RAM tính bằng `MemTotal - MemAvailable`. CPU loại idle/iowait, lưu riêng iowait. Disk % tính theo dung lượng đã dùng và dung lượng còn khả dụng cho ứng dụng. Network mặc định lấy card có thiết bị trong `/sys/class/net`, bỏ bridge/veth/loopback. Có thể chỉ rõ tên card trong cấu hình trên VPS có card ảo không được nhận diện.

Disk chỉ giám sát filesystem ghi được: bỏ mount chỉ đọc, squashfs/iso9660 và thiết bị loop của snap. Các mount snap luôn hiện 100% vì là image chỉ đọc, không phải ổ hệ thống đầy. Checker cũng bỏ bản ghi snap cũ trong database; không cần xóa lịch sử để hết cảnh báo sai.

Nginx mặc định đọc `/var/log/nginx/access.log` với định dạng access log chuẩn có timestamp dạng `[dd/Mon/yyyy:HH:mm:ss +0000]`. Service Nginx collector chạy với nhóm phụ `adm` để đọc log; có thể đổi đường dẫn trong `nginx_access_log`. API lưu mỗi phút dưới `type=nginx_requests`, `object=nginx`, trường `values.request_count`. Cảnh báo là tổng request toàn Nginx, không phân nhóm theo IP.

Database: `/var/lib/vps-resource-monitor/metrics.sqlite3`, SQLite WAL. `samples` chứa `id`, `ts` (Unix UTC), `server_id`, `type`, `object`, `percent`, `values_json`; `alerts` chứa chi tiết và trạng thái gửi. ID bản ghi dùng AUTOINCREMENT để phân trang khi đồng thời thu thập/xóa dữ liệu. API trả `values_json` thành object `values`. Bộ đếm và state được giữ để tính lượt kế tiếp.

## Cấu hình và tài nguyên

Sửa `/etc/vps-resource-monitor/config.json`. Các job đọc cấu hình mỗi lượt; sau khi thay đổi cấu hình API chạy `sudo systemctl restart vps-resource-api`.

Mỗi lần chạy installer, nó đo tốc độ tải xuống và tải lên hai lần qua `speed.cloudflare.com`, rồi lưu kết quả cao nhất riêng cho từng chiều vào `/etc/vps-resource-monitor/config.json`. Mỗi lần thử truyền tối đa 50 MB; tổng tối đa một lượt đo là 200 MB. Đây là tốc độ đo được tới máy chủ thử nghiệm tại thời điểm cài, không phải cam kết tốc độ của nhà cung cấp. Nếu phép đo thất bại, mốc cũ bị bỏ để không tính phần trăm theo số liệu lỗi thời. Có thể đặt thủ công `network_interfaces`, `network_capacity_rx_mbps`, `network_capacity_tx_mbps` nếu muốn dùng mức khác. `disk_mounts=[]` tự nhận filesystem `/dev/*`; có thể đặt `["/", "/data"]` cho các mount đang có. `server_id` tự sinh từ hostname và machine-id, có thể đặt tên riêng trên mỗi máy.

`server_name` là tên hiển thị trên dòng đầu Telegram; để trống dùng hostname hiện tại, không kèm machine-id. Ngưỡng riêng nằm ở `thresholds_percent`: `{"cpu":75,"ram":90,"disk":80,"network":80}`. Mạng chỉ lưu tốc độ nhận/gửi theo Mbps và MB/s, không lưu bộ đếm tổng vào mẫu; bộ đếm trước đó chỉ được giữ nội bộ để tính chênh lệch cho mẫu kế tiếp. Mỗi chiều có phần trăm so với tốc độ đo được (`rx_percent`, `tx_percent`); `percent` ở mẫu mạng là phần trăm cao hơn trong hai chiều. Collector chạy mỗi phút; checker chạy mỗi 2 phút và tính trung bình 5 mẫu phút gần nhất. Cấu hình cũ `threshold_percent` chung được bỏ khi nâng cấp; không dùng nó để báo RAM 75% nữa.

Toàn bộ dịch vụ nằm chung slice: CPUQuota=10% của một CPU; MemoryHigh=64M, MemoryMax=96M, MemorySwapMax=0, CPUWeight/IOWeight=10, Nice=15, tối đa 32 task. API tối đa 4 request xử lý đồng thời, socket timeout 5 giây; job tối đa 30 giây, khóa chung ngăn chạy chồng. Khi thiếu tài nguyên, job có thể bị trễ/bỏ lượt; API có thể chậm hoặc khởi động lại. Không đảm bảo hoàn toàn không ảnh hưởng VPS; kiểm tra mức dùng thực tế rồi chỉnh slice nếu cần. systemd-analyze verify kiểm tra unit trong lúc cài; cần VPS cho phép các controller cgroups CPU/memory.

Giữ log qua journalctl; không in token hoặc URL Telegram. Hạn mức CPU/RAM áp dụng chung, I/O dùng ưu tiên thấp (không phải giới hạn MB/s cứng). Dữ liệu giới hạn tuổi, dung lượng SQLite có thể giữ mức lớn nhất đã dùng để tái sử dụng.

## API public, chỉ đọc

Mặc định `http://IP_VPS:9108`, nghe trên `0.0.0.0`, không yêu cầu token theo yêu cầu triển khai. Installer không tự thay firewall; cho phép TCP 9108 trong firewall/security group nếu cần. Website quản trị nên gọi từ backend.

```text
GET /api/v1/health
GET /api/v1/info
GET /api/v1/latest
GET /api/v1/metrics?type=ram&limit=100
GET /api/v1/metrics?type=disk&object=%2F&limit=100
GET /api/v1/metrics?type=network&object=ens5&from=2026-10-12T00:00:00Z&to=2026-10-12T12:00:00Z&limit=500
GET /api/v1/alerts?limit=100
```

`limit` mặc định 100, tối đa 1000; giá trị sai trả 400. Dữ liệu mới nhất trước theo `(ts,id)`. Lấy trang sau bằng `cursor=next_cursor` đã URL-encode và giữ nguyên bộ lọc. Hết trang `next_cursor=null`. `from/to` nhận Unix giây hoặc ISO 8601 có timezone; chưa hỗ trợ tổng hợp độ phân giải, `resolution=minute` là giá trị duy nhất. Các loại: cpu/ram/swap/disk/network/nginx_requests. `object` là all, mount point, card mạng hoặc `nginx`. Mẫu Nginx có số request trong `values.request_count`. MB/GB trong field tương ứng MiB/GiB (1024), Mbps là megabit/giây (1000). API không trả cấu hình hoặc secrets.

`health.stale=true` nghĩa mẫu gần nhất đã cũ hoặc chưa có. `/latest` có `ts` từng loại để frontend hiển thị trạng thái dữ liệu riêng. Network `percent` có thể lớn hơn 100 khi giới hạn cấu hình nhỏ hơn lưu lượng thực tế. API này không có giao diện website.

## Vận hành

```bash
bash /duong-dan/tool-daihung/scripts/monitor-me/status.sh
bash /duong-dan/tool-daihung/scripts/monitor-me/test.sh
sudo systemctl status vps-resource-api
sudo journalctl -u 'vps-resource-*.service' -n 50 --no-pager
sudo systemctl show vps-resource-monitor.slice -p CPUUsageNSec -p MemoryCurrent
sudo bash /duong-dan/tool-daihung/scripts/monitor-me/uninstall.sh
```

Test.sh kiểm tra cấu hình, dry-run cảnh báo và API, không gửi Telegram. Gỡ dịch vụ giữ nguyên mã/cấu hình/database. Máy bị tắt hoặc mất mạng không tự gửi được Telegram: cần monitor ngoài máy để phát hiện mất kết nối.

Kiểm thử trong repo:

```bash
python3 monitor/me/test_agent.py
python3 monitor/me/test_installer.py
```

Test installer dùng thư mục tạm và systemctl mô phỏng, chạy bộ cài hai lần để kiểm tra giữ cấu hình/database, không tạo service/timer trùng và không dừng dịch vụ khi Telegram không hợp lệ. Không cài dịch vụ thật trên máy kiểm thử.
