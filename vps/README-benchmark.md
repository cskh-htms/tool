# Kiểm thử VPS từng phần

Bốn file độc lập cho Ubuntu/Debian. Chỉ cần tải file muốn dùng lên VPS;
không cần tải `vps-bench.sh` hay các file khác. Mỗi file tự cài công cụ
còn thiếu khi chạy bằng `sudo`, rồi in điểm của phần được đo.

| File | Lệnh | Thời gian mặc định, chưa tính cài công cụ |
| --- | --- | --- |
| CPU | `sudo bash test-cpu.sh` | Khoảng 40 giây |
| RAM | `sudo bash test-ram.sh` | Khoảng 40 giây |
| Mạng | `sudo bash test-mang.sh` | Thường 1–2 phút, tùy đầu đo |
| I/O | `sudo bash test-io.sh` | Khoảng 60 giây đo + khởi tạo file và thời gian chuyển bài |

Không tính tổng điểm VPS. Mốc 100 là quy ước cố định; điểm có thể vượt 100.
Báo cáo TXT, JSON và log được lưu trong `vps-bench-results` tại thư mục chạy.
Phần nào lỗi sẽ báo chưa đo được và trả exit code 2.

## CPU và RAM

Mặc định: hai lượt, mỗi lượt 10 giây cho mỗi bài con.
CPU đo một luồng và toàn bộ luồng CPU được phép dùng. RAM đo đọc và ghi
vùng nhớ 64 MiB bằng sysbench; điểm RAM phản ánh bài truy cập bộ nhớ,
chịu ảnh hưởng của CPU/cache, không cộng điểm theo dung lượng RAM.

Muốn CPU chạy tổng cộng khoảng 60 giây:

```bash
sudo bash test-cpu.sh --seconds 15 --rounds 2
```

Đo nhanh phản ánh hiệu năng tại thời điểm chạy. Để kiểm tra CPU có giảm tốc
sau một thời gian, có thể thêm bài liên tục 300 giây:

```bash
sudo bash test-cpu.sh --sustained 300
```

Bài này dùng profile khác với CPU mặc định và có thể hạ điểm CPU nếu tốc độ
duy trì thấp hơn bài ngắn. Không so trực tiếp điểm CPU v2 mặc định với điểm
CPU v1 của file tổng, vì v1 luôn có bài duy trì 300 giây.

## Mạng Việt Nam

Mặc định dùng máy chủ Speedtest công cộng Viettel TP.HCM, ID `26853`, cho cả
hai lượt download/upload. Không tự chuyển sang máy chủ quốc tế khi lỗi.

```bash
sudo bash test-mang.sh --vn-server-id 26853
sudo bash test-mang.sh --vn-server-id 0
```

ID 0 cho phép tự chọn trong danh sách máy chủ có mã quốc gia VN. File có
danh sách dự phòng VNPT/Viettel/MobiFone, được đối chiếu danh sách Speedtest
ngày 11/10/2026. Địa điểm dựa trên thông tin nhà vận hành, không chứng minh
đường định tuyến hoàn toàn nằm trong Việt Nam.

Speedtest HTTP tự quyết định thời gian mỗi lượt; `--seconds` chỉ điều khiển
thời gian nếu dùng iperf3. Nếu có đầu đo iperf3 riêng tại Việt Nam:

```bash
sudo bash test-mang.sh --vn-host IP_VIET_NAM --vn-port 5201
```

Phương pháp HTTP có thể bị giới hạn bởi CPU/Python và máy chủ công cộng,
không khẳng định băng thông tối đa của cổng mạng. Giữ cùng phương pháp,
ID/địa chỉ đầu đo và phiên bản công cụ khi so sánh VPS. Benchmark sử dụng
lưu lượng upload/download thực, có thể vài GB mỗi lần.

## I/O

Hai lượt cho sáu bài: đọc/ghi tuần tự, IOPS đọc/ghi ngẫu nhiên,
độ trễ p95 đọc/ghi ở queue depth 1. Mỗi bài 5 giây sau 2 giây khởi động.
Dùng direct I/O vào một file tạm 2 GiB riêng, khởi tạo trước khi đọc,
rồi xóa sau khi chạy hoặc dừng bằng Ctrl+C. Cần tối thiểu 3 GiB trống.

Đo ổ đĩa chứa một thư mục cụ thể:

```bash
sudo bash test-io.sh --disk-dir /duong/dan/tren/o/dia
```

Ổ đĩa chậm có thể mất thêm thời gian khởi tạo file; benchmark không ghi
lên thiết bị raw disk. Muốn kiểm tra I/O duy trì lâu hơn, tăng `--seconds`.

## So sánh kết quả

Dùng cùng phiên bản, profile, thời lượng, số lượt và công cụ.
Chạy từng file lần lượt để chúng không tranh tài nguyên. Có thể đo lại vào
giờ khác nếu báo cáo cho thấy dao động lớn. `--quick` chỉ dành cho kiểm tra
file có chạy được không, không dùng để xếp hạng cùng bài mặc định.

Các tùy chọn chung: `--seconds N`, `--rounds N`, `--output-dir DIR`,
`--no-install`, `--quick`, `--help`. Điểm là chỉ số benchmark theo các mốc
quy ước trong mã nguồn, không phải mức tăng tốc bảo đảm cho mọi ứng dụng.
