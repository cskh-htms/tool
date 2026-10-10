-- Batch 13 (Final): Đồng Tháp+Tiền Giang (30), Vĩnh Long+Bến Tre+Trà Vinh (31),
--                   An Giang+Kiên Giang (32), Cần Thơ+Hậu Giang+Sóc Trăng (33), Cà Mau+Bạc Liêu (34)

INSERT INTO phuong_xa (ten_phuong_xa, ten_phuong_xa_cu, tinh_thanh_id, status) VALUES

-- ============================================================
-- ĐỒNG THÁP (gộp Tiền Giang) (tinh_thanh_id = 30)
-- ============================================================

-- TP. Cao Lãnh
('Phường 1 CL',    'Phường 1',                            30, 'active'),
('Phường 2 CL',    'Phường 2',                            30, 'active'),
('Phường 3 CL',    'Phường 3',                            30, 'active'),
('Phường 4 CL',    'Phường 4',                            30, 'active'),
('Phường 6 CL',    'Phường 6',                            30, 'active'),
('Hòa Thuận',      'Hòa Thuận',                           30, 'active'),
('Mỹ Ngãi',        'Mỹ Ngãi',                             30, 'active'),
('Mỹ Phú',         'Mỹ Phú',                              30, 'active'),
('Mỹ Tân',         'Mỹ Tân',                              30, 'active'),
('Tân Thuận Đông DT','Tân Thuận Đông',                    30, 'active'),
('Tân Thuận Tây DT','Tân Thuận Tây',                      30, 'active'),
('Tịnh Thới',      'Tịnh Thới',                           30, 'active'),

-- TX. Sa Đéc (old DT)
('An Hòa DT',      'An Hòa',                              30, 'active'),
('An Ninh DT',     'An Ninh',                             30, 'active'),
('Phường 1 SD',    'Phường 1',                            30, 'active'),
('Phường 2 SD',    'Phường 2',                            30, 'active'),
('Phường 3 SD',    'Phường 3',                            30, 'active'),
('Phường 4 SD',    'Phường 4',                            30, 'active'),
('Tân Khánh Đông', 'Tân Khánh Đông',                      30, 'active'),
('Tân Quy Đông',   'Tân Quy Đông',                        30, 'active'),
('Tân Quy Tây',    'Tân Quy Tây',                         30, 'active'),

-- TX. Hồng Ngự (old DT)
('An Bình A',      'An Bình A',                           30, 'active'),
('An Bình B',      'An Bình B',                           30, 'active'),
('An Thạnh DT',    'An Thạnh',                            30, 'active'),
('Bình Thạnh DT',  'Bình Thạnh',                          30, 'active'),
('Long Thuận DT',  'Long Thuận',                          30, 'active'),
('Phường 1 HN',    'Phường 1',                            30, 'active'),
('Phường 2 HN',    'Phường 2',                            30, 'active'),
('Thường Phước 1', 'Thường Phước 1',                      30, 'active'),
('Thường Phước 2', 'Thường Phước 2',                      30, 'active'),
('Thường Thới Hậu A','Thường Thới Hậu A',                 30, 'active'),

-- Huyện Tháp Mười (old DT)
('Mỹ An DT',       'Mỹ An',                               30, 'active'),
('Đốc Binh Kiều',  'Đốc Binh Kiều',                       30, 'active'),
('Hưng Thạnh',     'Hưng Thạnh',                          30, 'active'),
('Mỹ Đông',        'Mỹ Đông',                             30, 'active'),
('Mỹ Hòa DT',      'Mỹ Hòa',                              30, 'active'),
('Mỹ Quý DT',      'Mỹ Quý',                              30, 'active'),
('Phú Điền',       'Phú Điền',                            30, 'active'),
('Tân Kiều',       'Tân Kiều',                            30, 'active'),
('Trường Xuân DT', 'Trường Xuân',                         30, 'active'),

-- Huyện Cao Lãnh (old DT)
('Mỹ Thọ',         'Mỹ Thọ',                              30, 'active'),
('An Bình DT',     'An Bình',                             30, 'active'),
('Bình Hàng Tây',  'Bình Hàng Tây',                       30, 'active'),
('Bình Hàng Trung','Bình Hàng Trung',                     30, 'active'),
('Gáo Giồng',      'Gáo Giồng',                           30, 'active'),
('Mỹ Long DT',     'Mỹ Long',                             30, 'active'),
('Nhị Mỹ',         'Nhị Mỹ',                              30, 'active'),
('Phong Mỹ',       'Phong Mỹ',                            30, 'active'),
('Tân Nghĩa',      'Tân Nghĩa',                           30, 'active'),

-- Huyện Châu Thành DT (old DT)
('An Hiệp DT',     'An Hiệp',                             30, 'active'),
('An Khánh DT',    'An Khánh',                            30, 'active'),
('An Long DT',     'An Long',                             30, 'active'),
('Hòa Tân DT',     'Hòa Tân',                             30, 'active'),
('Phú Long DT',    'Phú Long',                            30, 'active'),
('Tân Bình DT',    'Tân Bình',                            30, 'active'),
('Tân Nhuận Đông', 'Tân Nhuận Đông',                      30, 'active'),
('Tân Phú Đông',   'Tân Phú Đông',                        30, 'active'),
('Vĩnh Thới',      'Vĩnh Thới',                           30, 'active'),

-- Huyện Lấp Vò (old DT)
('Long Hưng A',    'Long Hưng A',                         30, 'active'),
('Long Hưng B',    'Long Hưng B',                         30, 'active'),
('Bình Thành DT',  'Bình Thành',                          30, 'active'),
('Định An DT',     'Định An',                             30, 'active'),
('Định Yên',       'Định Yên',                            30, 'active'),
('Mỹ An Hưng A',   'Mỹ An Hưng A',                        30, 'active'),
('Mỹ An Hưng B',   'Mỹ An Hưng B',                        30, 'active'),
('Tân Khánh Trung','Tân Khánh Trung',                     30, 'active'),
('Tân Mỹ DT',      'Tân Mỹ',                              30, 'active'),

