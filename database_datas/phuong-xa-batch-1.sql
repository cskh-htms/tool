-- ============================================================
-- PHƯỜNG XÃ BATCH 1
-- Cao Bằng (id=2), Điện Biên (id=4), Lai Châu (id=5)
-- Dựa theo cải cách hành chính 2025
-- ============================================================

INSERT INTO phuong_xa (ten_phuong_xa, ten_phuong_xa_cu, tinh_thanh_id, status) VALUES

-- ============================================================
-- TỈNH CAO BẰNG (tinh_thanh_id = 2)
-- ============================================================

-- TP. Cao Bằng
('Hợp Giang',    'Hợp Giang, Tân Giang',              2, 'active'),
('Sông Hiến',    'Sông Hiến, Sông Bằng',               2, 'active'),
('Đề Thám',      'Đề Thám, Ngọc Xuân',                 2, 'active'),
('Duyệt Trung',  'Duyệt Trung',                        2, 'active'),
('Chu Trinh',    'Chu Trinh, Hưng Đạo',                2, 'active'),
('Bế Triều',     'Bế Triều, Đức Long',                 2, 'active'),
('Bạch Đằng',    'Bạch Đằng, Vĩnh Khương, Bình Minh', 2, 'active'),
('Nà Cạn',       'Nà Cạn',                             2, 'active'),

-- Huyện Bảo Lâm
('Pác Miầu',     'Pác Miầu',                           2, 'active'),
('Đức Hạnh',     'Đức Hạnh, Lý Bôn',                  2, 'active'),
('Nam Cao',      'Nam Cao, Nam Quang',                  2, 'active'),
('Vĩnh Quang',   'Vĩnh Quang, Quảng Lâm',             2, 'active'),
('Thái Học',     'Thái Học, Thái Sơn',                 2, 'active'),
('Yên Thổ',      'Yên Thổ, Tân Việt',                  2, 'active'),
('Mông Ân',      'Mông Ân, Thạch Lâm',                 2, 'active'),
('Vĩnh Phong',   'Vĩnh Phong, Quảng Nguyên, Điền Mộc',2, 'active'),

-- Huyện Bảo Lạc
('Bảo Lạc',      'Bảo Lạc',                            2, 'active'),
('Cốc Pàng',     'Cốc Pàng, Thượng Hà',               2, 'active'),
('Cô Ba',        'Cô Ba, Bảo Toàn',                    2, 'active'),
('Khánh Xuân',   'Khánh Xuân, Xuân Trường',            2, 'active'),
('Hồng Trị',     'Hồng Trị, Kim Cúc',                  2, 'active'),
('Phan Thanh',   'Phan Thanh, Hưng Đạo',               2, 'active'),
('Huy Giáp',     'Huy Giáp, Hòa Chung',                2, 'active'),
('Đình Phùng',   'Đình Phùng',                         2, 'active'),

-- Huyện Hà Quảng (gộp Thông Nông)
('Xuân Hòa',     'Xuân Hòa, Thông Nông',               2, 'active'),
('Cần Yên',      'Cần Yên, Cải Viên',                  2, 'active'),
('Nội Thôn',     'Nội Thôn, Tổng Cọt',                 2, 'active'),
('Sóc Hà',       'Sóc Hà, Thượng Thôn',                2, 'active'),
('Lũng Nặm',     'Lũng Nặm, Quý Quân',                 2, 'active'),
('Trường Hà',    'Trường Hà, Hạ Thôn',                 2, 'active'),
('Hồng Sĩ',      'Hồng Sĩ, Ngọc Đào, Nà Sác',         2, 'active'),

-- Huyện Trùng Khánh
('Trùng Khánh',  'Trùng Khánh',                        2, 'active'),
('Ngọc Khê',     'Ngọc Khê, Phong Nặm',                2, 'active'),
('Ngọc Côn',     'Ngọc Côn, Phong Châu',               2, 'active'),
('Cao Thăng',    'Cao Thăng, Trung Phúc',              2, 'active'),
('Đàm Thủy',     'Đàm Thủy, Thông Huề',                2, 'active'),
('Lăng Hiếu',    'Lăng Hiếu, Khâm Thành',             2, 'active'),
('Chí Viễn',     'Chí Viễn, Ngọc Chung',              2, 'active'),
('Cảnh Tiên',    'Cảnh Tiên, Thân Giáp',              2, 'active'),
('Đức Hồng',     'Đức Hồng, Đoài Dương',              2, 'active'),

-- Huyện Hạ Lang
('Việt Chu',     'Việt Chu, Cô Ngân',                  2, 'active'),
('Kim Loan',     'Kim Loan, Lý Quốc',                  2, 'active'),
('Thắng Lợi',    'Thắng Lợi, Đồng Loan',              2, 'active'),
('Đức Quang',    'Đức Quang, Thị Hoa',                 2, 'active'),
('Quang Long',   'Quang Long, An Lạc',                 2, 'active'),
('Thanh Nhật',   'Thanh Nhật, Vinh Quý',              2, 'active'),
('Lũng Ty',      'Lũng Ty, Minh Long, Vần Dính',      2, 'active'),