-- old Tiền Giang: TP. Mỹ Tho
('Đạo Thạnh',      'Đạo Thạnh',                           30, 'active'),
('Mỹ Phong',       'Mỹ Phong',                            30, 'active'),
('Phường 1 MT',    'Phường 1',                            30, 'active'),
('Phường 2 MT',    'Phường 2',                            30, 'active'),
('Phường 3 MT',    'Phường 3',                            30, 'active'),
('Phường 4 MT',    'Phường 4',                            30, 'active'),
('Phường 5 MT',    'Phường 5',                            30, 'active'),
('Phường 6 MT',    'Phường 6',                            30, 'active'),
('Phường 7 MT',    'Phường 7',                            30, 'active'),
('Phường 8 MT',    'Phường 8',                            30, 'active'),
('Phường 9 MT',    'Phường 9',                            30, 'active'),
('Phường 10 MT',   'Phường 10',                           30, 'active'),
('Tân Long MT',    'Tân Long',                            30, 'active'),
('Trung An TG',    'Trung An',                            30, 'active'),

-- TX. Gò Công (old TG)
('Phường 1 GC',    'Phường 1',                            30, 'active'),
('Phường 2 GC',    'Phường 2',                            30, 'active'),
('Phường 3 GC',    'Phường 3',                            30, 'active'),
('Phường 4 GC',    'Phường 4',                            30, 'active'),
('Phường 5 GC',    'Phường 5',                            30, 'active'),
('Long Hưng GC',   'Long Hưng',                           30, 'active'),
('Long Thuận GC',  'Long Thuận',                          30, 'active'),

-- Huyện Châu Thành TG (old TG)
('Tân Hiệp TG',    'Tân Hiệp',                            30, 'active'),
('Bình Trưng',     'Bình Trưng',                          30, 'active'),
('Dưỡng Điềm',     'Dưỡng Điềm',                          30, 'active'),
('Hội Xuân',       'Hội Xuân',                            30, 'active'),
('Kim Sơn TG',     'Kim Sơn',                             30, 'active'),
('Long An TG',     'Long An',                             30, 'active'),
('Tân Hội Đông',   'Tân Hội Đông',                        30, 'active'),
('Tân Lý Đông',    'Tân Lý Đông',                         30, 'active'),
('Tân Lý Tây',     'Tân Lý Tây',                          30, 'active'),
('Tân Phú TG',     'Tân Phú',                             30, 'active'),
('Thạnh Phú TG',   'Thạnh Phú',                           30, 'active'),
('Thân Cửu Nghĩa', 'Thân Cửu Nghĩa',                      30, 'active'),

-- Huyện Cai Lậy + TX. Cai Lậy (old TG)
('Cai Lậy',        'Cai Lậy',                             30, 'active'),
('Bình Phú TG',    'Bình Phú',                            30, 'active'),
('Long Khánh TG',  'Long Khánh',                          30, 'active'),
('Mỹ Hạnh Đông',   'Mỹ Hạnh Đông',                        30, 'active'),
('Mỹ Hạnh Trung',  'Mỹ Hạnh Trung',                       30, 'active'),
('Nhị Quý',        'Nhị Quý',                             30, 'active'),
('Phú Quý',        'Phú Quý',                             30, 'active'),
('Tân Bình TG',    'Tân Bình',                            30, 'active'),
('Tân Phong TG',   'Tân Phong',                           30, 'active'),
('Thanh Hòa TG',   'Thanh Hòa',                           30, 'active'),

-- Huyện Gò Công Đông (old TG)
('Tân Hòa TG',     'Tân Hòa',                             30, 'active'),
('Bình Ân',        'Bình Ân',                             30, 'active'),
('Gia Thuận',      'Gia Thuận',                           30, 'active'),
('Kiểng Phước',    'Kiểng Phước',                         30, 'active'),
('Tân Điền',       'Tân Điền',                            30, 'active'),
('Tân Phước TG',   'Tân Phước',                           30, 'active'),
('Tân Tây',        'Tân Tây',                             30, 'active'),
('Vàm Láng',       'Vàm Láng',                            30, 'active'),

-- ============================================================
-- VĨNH LONG (gộp Bến Tre + Trà Vinh) (tinh_thanh_id = 31)
-- ============================================================

-- TP. Vĩnh Long
('Phường 1 VL',    'Phường 1',                            31, 'active'),
('Phường 2 VL',    'Phường 2',                            31, 'active'),
('Phường 3 VL',    'Phường 3',                            31, 'active'),
('Phường 4 VL',    'Phường 4',                            31, 'active'),
('Phường 5 VL',    'Phường 5',                            31, 'active'),
('Phường 8 VL',    'Phường 8',                            31, 'active'),
('Phường 9 VL',    'Phường 9',                            31, 'active'),
('Trường An VL',   'Trường An',                           31, 'active'),
('Tân Ngãi',       'Tân Ngãi',                            31, 'active'),
('Tân Hòa VL',     'Tân Hòa',                             31, 'active'),
('Tân Hội VL',     'Tân Hội',                             31, 'active'),

-- Huyện Long Hồ (old VL)
('Long Hồ',        'Long Hồ',                             31, 'active'),
('An Bình VL',     'An Bình',                             31, 'active'),
('Bình Hòa VL',    'Bình Hòa',                            31, 'active'),
('Đồng Phú',       'Đồng Phú',                            31, 'active'),
('Hòa Ninh',       'Hòa Ninh',                            31, 'active'),
('Long An VL',     'Long An',                             31, 'active'),
('Long Phước VL',  'Long Phước',                          31, 'active'),
('Phú Đức VL',     'Phú Đức',                             31, 'active'),
('Phước Hậu VL',   'Phước Hậu',                           31, 'active'),
('Thanh Đức',      'Thanh Đức',                           31, 'active'),
('Thạnh Quới',     'Thạnh Quới',                          31, 'active'),

-- Huyện Mang Thít (old VL)
('Cái Nhum',       'Cái Nhum',                            31, 'active'),
('An Phước VL',    'An Phước',                            31, 'active'),
('Bình Phước VL',  'Bình Phước',                          31, 'active'),
('Chánh An',       'Chánh An',                            31, 'active'),
('Long Mỹ VL',     'Long Mỹ',                             31, 'active'),
('Mỹ An VL',       'Mỹ An',                               31, 'active'),
('Nhơn Phú VL',    'Nhơn Phú',                            31, 'active'),
('Tân An Hội VL',  'Tân An Hội',                          31, 'active'),
('Tân Long VL',    'Tân Long',                            31, 'active'),

-- Huyện Vũng Liêm (old VL)
('Vũng Liêm',      'Vũng Liêm',                           31, 'active'),
('Hiếu Phụng',     'Hiếu Phụng',                          31, 'active'),
('Hiếu Thành',     'Hiếu Thành',                          31, 'active'),
('Trung Chánh',    'Trung Chánh',                         31, 'active'),
('Trung Hiệp',     'Trung Hiệp',                          31, 'active'),
('Trung Nghĩa',    'Trung Nghĩa',                         31, 'active'),
('Trung Thành Đông','Trung Thành Đông',                   31, 'active'),

-- TX. Bình Minh (old VL)
('Bình Minh',      'Bình Minh',                           31, 'active'),
('Cái Vồn',        'Cái Vồn',                             31, 'active'),
('Đông Bình',      'Đông Bình',                           31, 'active'),
('Đông Thành',     'Đông Thành',                          31, 'active'),
('Mỹ Hòa VL',      'Mỹ Hòa',                              31, 'active'),
('Thuận An VL',    'Thuận An',                            31, 'active'),

-- old Bến Tre: TP. Bến Tre
('Phường 1 BT',    'Phường 1',                            31, 'active'),
('Phường 2 BT',    'Phường 2',                            31, 'active'),
('Phường 3 BT',    'Phường 3',                            31, 'active'),
('Phường 4 BT',    'Phường 4',                            31, 'active'),
('Phường 5 BT',    'Phường 5',                            31, 'active'),
('Phường 6 BT',    'Phường 6',                            31, 'active'),
('Phường 7 BT',    'Phường 7',                            31, 'active'),
('Bình Phú BT',    'Bình Phú',                            31, 'active'),
('Mỹ Thạnh An',    'Mỹ Thạnh An',                         31, 'active'),
('Nhơn Thạnh BT',  'Nhơn Thạnh',                          31, 'active'),
('Phú Hưng BT',    'Phú Hưng',                            31, 'active'),
('Sơn Đông',       'Sơn Đông',                            31, 'active'),

-- Huyện Châu Thành BT (old BT)
('Tân Phú BT',     'Tân Phú',                             31, 'active'),
('An Khánh BT',    'An Khánh',                            31, 'active'),
('An Hiệp BT',     'An Hiệp',                             31, 'active'),
('An Phước BT',    'An Phước',                            31, 'active'),
('Giao Long',      'Giao Long',                           31, 'active'),
('Phú An Hòa',     'Phú An Hòa',                          31, 'active'),
('Phú Túc',        'Phú Túc',                             31, 'active'),
('Tân Thạch',      'Tân Thạch',                           31, 'active'),
('Tiên Long',      'Tiên Long',                           31, 'active'),
('Tiên Phong',     'Tiên Phong',                          31, 'active'),

-- Huyện Giồng Trôm (old BT)
('Giồng Trôm',     'Giồng Trôm',                          31, 'active'),
('Bình Thành BT',  'Bình Thành',                          31, 'active'),
('Hưng Phong',     'Hưng Phong',                          31, 'active'),
('Lương Hòa BT',   'Lương Hòa',                           31, 'active'),
('Lương Phú',      'Lương Phú',                           31, 'active'),
('Phong Nẫm',      'Phong Nẫm',                           31, 'active'),
('Sơn Phú',        'Sơn Phú',                             31, 'active'),
('Tân Hào',        'Tân Hào',                             31, 'active'),
('Tân Lợi Thạnh',  'Tân Lợi Thạnh',                       31, 'active'),

-- Huyện Ba Tri (old BT)
('Ba Tri',         'Ba Tri',                              31, 'active'),
('An Bình Tây',    'An Bình Tây',                         31, 'active'),
('An Đức',         'An Đức',                              31, 'active'),
('An Hiệp Tri',    'An Hiệp Tri',                         31, 'active'),
('An Hòa Tây',     'An Hòa Tây',                          31, 'active'),
('An Ngãi Tây',    'An Ngãi Tây',                         31, 'active'),
('Bảo Thạnh',      'Bảo Thạnh',                           31, 'active'),
('Bảo Thuận',      'Bảo Thuận',                           31, 'active'),
('Mỹ Hòa Tri',     'Mỹ Hòa',                              31, 'active'),
('Tân Xuân BT',    'Tân Xuân',                            31, 'active'),

-- Huyện Thạnh Phú (old BT)
('Thạnh Phú BT',   'Thạnh Phú',                           31, 'active'),
('An Điền BT',     'An Điền',                             31, 'active'),
('An Nhơn BT',     'An Nhơn',                             31, 'active'),
('An Quy',         'An Quy',                              31, 'active'),
('An Thạnh BT',    'An Thạnh',                            31, 'active'),
('Bình Thạnh Thạnh','Bình Thạnh',                         31, 'active'),
('Mỹ An BT',       'Mỹ An',                               31, 'active'),
('Phú Khánh',      'Phú Khánh',                           31, 'active'),
('Thới Thạnh',     'Thới Thạnh',                          31, 'active'),