-- Huyện Quảng Hòa (gộp Phục Hòa, Trà Lĩnh)
('Quảng Uyên',   'Quảng Uyên',                         2, 'active'),
('Tà Lùng',      'Tà Lùng',                            2, 'active'),
('Cách Linh',    'Cách Linh, Đại Sơn',                 2, 'active'),
('Hồng Quang',   'Hồng Quang, Bình Lăng',             2, 'active'),
('Tiên Thành',   'Tiên Thành, Hạnh Phúc',             2, 'active'),
('Chí Thảo',     'Chí Thảo, Tự Do',                   2, 'active'),
('Quốc Dân',     'Quốc Dân, Phi Hải',                 2, 'active'),
('Ngọc Động',    'Ngọc Động, Mỹ Hưng',                2, 'active'),

-- Huyện Hòa An
('Nước Hai',     'Nước Hai',                            2, 'active'),
('Dân Chủ',      'Dân Chủ, Nam Tuấn',                  2, 'active'),
('Đại Tiến',     'Đại Tiến, Đức Long',                 2, 'active'),
('Ngũ Lão',      'Ngũ Lão, Trương Lương',              2, 'active'),
('Bình Dương',   'Bình Dương, Lê Chung',               2, 'active'),
('Hoàng Tung',   'Hoàng Tung, Hà Trì',                 2, 'active'),
('Vân Trình',    'Vân Trình, Hà Thủy',                 2, 'active'),
('Hồng Nam',     'Hồng Nam, Thụy Hùng, Quang Trung',  2, 'active'),

-- Huyện Nguyên Bình
('Nguyên Bình',  'Nguyên Bình',                        2, 'active'),
('Tĩnh Túc',     'Tĩnh Túc',                           2, 'active'),
('Minh Tâm',     'Minh Tâm, Thể Dục',                 2, 'active'),
('Lang Môn',     'Lang Môn, Minh Long',                2, 'active'),
('Thịnh Vượng',  'Thịnh Vượng, Hoa Thám',             2, 'active'),
('Quang Thành',  'Quang Thành, Hưng Đạo',             2, 'active'),
('Vũ Nông',      'Vũ Nông, Ca Thành',                  2, 'active'),
('Sơn Lộ',       'Sơn Lộ, Thái Học',                  2, 'active'),
('Bắc Hợp',      'Bắc Hợp, Tam Kim',                  2, 'active'),
('Thành Công',   'Thành Công, Mai Long, Hữu Quốc',    2, 'active'),

-- Huyện Thạch An
('Đông Khê',     'Đông Khê',                            2, 'active'),
('Canh Tân',     'Canh Tân, Đức Thông',                2, 'active'),
('Thái Cường',   'Thái Cường, Vân Trình',              2, 'active'),
('Quang Trọng',  'Quang Trọng, Trọng Con',             2, 'active'),
('Lê Lai',       'Lê Lai, Minh Khai',                  2, 'active'),
('Danh Sĩ',      'Danh Sĩ, Kim Đồng',                 2, 'active'),
('Đình Minh',    'Đình Minh, Lê Lợi',                 2, 'active'),

-- ============================================================
-- TỈNH ĐIỆN BIÊN (tinh_thanh_id = 4)
-- ============================================================

-- TP. Điện Biên Phủ
('Mường Thanh',  'Mường Thanh, Nam Thanh',             4, 'active'),
('Thanh Trường', 'Thanh Trường, Him Lam',              4, 'active'),
('Tân Thanh',    'Tân Thanh',                          4, 'active'),
('Noong Bua',    'Noong Bua, Nà Tấu',                  4, 'active'),
('Nà Nhạn',      'Nà Nhạn, Mường Phăng',              4, 'active'),
('Pá Khoang',    'Pá Khoang',                          4, 'active'),

-- TX. Mường Lay
('Sông Đà',      'Sông Đà, Na Lay',                    4, 'active'),
('Lay Nưa',      'Lay Nưa',                            4, 'active'),

-- Huyện Điện Biên
('Sam Mứn',      'Sam Mứn, Noong Hẹt',                4, 'active'),
('Thanh An',     'Thanh An, Noong Luống',              4, 'active'),
('Phu Luông',    'Phu Luông, Núa Ngam',                4, 'active'),
('Hẹ Muông',     'Hẹ Muông, Hua Thanh',               4, 'active'),
('Thanh Luông',  'Thanh Luông, Pa Thơm',              4, 'active'),
('Na Ư',         'Na Ư, Mường Nhà',                    4, 'active'),
('Mường Lói',    'Mường Lói, Na Tông',                 4, 'active'),
('Mường Pồn',    'Mường Pồn, Thanh Chăn',             4, 'active'),