-- old Trà Vinh: TP. Trà Vinh
('Phường 1 TV',    'Phường 1',                            31, 'active'),
('Phường 2 TV',    'Phường 2',                            31, 'active'),
('Phường 3 TV',    'Phường 3',                            31, 'active'),
('Phường 4 TV',    'Phường 4',                            31, 'active'),
('Phường 5 TV',    'Phường 5',                            31, 'active'),
('Phường 6 TV',    'Phường 6',                            31, 'active'),
('Phường 7 TV',    'Phường 7',                            31, 'active'),
('Phường 8 TV',    'Phường 8',                            31, 'active'),
('Phường 9 TV',    'Phường 9',                            31, 'active'),
('Long Đức TV',    'Long Đức',                            31, 'active'),

-- Huyện Châu Thành TV (old TV)
('Châu Thành TV',  'Châu Thành',                          31, 'active'),
('An Phú Tân',     'An Phú Tân',                          31, 'active'),
('Đa Lộc TV',      'Đa Lộc',                              31, 'active'),
('Hòa Lợi TV',     'Hòa Lợi',                             31, 'active'),
('Hòa Thuận TV',   'Hòa Thuận',                           31, 'active'),
('Long Hòa TV',    'Long Hòa',                            31, 'active'),
('Mỹ Chánh TV',    'Mỹ Chánh',                            31, 'active'),
('Song Lộc',       'Song Lộc',                            31, 'active'),
('Thanh Mỹ TV',    'Thanh Mỹ',                            31, 'active'),

-- Huyện Cầu Kè (old TV)
('Cầu Kè',         'Cầu Kè',                              31, 'active'),
('An Phú Tân CK',  'An Phú Tân',                          31, 'active'),
('Châu Điền',      'Châu Điền',                           31, 'active'),
('Hòa Ân',         'Hòa Ân',                              31, 'active'),
('Ninh Thới',      'Ninh Thới',                           31, 'active'),
('Phong Phú TV',   'Phong Phú',                           31, 'active'),
('Tam Ngãi',       'Tam Ngãi',                            31, 'active'),
('Thông Hòa',      'Thông Hòa',                           31, 'active'),

-- Huyện Trà Cú (old TV)
('Trà Cú',         'Trà Cú',                              31, 'active'),
('An Quảng Hữu',   'An Quảng Hữu',                        31, 'active'),
('Đại An',         'Đại An',                              31, 'active'),
('Hàm Giang',      'Hàm Giang',                           31, 'active'),
('Hàm Tân',        'Hàm Tân',                             31, 'active'),
('Kim Sơn TV',     'Kim Sơn',                             31, 'active'),
('Lưu Nghiệp Anh', 'Lưu Nghiệp Anh',                      31, 'active'),
('Long Hiệp TV',   'Long Hiệp',                           31, 'active'),
('Ngãi Xuyên',     'Ngãi Xuyên',                          31, 'active'),
('Phước Hưng TV',  'Phước Hưng',                          31, 'active'),
('Tân Hiệp TV',    'Tân Hiệp',                            31, 'active'),
('Tập Sơn',        'Tập Sơn',                             31, 'active'),

-- ============================================================
-- AN GIANG (gộp Kiên Giang) (tinh_thanh_id = 32)
-- ============================================================

-- TP. Long Xuyên
('Bình Đức AG',    'Bình Đức',                            32, 'active'),
('Bình Khánh AG',  'Bình Khánh',                          32, 'active'),
('Đông Xuyên',     'Đông Xuyên',                          32, 'active'),
('Mỹ Bình',        'Mỹ Bình',                             32, 'active'),
('Mỹ Hòa AG',      'Mỹ Hòa',                              32, 'active'),
('Mỹ Khánh',       'Mỹ Khánh',                            32, 'active'),
('Mỹ Long',        'Mỹ Long',                             32, 'active'),
('Mỹ Phước LX',    'Mỹ Phước',                            32, 'active'),
('Mỹ Quý',         'Mỹ Quý',                              32, 'active'),
('Mỹ Thạnh AG',    'Mỹ Thạnh',                            32, 'active'),
('Mỹ Xuyên',       'Mỹ Xuyên',                            32, 'active'),

-- TP. Châu Đốc
('Châu Phú A',     'Châu Phú A',                          32, 'active'),
('Châu Phú B',     'Châu Phú B',                          32, 'active'),
('Núi Sam',        'Núi Sam',                             32, 'active'),
('Vĩnh Mỹ',        'Vĩnh Mỹ',                             32, 'active'),
('Vĩnh Nguơn',     'Vĩnh Nguơn',                          32, 'active'),

-- TX. Tân Châu (old AG)
('Long Châu',      'Long Châu',                           32, 'active'),
('Long Hưng AG',   'Long Hưng',                           32, 'active'),
('Long Phú AG',    'Long Phú',                            32, 'active'),
('Long Thạnh AG',  'Long Thạnh',                          32, 'active'),
('Tân An TC',      'Tân An',                              32, 'active'),
('Vĩnh Hòa AG',    'Vĩnh Hòa',                            32, 'active'),
('Vĩnh Xương',     'Vĩnh Xương',                          32, 'active'),

-- Huyện An Phú (old AG)
('An Phú AG',      'An Phú',                              32, 'active'),
('Đa Phước AG',    'Đa Phước',                            32, 'active'),
('Khánh An',       'Khánh An',                            32, 'active'),
('Khánh Bình AG',  'Khánh Bình',                          32, 'active'),
('Long Bình AG',   'Long Bình',                           32, 'active'),
('Nhơn Hội AG',    'Nhơn Hội',                            32, 'active'),
('Phú Hữu AG',     'Phú Hữu',                             32, 'active'),
('Phước Hưng AG',  'Phước Hưng',                          32, 'active'),
('Quốc Thái',      'Quốc Thái',                           32, 'active'),
('Vĩnh Hội Đông',  'Vĩnh Hội Đông',                       32, 'active'),

-- Huyện Châu Phú (old AG)
('Cái Dầu',        'Cái Dầu',                             32, 'active'),
('Bình Chánh AG',  'Bình Chánh',                          32, 'active'),
('Bình Long AG',   'Bình Long',                           32, 'active'),
('Bình Mỹ AG',     'Bình Mỹ',                             32, 'active'),
('Bình Thủy AG',   'Bình Thủy',                           32, 'active'),
('Đào Hữu Cảnh',   'Đào Hữu Cảnh',                        32, 'active'),
('Khánh Hòa AG',   'Khánh Hòa',                           32, 'active'),
('Mỹ Đức AG',      'Mỹ Đức',                              32, 'active'),
('Mỹ Phú AG',      'Mỹ Phú',                              32, 'active'),
('Thạnh Mỹ Tây',   'Thạnh Mỹ Tây',                        32, 'active'),

-- Huyện Thoại Sơn (old AG)
('Núi Sập',        'Núi Sập',                             32, 'active'),
('Bình Thành AG',  'Bình Thành',                          32, 'active'),
('Định Mỹ',        'Định Mỹ',                             32, 'active'),
('Mỹ Phú Đông',    'Mỹ Phú Đông',                         32, 'active'),
('Phú Thuận AG',   'Phú Thuận',                           32, 'active'),
('Thoại Giang',    'Thoại Giang',                         32, 'active'),
('Vọng Đông',      'Vọng Đông',                           32, 'active'),
('Vọng Thê',       'Vọng Thê',                            32, 'active'),

-- Huyện Tri Tôn (old AG)
('Tri Tôn',        'Tri Tôn',                             32, 'active'),
('An Tức',         'An Tức',                              32, 'active'),
('Châu Lăng',      'Châu Lăng',                           32, 'active'),
('Lê Trì',         'Lê Trì',                              32, 'active'),
('Lương An Trà',   'Lương An Trà',                         32, 'active'),
('Lương Phi',      'Lương Phi',                           32, 'active'),
('Ô Lâm',          'Ô Lâm',                               32, 'active'),
('Tà Đảnh',        'Tà Đảnh',                             32, 'active'),
('Tân Tuyến',      'Tân Tuyến',                           32, 'active'),

-- old Kiên Giang: TP. Rạch Giá
('An Bình KG',     'An Bình',                             32, 'active'),
('Phường An Hòa',  'An Hòa',                              32, 'active'),
('Phường Rạch Sỏi','Rạch Sỏi',                            32, 'active'),
('Phường Vĩnh Bảo','Vĩnh Bảo',                            32, 'active'),
('Phường Vĩnh Hiệp','Vĩnh Hiệp',                          32, 'active'),
('Phường Vĩnh Hòa','Vĩnh Hòa',                            32, 'active'),
('Phường Vĩnh Lạc','Vĩnh Lạc',                            32, 'active'),
('Phường Vĩnh Lợi','Vĩnh Lợi',                            32, 'active'),
('Phường Vĩnh Quang','Vĩnh Quang',                        32, 'active'),
('Phường Vĩnh Thanh','Vĩnh Thanh',                        32, 'active'),
('Phường Vĩnh Thông','Vĩnh Thông',                        32, 'active'),
('Phi Thông',      'Phi Thông',                           32, 'active'),

-- TP. Hà Tiên (old KG)
('Bình San',       'Bình San',                            32, 'active'),
('Đông Hồ',        'Đông Hồ',                             32, 'active'),
('Mỹ Đức KG',      'Mỹ Đức',                              32, 'active'),
('Phú Mỹ KG',      'Phú Mỹ',                              32, 'active'),
('Thuận Yên',      'Thuận Yên',                           32, 'active'),
('Tiên Hải',       'Tiên Hải',                            32, 'active'),
('Tô Châu',        'Tô Châu',                             32, 'active'),

-- Huyện Phú Quốc (old KG)
('Dương Đông',     'Dương Đông',                          32, 'active'),
('An Thới',        'An Thới',                             32, 'active'),
('Cửa Cạn',        'Cửa Cạn',                             32, 'active'),
('Cửa Dương',      'Cửa Dương',                           32, 'active'),
('Dương Tơ',       'Dương Tơ',                            32, 'active'),
('Gành Dầu',       'Gành Dầu',                            32, 'active'),
('Hàm Ninh',       'Hàm Ninh',                            32, 'active'),
('Hòn Thơm',       'Hòn Thơm',                            32, 'active'),
('Thổ Châu',       'Thổ Châu',                            32, 'active'),

-- Huyện Kiên Lương (old KG)
('Kiên Lương',     'Kiên Lương',                          32, 'active'),
('Bình An KG',     'Bình An',                             32, 'active'),
('Dương Hòa',      'Dương Hòa',                           32, 'active'),
('Hòa Điền',       'Hòa Điền',                            32, 'active'),
('Sơn Hải',        'Sơn Hải',                             32, 'active'),
('Vĩnh Điều',      'Vĩnh Điều',                           32, 'active'),

-- Huyện Giang Thành (old KG)
('Giang Thành',    'Giang Thành',                         32, 'active'),
('Phú Lợi KG',     'Phú Lợi',                             32, 'active'),
('Phú Mỹ Giang',   'Phú Mỹ',                              32, 'active'),
('Tân Khánh Hòa',  'Tân Khánh Hòa',                       32, 'active'),
('Vĩnh Phú KG',    'Vĩnh Phú',                            32, 'active'),

-- Huyện Châu Thành KG (old KG)
('Minh Lương',     'Minh Lương',                          32, 'active'),
('Bình An CT',     'Bình An',                             32, 'active'),
('Giục Tượng',     'Giục Tượng',                          32, 'active'),
('Mong Thọ A',     'Mong Thọ A',                          32, 'active'),
('Mong Thọ B',     'Mong Thọ B',                          32, 'active'),
('Vĩnh Hòa Hiệp',  'Vĩnh Hòa Hiệp',                       32, 'active'),

-- ============================================================
-- CẦN THƠ (gộp Hậu Giang + Sóc Trăng) (tinh_thanh_id = 33)
-- ============================================================