-- Huyện Điện Biên Đông
('Điện Biên Đông','Điện Biên Đông',                   4, 'active'),
('Mường Luân',   'Mường Luân, Pú Hồng',               4, 'active'),
('Nong U',       'Nong U, Phì Nhừ',                   4, 'active'),
('Chiềng Sơ',    'Chiềng Sơ, Mường Lùng',             4, 'active'),
('Luân Giói',    'Luân Giói, Phình Giàng',            4, 'active'),
('Háng Lìa',     'Háng Lìa, Keo Lôm',                 4, 'active'),
('Na Son',       'Na Son, Tìa Dình',                   4, 'active'),
('Xa Dung',      'Xa Dung',                            4, 'active'),

-- Huyện Mường Ảng
('Mường Ảng',    'Mường Ảng',                          4, 'active'),
('Ẳng Tở',       'Ẳng Tở, Ẳng Cang',                  4, 'active'),
('Ẳng Nưa',      'Ẳng Nưa, Mường Đăng',               4, 'active'),
('Ngối Cáy',     'Ngối Cáy, Mường Lạn',               4, 'active'),
('Búng Lao',     'Búng Lao, Xuân Lao',                4, 'active'),

-- Huyện Mường Chà
('Mường Chà',    'Mường Chà',                          4, 'active'),
('Sa Lông',      'Sa Lông, Ma Thì Hồ',                4, 'active'),
('Na Sang',      'Na Sang, Mường Tùng',               4, 'active'),
('Huổi Lèng',    'Huổi Lèng, Huổi Mí',               4, 'active'),
('Pa Ham',       'Pa Ham, Nậm Nèn',                   4, 'active'),
('Chà Cang',     'Chà Cang, Hừa Ngài',               4, 'active'),
('Phìn Hồ',      'Phìn Hồ, Si Pa Phìn, Mường Mươn',  4, 'active'),

-- Huyện Tủa Chùa
('Tủa Chùa',     'Tủa Chùa',                          4, 'active'),
('Sính Phình',   'Sính Phình, Tả Sìn Thàng',          4, 'active'),
('Lao Xả Phình', 'Lao Xả Phình, Tả Phìn',            4, 'active'),
('Tủa Thàng',    'Tủa Thàng, Trung Thu',              4, 'active'),
('Phình Sáng',   'Phình Sáng, Huổi Só',               4, 'active'),
('Xá Nhè',       'Xá Nhè, Mường Đun, Mường Báng',    4, 'active'),

-- Huyện Tuần Giáo
('Tuần Giáo',    'Tuần Giáo',                          4, 'active'),
('Rạng Đông',    'Rạng Đông, Nà Sáy',                 4, 'active'),
('Mùn Chung',    'Mùn Chung, Quài Nưa',              4, 'active'),
('Quài Tở',      'Quài Tở, Ta Ma',                    4, 'active'),
('Chiềng Sinh',  'Chiềng Sinh, Mường Mùn',            4, 'active'),
('Nà Tòng',      'Nà Tòng, Mường Thín',              4, 'active'),
('Co Mạ',        'Co Mạ, Pú Xi',                      4, 'active'),
('Pú Nhung',     'Pú Nhung, Tênh Phông',              4, 'active'),
('Quài Cang',    'Quài Cang, Mường Khong',            4, 'active'),

-- Huyện Nậm Pồ
('Nậm Pồ',       'Nậm Pồ',                            4, 'active'),
('Nà Hì',        'Nà Hì, Nậm Chua',                   4, 'active'),
('Chà Tở',       'Chà Tở, Nậm Khăn',                 4, 'active'),
('Nậm Tin',      'Nậm Tin, Vàng Đán',                 4, 'active'),
('Pa Tần',       'Pa Tần',                             4, 'active'),

-- Huyện Mường Nhé
('Mường Nhé',    'Mường Nhé',                          4, 'active'),
('Sín Thầu',     'Sín Thầu, Sen Thượng',              4, 'active'),
('Chung Chải',   'Chung Chải, Leng Su Sìn',           4, 'active'),
('Pá Mỳ',        'Pá Mỳ, Mường Toong',                4, 'active'),
('Quảng Lâm',    'Quảng Lâm, Huổi Lếnh',             4, 'active'),
('Na Cô Sa',     'Na Cô Sa, Nậm Kè',                  4, 'active'),

-- ============================================================
-- TỈNH LAI CHÂU (tinh_thanh_id = 5)
-- ============================================================