-- TP. Cần Thơ — Quận Ninh Kiều
('An Bình CT',     'An Bình',                             33, 'active'),
('An Cư',          'An Cư',                               33, 'active'),
('An Hòa CT',      'An Hòa',                              33, 'active'),
('An Khánh CT',    'An Khánh',                            33, 'active'),
('An Nghiệp',      'An Nghiệp',                           33, 'active'),
('An Phú CT',      'An Phú',                              33, 'active'),
('Cái Khế',        'Cái Khế',                             33, 'active'),
('Hưng Lợi',       'Hưng Lợi',                            33, 'active'),
('Tân An CT',      'Tân An',                              33, 'active'),
('Thới Bình CT',   'Thới Bình',                           33, 'active'),
('Xuân Khánh',     'Xuân Khánh',                          33, 'active'),

-- Quận Bình Thủy (Cần Thơ)
('An Thới CT',     'An Thới',                             33, 'active'),
('Bình Thủy CT',   'Bình Thủy',                           33, 'active'),
('Bùi Hữu Nghĩa',  'Bùi Hữu Nghĩa',                       33, 'active'),
('Long Hòa CT',    'Long Hòa',                            33, 'active'),
('Long Tuyền',     'Long Tuyền',                          33, 'active'),
('Thới An Đông',   'Thới An Đông',                        33, 'active'),

-- Quận Cái Răng (Cần Thơ)
('Ba Láng',        'Ba Láng',                             33, 'active'),
('Lê Bình',        'Lê Bình',                             33, 'active'),
('Phú Thứ',        'Phú Thứ',                             33, 'active'),
('Tân Phú CT',     'Tân Phú',                             33, 'active'),
('Thường Thạnh',   'Thường Thạnh',                        33, 'active'),
('Trung An CT',    'Trung An',                            33, 'active'),
('Trung Kiên',     'Trung Kiên',                          33, 'active'),

-- Huyện Phong Điền CT (Cần Thơ)
('Phong Điền CT',  'Phong Điền',                          33, 'active'),
('Giai Xuân CT',   'Giai Xuân',                           33, 'active'),
('Mỹ Khánh CT',    'Mỹ Khánh',                            33, 'active'),
('Nhơn Ái',        'Nhơn Ái',                             33, 'active'),
('Nhơn Nghĩa',     'Nhơn Nghĩa',                          33, 'active'),
('Tân Thới CT',    'Tân Thới',                            33, 'active'),
('Trường Long',    'Trường Long',                         33, 'active'),

-- Huyện Cờ Đỏ (Cần Thơ)
('Cờ Đỏ',          'Cờ Đỏ',                               33, 'active'),
('Đông Hiệp',      'Đông Hiệp',                           33, 'active'),
('Đông Thắng',     'Đông Thắng',                          33, 'active'),
('Thạnh Phú CT',   'Thạnh Phú',                           33, 'active'),
('Thới Đông',      'Thới Đông',                           33, 'active'),
('Thới Hưng',      'Thới Hưng',                           33, 'active'),
('Thới Xuân',      'Thới Xuân',                           33, 'active'),
('Trung An',       'Trung An',                            33, 'active'),
('Trung Hưng',     'Trung Hưng',                          33, 'active'),

-- Huyện Thới Lai (Cần Thơ)
('Thới Lai',       'Thới Lai',                            33, 'active'),
('Định Môn',       'Định Môn',                            33, 'active'),
('Đông Bình CT',   'Đông Bình',                           33, 'active'),
('Đông Thuận',     'Đông Thuận',                          33, 'active'),
('Tân Thạnh CT',   'Tân Thạnh',                           33, 'active'),
('Thới Tân',       'Thới Tân',                            33, 'active'),
('Trường Thắng',   'Trường Thắng',                        33, 'active'),
('Trường Xuân CT', 'Trường Xuân',                         33, 'active'),

-- old Hậu Giang: TP. Vị Thanh
('Phường 1 VT',    'Phường 1',                            33, 'active'),
('Phường 3 VT',    'Phường 3',                            33, 'active'),
('Phường 4 VT',    'Phường 4',                            33, 'active'),
('Phường 5 VT',    'Phường 5',                            33, 'active'),
('Phường 7 VT',    'Phường 7',                            33, 'active'),
('Tân Tiến HG',    'Tân Tiến',                            33, 'active'),
('Vị Tân',         'Vị Tân',                              33, 'active'),
('Vị Thắng',       'Vị Thắng',                            33, 'active'),

-- TX. Ngã Bảy (old HG)
('Hiệp Lợi',       'Hiệp Lợi',                            33, 'active'),
('Hiệp Thành HG',  'Hiệp Thành',                          33, 'active'),
('Lái Hiếu',       'Lái Hiếu',                            33, 'active'),
('Ngã Bảy',        'Ngã Bảy',                             33, 'active'),
('Tân Thành HG',   'Tân Thành',                           33, 'active'),

-- Huyện Châu Thành HG (old HG)
('Ngã Sáu',        'Ngã Sáu',                             33, 'active'),
('Đông Phú HG',    'Đông Phú',                            33, 'active'),
('Đông Thạnh HG',  'Đông Thạnh',                          33, 'active'),
('Phú An HG',      'Phú An',                              33, 'active'),
('Phú Hữu HG',     'Phú Hữu',                             33, 'active'),
('Phú Tân HG',     'Phú Tân',                             33, 'active'),
('Phú Thứ HG',     'Phú Thứ',                             33, 'active'),

-- Huyện Phụng Hiệp (old HG)
('Cây Dương',      'Cây Dương',                           33, 'active'),
('Bình Thành HG',  'Bình Thành',                          33, 'active'),
('Hòa An HG',      'Hòa An',                              33, 'active'),
('Long Thạnh HG',  'Long Thạnh',                          33, 'active'),
('Phụng Hiệp',     'Phụng Hiệp',                          33, 'active'),
('Tân Bình HG',    'Tân Bình',                            33, 'active'),
('Tân Long HG',    'Tân Long',                            33, 'active'),
('Thạnh Hòa HG',   'Thạnh Hòa',                           33, 'active'),