-- TP. Lai Châu
('Quyết Thắng',  'Quyết Thắng, Quyết Tiến',           5, 'active'),
('Tân Phong',    'Tân Phong, Đoàn Kết',               5, 'active'),
('Noong Bua',    'Noong Bua, Phú Lao',                5, 'active'),
('San Thàng',    'San Thàng, Nùng Nàng',              5, 'active'),
('Bản Giang',    'Bản Giang, Bản Bo',                 5, 'active'),
('Thèn Sin',     'Thèn Sin',                          5, 'active'),

-- Huyện Mường Tè
('Mường Tè',     'Mường Tè',                          5, 'active'),
('Ka Lăng',      'Ka Lăng, Thu Lũm',                  5, 'active'),
('Mù Ca',        'Mù Ca, Tà Tổng',                    5, 'active'),
('Bum Tở',       'Bum Tở, Kan Hồ',                    5, 'active'),
('Bum Nưa',      'Bum Nưa, Vàng San',                 5, 'active'),
('Pa Vệ Sử',     'Pa Vệ Sử, Pa Ủ',                    5, 'active'),
('Mường Mô',     'Mường Mô',                          5, 'active'),

-- Huyện Nậm Nhùn
('Nậm Nhùn',     'Nậm Nhùn',                          5, 'active'),
('Lê Lợi',       'Lê Lợi, Xà Dề Phìn',               5, 'active'),
('Trung Chải',   'Trung Chải, Nậm Pì',               5, 'active'),
('Nậm Chà',      'Nậm Chà, Chiềng Bằng',             5, 'active'),
('Pú Đao',       'Pú Đao, Hua Bum',                   5, 'active'),
('Nậm Hàng',     'Nậm Hàng',                          5, 'active'),

-- Huyện Sìn Hồ
('Sìn Hồ',       'Sìn Hồ',                            5, 'active'),
('Phìn Hồ',      'Phìn Hồ, Noong Hẻo',               5, 'active'),
('Lùng Thàng',   'Lùng Thàng, Tủa Sín Chải',         5, 'active'),
('Pa Khóa',      'Pa Khóa, Chăn Nưa',                 5, 'active'),
('Căn Co',        'Căn Co, Tả Phìn',                   5, 'active'),
('Ma Quai',      'Ma Quai, Mường Pio',                5, 'active'),
('Làng Mô',      'Làng Mô',                           5, 'active'),

-- Huyện Phong Thổ
('Phong Thổ',    'Phong Thổ',                         5, 'active'),
('Mù Sang',      'Mù Sang, Dào San',                  5, 'active'),
('Tông Qua Lìn', 'Tông Qua Lìn, Sì Lở Lầu',         5, 'active'),
('Bản Lang',     'Bản Lang, Huổi Luông',              5, 'active'),
('Nậm Xe',       'Nậm Xe, Lả Nhì Thàng',             5, 'active'),
('Sin Suối Hồ',  'Sin Suối Hồ, Vàng Ma Chải',        5, 'active'),
('Hoang Thèn',   'Hoang Thèn, Tả Lèng',              5, 'active'),
('Khổng Lào',    'Khổng Lào, Pa Vây Sủ',             5, 'active'),
('Ma Li Pho',    'Ma Li Pho, Mồ Sì San',             5, 'active'),

-- Huyện Tam Đường
('Tam Đường',    'Tam Đường',                         5, 'active'),
('Sơn Bình',     'Sơn Bình, Giang Ma',               5, 'active'),
('Hồ Thầu',      'Hồ Thầu, Nà Tăm',                  5, 'active'),
('Tả Lèng',      'Tả Lèng, Bản Giang',               5, 'active'),
('Khun Há',      'Khun Há, Mường So',                 5, 'active'),

-- Huyện Tân Uyên
('Tân Uyên',     'Tân Uyên',                          5, 'active'),
('Nậm Cần',      'Nậm Cần, Nậm Sỏ',                  5, 'active'),
('Pắc Ta',       'Pắc Ta, Thân Thuộc',               5, 'active'),
('Trung Đồng',   'Trung Đồng, Hố Mít',               5, 'active'),
('Phúc Khoa',    'Phúc Khoa, Mường Khoa',            5, 'active'),

-- Huyện Than Uyên
('Than Uyên',    'Than Uyên',                         5, 'active'),
('Phúc Than',    'Phúc Than, Mường Than',             5, 'active'),
('Tà Hừa',       'Tà Hừa, Ta Gia',                    5, 'active'),
('Mường Kim',    'Mường Kim, Pha Mu',                 5, 'active'),
('Mường Cang',   'Mường Cang, Hua Nà',               5, 'active'),
('Khoen On',     'Khoen On',                          5, 'active')

ON CONFLICT (tinh_thanh_id, ten_phuong_xa) DO UPDATE SET
  ten_phuong_xa_cu = EXCLUDED.ten_phuong_xa_cu,
  status           = EXCLUDED.status;