-- old Sóc Trăng: TP. Sóc Trăng
('Phường 1 ST',    'Phường 1',                            33, 'active'),
('Phường 2 ST',    'Phường 2',                            33, 'active'),
('Phường 3 ST',    'Phường 3',                            33, 'active'),
('Phường 4 ST',    'Phường 4',                            33, 'active'),
('Phường 5 ST',    'Phường 5',                            33, 'active'),
('Phường 6 ST',    'Phường 6',                            33, 'active'),
('Phường 7 ST',    'Phường 7',                            33, 'active'),
('Phường 8 ST',    'Phường 8',                            33, 'active'),
('Phường 9 ST',    'Phường 9',                            33, 'active'),
('Phường 10 ST',   'Phường 10',                           33, 'active'),

-- Huyện Mỹ Xuyên (old ST)
('Mỹ Xuyên ST',    'Mỹ Xuyên',                            33, 'active'),
('Đại Tâm',        'Đại Tâm',                             33, 'active'),
('Gia Hòa 1',      'Gia Hòa 1',                           33, 'active'),
('Gia Hòa 2',      'Gia Hòa 2',                           33, 'active'),
('Ngọc Đông',      'Ngọc Đông',                           33, 'active'),
('Ngọc Tố',        'Ngọc Tố',                             33, 'active'),
('Thạnh Phú ST',   'Thạnh Phú',                           33, 'active'),
('Thạnh Quới ST',  'Thạnh Quới',                          33, 'active'),

-- Huyện Long Phú (old ST)
('Long Phú ST',    'Long Phú',                            33, 'active'),
('Châu Khánh',     'Châu Khánh',                          33, 'active'),
('Đại Ngãi',       'Đại Ngãi',                            33, 'active'),
('Hậu Thạnh',      'Hậu Thạnh',                           33, 'active'),
('Long Đức ST',    'Long Đức',                            33, 'active'),
('Phú Hữu ST',     'Phú Hữu',                             33, 'active'),
('Song Phụng',     'Song Phụng',                          33, 'active'),
('Tân Hưng ST',    'Tân Hưng',                            33, 'active'),
('Trường Khánh',   'Trường Khánh',                        33, 'active'),

-- Huyện Trần Đề (old ST)
('Trần Đề',        'Trần Đề',                             33, 'active'),
('Đại Ân 1',       'Đại Ân 1',                            33, 'active'),
('Đại Ân 2',       'Đại Ân 2',                            33, 'active'),
('Lịch Hội Thượng','Lịch Hội Thượng',                     33, 'active'),
('Tài Văn',        'Tài Văn',                             33, 'active'),
('Thạnh Thới An',  'Thạnh Thới An',                       33, 'active'),
('Thạnh Thới Thuận','Thạnh Thới Thuận',                   33, 'active'),
('Viên An ST',     'Viên An',                             33, 'active'),

-- ============================================================
-- CÀ MAU (gộp Bạc Liêu) (tinh_thanh_id = 34)
-- ============================================================

-- TP. Cà Mau
('Phường 1 CM',    'Phường 1',                            34, 'active'),
('Phường 2 CM',    'Phường 2',                            34, 'active'),
('Phường 4 CM',    'Phường 4',                            34, 'active'),
('Phường 5 CM',    'Phường 5',                            34, 'active'),
('Phường 6 CM',    'Phường 6',                            34, 'active'),
('Phường 7 CM',    'Phường 7',                            34, 'active'),
('Phường 8 CM',    'Phường 8',                            34, 'active'),
('Phường 9 CM',    'Phường 9',                            34, 'active'),
('An Xuyên',       'An Xuyên',                            34, 'active'),
('Định Bình',      'Định Bình',                           34, 'active'),
('Hòa Thành CM',   'Hòa Thành',                           34, 'active'),
('Lý Văn Lâm',     'Lý Văn Lâm',                          34, 'active'),
('Tân Thành CM',   'Tân Thành',                           34, 'active'),
('Tân Xuyên',      'Tân Xuyên',                           34, 'active'),

-- Huyện Thới Bình (old CM)
('Thới Bình',      'Thới Bình',                           34, 'active'),
('Biển Bạch',      'Biển Bạch',                           34, 'active'),
('Biển Bạch Đông', 'Biển Bạch Đông',                      34, 'active'),
('Hồ Thị Kỷ',      'Hồ Thị Kỷ',                           34, 'active'),
('Tân Bằng',       'Tân Bằng',                            34, 'active'),
('Tân Lộc',        'Tân Lộc',                             34, 'active'),
('Tân Lộc Bắc',    'Tân Lộc Bắc',                         34, 'active'),
('Tân Lộc Đông',   'Tân Lộc Đông',                        34, 'active'),
('Tân Phú CM',     'Tân Phú',                             34, 'active'),
('Trí Lực',        'Trí Lực',                             34, 'active'),
('Trí Phải',       'Trí Phải',                            34, 'active'),

-- Huyện U Minh (old CM)
('U Minh',         'U Minh',                              34, 'active'),
('Khánh An CM',    'Khánh An',                            34, 'active'),
('Khánh Hòa CM',   'Khánh Hòa',                           34, 'active'),
('Khánh Hội',      'Khánh Hội',                           34, 'active'),
('Khánh Lâm',      'Khánh Lâm',                           34, 'active'),
('Khánh Thuận',    'Khánh Thuận',                         34, 'active'),
('Nguyễn Phích',   'Nguyễn Phích',                        34, 'active'),

-- Huyện Trần Văn Thời (old CM)
('Trần Văn Thời',  'Trần Văn Thời',                       34, 'active'),
('Hòa Mỹ CM',      'Hòa Mỹ',                              34, 'active'),
('Khánh Bình Đông','Khánh Bình Đông',                     34, 'active'),
('Khánh Bình Tây', 'Khánh Bình Tây',                      34, 'active'),
('Khánh Bình Tây Bắc','Khánh Bình Tây Bắc',               34, 'active'),
('Khánh Hải',      'Khánh Hải',                           34, 'active'),
('Lợi An',         'Lợi An',                              34, 'active'),
('Phong Điền CM',  'Phong Điền',                          34, 'active'),
('Phong Lạc',      'Phong Lạc',                           34, 'active'),
('Trần Hợi',       'Trần Hợi',                            34, 'active'),

-- Huyện Cái Nước (old CM)
('Cái Nước',       'Cái Nước',                            34, 'active'),
('Đông Hưng CM',   'Đông Hưng',                           34, 'active'),
('Đông Hưng A',    'Đông Hưng A',                         34, 'active'),
('Đông Thới',      'Đông Thới',                           34, 'active'),
('Hòa Mỹ Tây',     'Hòa Mỹ Tây',                          34, 'active'),
('Lương Thế Trân', 'Lương Thế Trân',                      34, 'active'),
('Phú Hưng CM',    'Phú Hưng',                            34, 'active'),
('Tân Hưng CM',    'Tân Hưng',                            34, 'active'),
('Trần Thới',      'Trần Thới',                           34, 'active'),

-- Huyện Đầm Dơi (old CM)
('Đầm Dơi',        'Đầm Dơi',                             34, 'active'),
('Nguyễn Huân',    'Nguyễn Huân',                         34, 'active'),
('Quách Phẩm',     'Quách Phẩm',                          34, 'active'),
('Quách Phẩm Bắc', 'Quách Phẩm Bắc',                      34, 'active'),
('Tân Dân CM',     'Tân Dân',                             34, 'active'),
('Tân Duyệt',      'Tân Duyệt',                           34, 'active'),
('Tân Tiến CM',    'Tân Tiến',                            34, 'active'),
('Tân Thuận CM',   'Tân Thuận',                           34, 'active'),
('Tân Trung CM',   'Tân Trung',                           34, 'active'),

-- Huyện Ngọc Hiển (old CM)
('Rạch Gốc',       'Rạch Gốc',                            34, 'active'),
('Đất Mũi',        'Đất Mũi',                             34, 'active'),
('Tam Giang CM',   'Tam Giang',                           34, 'active'),
('Tam Giang Đông', 'Tam Giang Đông',                      34, 'active'),
('Tân Ân',         'Tân Ân',                              34, 'active'),
('Tân Ân Tây',     'Tân Ân Tây',                          34, 'active'),
('Viên An CM',     'Viên An',                             34, 'active'),
('Viên An Đông',   'Viên An Đông',                        34, 'active'),

-- old Bạc Liêu: TP. Bạc Liêu
('Hiệp Thành BL',  'Hiệp Thành',                          34, 'active'),
('Nhà Mát',        'Nhà Mát',                             34, 'active'),
('Phường 1 BL',    'Phường 1',                            34, 'active'),
('Phường 2 BL',    'Phường 2',                            34, 'active'),
('Phường 3 BL',    'Phường 3',                            34, 'active'),
('Phường 5 BL',    'Phường 5',                            34, 'active'),
('Phường 7 BL',    'Phường 7',                            34, 'active'),
('Phường 8 BL',    'Phường 8',                            34, 'active'),
('Vĩnh Trạch',     'Vĩnh Trạch',                          34, 'active'),
('Vĩnh Trạch Đông','Vĩnh Trạch Đông',                     34, 'active'),

-- Huyện Hòa Bình (old BL)
('Hòa Bình BL',    'Hòa Bình',                            34, 'active'),
('Minh Diệu',      'Minh Diệu',                           34, 'active'),
('Vĩnh Bình BL',   'Vĩnh Bình',                           34, 'active'),
('Vĩnh Hậu',       'Vĩnh Hậu',                            34, 'active'),
('Vĩnh Hậu A',     'Vĩnh Hậu A',                          34, 'active'),
('Vĩnh Mỹ A',      'Vĩnh Mỹ A',                           34, 'active'),
('Vĩnh Mỹ B',      'Vĩnh Mỹ B',                           34, 'active'),
('Vĩnh Thịnh',     'Vĩnh Thịnh',                          34, 'active'),

-- Huyện Đông Hải (old BL)
('Gành Hào',       'Gành Hào',                            34, 'active'),
('An Phúc',        'An Phúc',                             34, 'active'),
('An Trạch',       'An Trạch',                            34, 'active'),
('An Trạch A',     'An Trạch A',                          34, 'active'),
('Điền Hải BL',    'Điền Hải',                            34, 'active'),
('Long Điền',      'Long Điền',                           34, 'active'),
('Long Điền Đông', 'Long Điền Đông',                      34, 'active'),
('Long Điền Đông A','Long Điền Đông A',                   34, 'active'),
('Long Điền Tây',  'Long Điền Tây',                       34, 'active'),

-- Huyện Giá Rai (old BL)
('Giá Rai',        'Giá Rai',                             34, 'active'),
('Phong Tân',      'Phong Tân',                           34, 'active'),
('Phong Thạnh',    'Phong Thạnh',                         34, 'active'),
('Phong Thạnh A',  'Phong Thạnh A',                       34, 'active'),
('Phong Thạnh Tây A','Phong Thạnh Tây A',                 34, 'active'),
('Phong Thạnh Tây B','Phong Thạnh Tây B',                 34, 'active'),
('Tân Phong BL',   'Tân Phong',                           34, 'active'),
('Tân Thành BL',   'Tân Thành',                           34, 'active'),

-- Huyện Phước Long (old BL)
('Phước Long BL',  'Phước Long',                          34, 'active'),
('Hưng Phú BL',    'Hưng Phú',                            34, 'active'),
('Phong Thạnh Đông','Phong Thạnh Đông',                   34, 'active'),
('Vĩnh Phú Đông',  'Vĩnh Phú Đông',                       34, 'active'),
('Vĩnh Phú Tây',   'Vĩnh Phú Tây',                        34, 'active')

ON CONFLICT (tinh_thanh_id, ten_phuong_xa) DO UPDATE SET
  ten_phuong_xa_cu = EXCLUDED.ten_phuong_xa_cu,
  status           = EXCLUDED.status;
