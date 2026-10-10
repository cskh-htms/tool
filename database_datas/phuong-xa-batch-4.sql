-- ============================================================
-- PHƯỜNG XÃ BATCH 4
-- Lào Cai + Yên Bái (id=7), Thái Nguyên + Bắc Kạn (id=8)
-- ============================================================

INSERT INTO phuong_xa (ten_phuong_xa, ten_phuong_xa_cu, tinh_thanh_id, status) VALUES

-- ============================================================
-- TỈNH LÀO CAI (gộp Yên Bái) (tinh_thanh_id = 7)
-- ============================================================

-- TP. Lào Cai (cũ)
('Kim Tân',      'Kim Tân, Lào Cai',                  7, 'active'),
('Phố Mới',      'Phố Mới, Xuân Tăng',               7, 'active'),
('Bắc Lệnh',     'Bắc Lệnh, Bắc Cường',              7, 'active'),
('Đồng Tuyển',   'Đồng Tuyển, Tả Phời',              7, 'active'),
('Vạn Hòa',      'Vạn Hòa, Hợp Thành',               7, 'active'),
('Nam Cường LC', 'Nam Cường',                          7, 'active'),

-- Huyện Bát Xát
('Bát Xát',      'Bát Xát',                            7, 'active'),
('Bản Vược',     'Bản Vược, Cốc Mỳ',                  7, 'active'),
('Dền Sáng',     'Dền Sáng, Dền Thàng',               7, 'active'),
('Mường Hum',    'Mường Hum, Nậm Chạc',               7, 'active'),
('Sàng Ma Sáo',  'Sàng Ma Sáo, Trung Lèng Hồ',       7, 'active'),
('Bản Qua',      'Bản Qua, Mường Vi',                  7, 'active'),
('Phìn Ngan',    'Phìn Ngan, Tòng Sành',              7, 'active'),
('Y Tý',         'Y Tý, Nậm Pung',                    7, 'active'),
('Ngải Thầu',    'Ngải Thầu, A Lù, Pa Cheo',         7, 'active'),

-- Huyện Mường Khương
('Mường Khương', 'Mường Khương',                       7, 'active'),
('Cao Sơn MK',   'Cao Sơn, Dìn Chin',                 7, 'active'),
('Tả Ngải Chồ',  'Tả Ngải Chồ, Nậm Chảy',            7, 'active'),
('Pha Long',     'Pha Long, Tả Gia Khâu',             7, 'active'),
('Lùng Vai',     'Lùng Vai, Bản Lầu',                 7, 'active'),
('La Pán Tẩn',   'La Pán Tẩn, Tung Chung Phố',       7, 'active'),
('Thanh Bình MK','Thanh Bình, Nậm Chầu',              7, 'active'),
('Lùng Khấu Nhin','Lùng Khấu Nhin',                   7, 'active'),

-- Huyện Si Ma Cai
('Si Ma Cai',    'Si Ma Cai',                          7, 'active'),
('Bản Mế',       'Bản Mế, Thào Chư Phìn',             7, 'active'),
('Lùng Sui',     'Lùng Sui, Nàn Sán',                 7, 'active'),
('Mản Thẩn',     'Mản Thẩn, Cán Cấu',                7, 'active'),
('Sín Chéng',    'Sín Chéng, Quan Thần Sán',         7, 'active'),
('Nàn Sín',      'Nàn Sín',                           7, 'active'),

-- Huyện Bắc Hà
('Bắc Hà',       'Bắc Hà',                             7, 'active'),
('Lùng Cải',     'Lùng Cải, Lùng Phình',              7, 'active'),
('Tả Van Chư',   'Tả Van Chư, Tả Củ Tỷ',             7, 'active'),
('Cốc Ly',       'Cốc Ly, Nậm Đét',                   7, 'active'),
('Nậm Mòn',      'Nậm Mòn, Thải Giàng Phố',          7, 'active'),
('Na Hối',       'Na Hối, Hoàng Thu Phố',             7, 'active'),
('Bảo Nhai',     'Bảo Nhai, Bản Cái',                 7, 'active'),

-- Huyện Bảo Thắng
('Phố Lu',       'Phố Lu',                             7, 'active'),
('Long Khánh',   'Long Khánh, Phong Niên',             7, 'active'),
('Gia Phú',      'Gia Phú, Xuân Quang BT',            7, 'active'),
('Sơn Hà BT',    'Sơn Hà, Thái Niên',                 7, 'active'),
('Bản Phiệt',    'Bản Phiệt, Bản Cầm',               7, 'active'),
('Trì Quang',    'Trì Quang, Phú Nhuận',              7, 'active'),
('Sơn Hải',      'Sơn Hải',                            7, 'active'),

-- Huyện Bảo Yên
('Phố Ràng',     'Phố Ràng',                           7, 'active'),
('Bảo Hà',       'Bảo Hà, Yên Sơn BY',               7, 'active'),
('Lương Sơn BY', 'Lương Sơn, Long Phúc',              7, 'active'),
('Kim Sơn BY',   'Kim Sơn, Tân Dương',                7, 'active'),
('Cam Cọn',      'Cam Cọn, Nghĩa Đô',                 7, 'active'),
('Vĩnh Yên BY',  'Vĩnh Yên, Xuân Thượng',            7, 'active'),
('Điện Quan',    'Điện Quan, Minh Tân BY',            7, 'active'),

-- Huyện Văn Bàn
('Khánh Yên',    'Khánh Yên',                          7, 'active'),
('Nậm Xé',       'Nậm Xé, Dương Quỳ',                 7, 'active'),
('Nậm Rạng',     'Nậm Rạng, Liêm Phú',               7, 'active'),
('Chiềng Ken',   'Chiềng Ken, Nậm Tha',               7, 'active'),
('Lao Chải VB',  'Lao Chải, Nậm Xây',                 7, 'active'),
('Tân Thượng VB','Tân Thượng, Tân An VB',             7, 'active'),
('Hòa Mạc',      'Hòa Mạc, Sơn Thủy VB',             7, 'active'),
('Thẩm Dương',   'Thẩm Dương',                         7, 'active'),

-- TX. Sa Pa
('Sa Pa',        'Sa Pa',                              7, 'active'),
('Hàm Rồng',     'Hàm Rồng, Phan Si Păng',            7, 'active'),
('Ô Quý Hồ',     'Ô Quý Hồ, Trung Chải SP',          7, 'active'),
('Tả Phìn SP',   'Tả Phìn',                            7, 'active'),
('Tả Van',       'Tả Van, Lao Chải SP',               7, 'active'),
('Hầu Thào',     'Hầu Thào, Sử Pán',                  7, 'active'),
('San Sả Hồ',    'San Sả Hồ, Bản Hồ',                7, 'active'),
('Nậm Cang',     'Nậm Cang, Thanh Kim, Thanh Phú',    7, 'active'),
('Bản Phùng SP', 'Bản Phùng',                          7, 'active'),

-- TP. Yên Bái (cũ, nay thuộc Lào Cai tỉnh mới)
('Nguyễn Thái Học','Nguyễn Thái Học, Đồng Tâm',       7, 'active'),
('Minh Tân YB',  'Minh Tân, Nam Cường YB',             7, 'active'),
('Nguyễn Phúc',  'Nguyễn Phúc, Hồng Hà',              7, 'active'),
('Yên Thịnh',    'Yên Thịnh, Tuy Lộc',                7, 'active'),
('Giới Phiên',   'Giới Phiên, Văn Tiến',              7, 'active'),
('Âu Lâu',       'Âu Lâu, Phúc Lộc',                  7, 'active'),
('Tân Thịnh YB', 'Tân Thịnh',                          7, 'active'),

-- TX. Nghĩa Lộ (Yên Bái cũ)
('Pú Trạng',     'Pú Trạng, Cầu Thia',               7, 'active'),
('Trung Tâm NL', 'Trung Tâm, Nghĩa Lộ',              7, 'active'),
('Nghĩa Phúc',   'Nghĩa Phúc, Sơn A',               7, 'active'),
('Phúc Sơn NL',  'Phúc Sơn',                          7, 'active'),

-- Huyện Lục Yên (Yên Bái cũ)
('Yên Thế',      'Yên Thế, Khánh Hòa',               7, 'active'),
('Lâm Thượng',   'Lâm Thượng, Tô Mậu',               7, 'active'),
('Tân Lĩnh',     'Tân Lĩnh, Minh Xuân LY',           7, 'active'),
('Liễu Đô',      'Liễu Đô, Vĩnh Lạc',                7, 'active'),
('Động Quan',    'Động Quan, Tân Phượng',             7, 'active'),
('An Lạc LY',    'An Lạc, Đông Thành',               7, 'active'),
('Minh Tiến LY', 'Minh Tiến, Xuân Long',             7, 'active'),
('Mường Lai',    'Mường Lai, An Phú',                 7, 'active'),

-- Huyện Yên Bình (Yên Bái cũ)
('Yên Bình',     'Yên Bình',                           7, 'active'),
('Xuân Lai',     'Xuân Lai, Yên Thành YBinh',         7, 'active'),
('Vũ Linh',      'Vũ Linh, Tích Cốc',                7, 'active'),
('Ngọc Chấn',    'Ngọc Chấn, Cảm Nhân',              7, 'active'),
('Phúc Ninh YB', 'Phúc Ninh, Hán Đà',                7, 'active'),
('Thịnh Hưng',   'Thịnh Hưng, Bạch Hà',              7, 'active'),
('Bảo Ái',       'Bảo Ái, Mỹ Gia',                    7, 'active'),
('Cảm Ân',       'Cảm Ân, Ngọc Lũ, Tân Hương YB',   7, 'active'),

-- Huyện Trấn Yên (Yên Bái cũ)
('Cổ Phúc',      'Cổ Phúc, Báo Đáp',                 7, 'active'),
('Đào Thịnh',    'Đào Thịnh, Vân Hội',               7, 'active'),
('Hòa Cuông',    'Hòa Cuông, Minh Quán',             7, 'active'),
('Quy Mông',     'Quy Mông, Hưng Khánh',             7, 'active'),
('Kiên Thành',   'Kiên Thành, Việt Cường',           7, 'active'),
('Hồng Ca',      'Hồng Ca, Hưng Thịnh',              7, 'active'),
('Y Can',        'Y Can, Lương Thịnh',                7, 'active'),
('Tân Đồng',     'Tân Đồng',                          7, 'active'),

-- Huyện Văn Chấn (Yên Bái cũ)
('Sơn Thịnh',    'Sơn Thịnh',                         7, 'active'),
('Đại Lịch',     'Đại Lịch, Phù Nham',               7, 'active'),
('Thượng Bằng La','Thượng Bằng La, Minh An',          7, 'active'),
('Nghĩa Sơn',    'Nghĩa Sơn, Suối Giàng',            7, 'active'),
('Sùng Đô',      'Sùng Đô, Nậm Lành',               7, 'active'),
('An Lương',     'An Lương, Sơn Lương',               7, 'active'),
('Nậm Búng',     'Nậm Búng, Hạnh Sơn',               7, 'active'),
('Gia Hội',      'Gia Hội, Phúc Sơn VC',             7, 'active'),
('Cát Thịnh',    'Cát Thịnh, Tú Lệ',                 7, 'active'),
('Nậm Mười',     'Nậm Mười, Chấn Thịnh',             7, 'active'),

-- Huyện Mù Cang Chải (Yên Bái cũ)
('Mù Cang Chải', 'Mù Cang Chải',                      7, 'active'),
('Hồ Bốn',       'Hồ Bốn, Mồ Dề',                    7, 'active'),
('Chế Cu Nha',   'Chế Cu Nha, La Pán Tẩn MCC',       7, 'active'),
('Kim Nọi',      'Kim Nọi, Nậm Có',                   7, 'active'),
('Nậm Khắt',     'Nậm Khắt, Púng Luông',             7, 'active'),
('Cao Phạ',      'Cao Phạ, Khao Mang',               7, 'active'),
('Dế Xu Phình',  'Dế Xu Phình, Chế Tạo',            7, 'active'),

-- Huyện Văn Yên (Yên Bái cũ)
('Mậu A',        'Mậu A',                              7, 'active'),
('Châu Quế Hạ',  'Châu Quế Hạ, Châu Quế Thượng',    7, 'active'),
('Lang Thíp',    'Lang Thíp, An Bình VY',             7, 'active'),
('Viễn Sơn',     'Viễn Sơn, Đại Phác',               7, 'active'),
('Đông Cuông',   'Đông Cuông, Yên Hưng',             7, 'active'),
('Phong Dụ Hạ',  'Phong Dụ Hạ, Đông An',             7, 'active'),
('Phong Dụ Thượng','Phong Dụ Thượng, Nà Hẩu',        7, 'active'),
('Lâm Giang',    'Lâm Giang',                          7, 'active'),

-- ============================================================
-- TỈNH THÁI NGUYÊN (gộp Bắc Kạn) (tinh_thanh_id = 8)
-- ============================================================

-- TP. Thái Nguyên (cũ)
('Phan Đình Phùng','Phan Đình Phùng, Trung Thành',   8, 'active'),
('Hoàng Văn Thụ TN','Hoàng Văn Thụ, Quán Triều',    8, 'active'),
('Đồng Quang',   'Đồng Quang, Gia Sàng',             8, 'active'),
('Túc Duyên',    'Túc Duyên, Tân Thịnh',             8, 'active'),
('Tân Long',     'Tân Long, Thịnh Đán',              8, 'active'),
('Cam Giá',      'Cam Giá, Phú Xá',                   8, 'active'),
('Hương Sơn TN', 'Hương Sơn, Tích Lương',            8, 'active'),
('Quyết Thắng TN','Quyết Thắng, Tân Lập TN',        8, 'active'),
('Đồng Bẩm',     'Đồng Bẩm, Huống Thượng',          8, 'active'),
('Phúc Hà',      'Phúc Hà, Cao Ngạn',                8, 'active'),
('Phúc Xuân',    'Phúc Xuân, Phúc Trìu',             8, 'active'),

-- TP. Sông Công (Thái Nguyên cũ)
('Lương Sơn SC', 'Lương Sơn, Cải Đan',               8, 'active'),
('Bách Quang',   'Bách Quang, Bình Sơn',             8, 'active'),
('Vinh Sơn',     'Vinh Sơn, Tân Quang SC',           8, 'active'),

-- TX. Phổ Yên (Thái Nguyên cũ)
('Ba Hàng',      'Ba Hàng, Bãi Bông',                8, 'active'),
('Đắc Sơn',      'Đắc Sơn, Đông Cao',                8, 'active'),
('Hồng Tiến',    'Hồng Tiến, Thuận Thành',           8, 'active'),
('Minh Đức',     'Minh Đức, Nam Tiến',               8, 'active'),
('Phúc Thuận',   'Phúc Thuận, Thành Công PY',        8, 'active'),
('Trung Thành PY','Trung Thành, Tiên Phong',         8, 'active'),
('Vạn Phái',     'Vạn Phái, Tân Hương PY',           8, 'active'),

-- TX. Phổ Yên mở rộng (gộp Đại Từ một phần)
('Tân Phú PY',   'Tân Phú',                           8, 'active'),

-- Huyện Phú Bình (Thái Nguyên cũ)
('Hương Sơn PB', 'Hương Sơn',                         8, 'active'),
('Bảo Lý',       'Bảo Lý, Điềm Thụy',               8, 'active'),
('Dương Thành',  'Dương Thành, Đào Xá',              8, 'active'),
('Lương Phú',    'Lương Phú, Tân Khánh',             8, 'active'),
('Nga My',       'Nga My, Thượng Đình',              8, 'active'),
('Xuân Phương',  'Xuân Phương, Nhã Lộng',            8, 'active'),
('Tân Hòa PB',   'Tân Hòa, Tân Kim',                 8, 'active'),
('Xuân Phương PB','Xuân Phương',                      8, 'active'),

-- Huyện Đại Từ (Thái Nguyên cũ)
('Hùng Sơn',     'Hùng Sơn',                          8, 'active'),
('Quân Chu',     'Quân Chu, Yên Lãng',               8, 'active'),
('Phú Xuyên',    'Phú Xuyên, Phú Thịnh DT',         8, 'active'),
('Cát Nê',       'Cát Nê, Phú Cường',                8, 'active'),
('La Bằng',      'La Bằng, Hoàng Nông',              8, 'active'),
('Phú Lạc',      'Phú Lạc, Tân Thái',               8, 'active'),
('Văn Yên DT',   'Văn Yên, Đức Lương',              8, 'active'),
('Tiên Hội',     'Tiên Hội, Bình Thuận DT',          8, 'active'),
('Minh Tiến DT', 'Minh Tiến, Khôi Kỳ',              8, 'active'),

-- Huyện Định Hóa (Thái Nguyên cũ)
('Chợ Chu',      'Chợ Chu',                           8, 'active'),
('Bộc Nhiêu',    'Bộc Nhiêu, Trung Hội',             8, 'active'),
('Phú Tiến',     'Phú Tiến, Phúc Chu',               8, 'active'),
('Linh Thông',   'Linh Thông, Lam Vỹ',               8, 'active'),
('Bảo Cường',    'Bảo Cường, Tân Dương DH',          8, 'active'),
('Điềm Mặc',     'Điềm Mặc, Phượng Tiến',           8, 'active'),
('Kim Phượng',   'Kim Phượng, Bình Yên DH',          8, 'active'),
('Thanh Định',   'Thanh Định, Sơn Phú DH',           8, 'active'),

-- Huyện Phú Lương (Thái Nguyên cũ)
('Đu',           'Đu',                                 8, 'active'),
('Giang Tiên',   'Giang Tiên, Vô Tranh',             8, 'active'),
('Phủ Lý',       'Phủ Lý, Cổ Lũng',                  8, 'active'),
('Yên Ninh',     'Yên Ninh, Yên Đổ',                 8, 'active'),
('Ôn Lương',     'Ôn Lương, Hợp Thành PL',           8, 'active'),
('Tức Tranh',    'Tức Tranh, Vô Tranh',               8, 'active'),
('Phú Đô',       'Phú Đô',                            8, 'active'),

-- Huyện Võ Nhai (Thái Nguyên cũ)
('Đình Cả',      'Đình Cả',                            8, 'active'),
('Tràng Xá',     'Tràng Xá, Bình Long VN',           8, 'active'),
('La Hiên',      'La Hiên, Lâu Thượng',              8, 'active'),
('Dân Tiến',     'Dân Tiến, Phú Thượng VN',          8, 'active'),
('Cúc Đường',    'Cúc Đường, Nghinh Tường',          8, 'active'),
('Thần Sa',      'Thần Sa, Thượng Nung',              8, 'active'),
('Sảng Mộc',     'Sảng Mộc',                          8, 'active'),

-- Huyện Đồng Hỷ (Thái Nguyên cũ)
('Sông Cầu',     'Sông Cầu, Hóa Thượng',             8, 'active'),
('Trại Cau',     'Trại Cau, Tân Long DH',            8, 'active'),
('Văn Hán',      'Văn Hán, Hóa Trung',               8, 'active'),
('Cây Thị',      'Cây Thị, Linh Sơn',                8, 'active'),
('Nam Hòa DH',   'Nam Hòa, Hợp Tiến',                8, 'active'),
('Minh Lập',     'Minh Lập',                          8, 'active'),
('Quang Sơn DH', 'Quang Sơn',                         8, 'active'),

-- TP. Bắc Kạn (cũ, nay thuộc Thái Nguyên tỉnh mới)
('Sông Cầu BK',  'Sông Cầu, Nguyễn Thị Minh Khai',  8, 'active'),
('Phùng Chí Kiên','Phùng Chí Kiên, Huyền Tụng',      8, 'active'),
('Xuất Hóa',     'Xuất Hóa, Dương Quang',            8, 'active'),
('Nông Thượng',  'Nông Thượng',                       8, 'active'),

-- Huyện Bạch Thông (Bắc Kạn cũ)
('Phủ Thông',    'Phủ Thông',                          8, 'active'),
('Nguyên Phúc',  'Nguyên Phúc, Lục Bình',            8, 'active'),
('Cẩm Giàng',    'Cẩm Giàng, Quân Bình',             8, 'active'),
('Mỹ Thanh',     'Mỹ Thanh, Đôn Phong',              8, 'active'),
('Tú Trĩ',       'Tú Trĩ, Vi Hương',                  8, 'active'),
('Thuần Mang',   'Thuần Mang',                        8, 'active'),

-- Huyện Ba Bể (Bắc Kạn cũ)
('Chợ Rã',       'Chợ Rã',                             8, 'active'),
('Bộc Bố',       'Bộc Bố, Lương Thượng',             8, 'active'),
('Nam Mẫu',      'Nam Mẫu, Hoàng Trĩ',               8, 'active'),
('Cao Thượng',   'Cao Thượng, Phúc Lộc',             8, 'active'),
('Yến Dương',    'Yến Dương, Mỹ Phương',             8, 'active'),
('Thượng Giáo',  'Thượng Giáo, Khang Ninh',          8, 'active'),
('Quảng Khê',    'Quảng Khê, Địa Linh',              8, 'active'),

-- Huyện Chợ Đồn (Bắc Kạn cũ)
('Bằng Lũng',    'Bằng Lũng',                         8, 'active'),
('Phong Huân',   'Phong Huân, Ngọc Phái',            8, 'active'),
('Yên Thịnh CD', 'Yên Thịnh, Bằng Phúc',             8, 'active'),
('Nam Cường BK', 'Nam Cường, Yên Mỹ CD',             8, 'active'),
('Rã Bản',       'Rã Bản, Tân Lập CD',               8, 'active'),
('Quảng Bạch',   'Quảng Bạch, Bình Trung',           8, 'active'),
('Đồng Thắng CD','Đồng Thắng, Lương Bằng',           8, 'active'),
('Yên Phong CD', 'Yên Phong',                          8, 'active'),

-- Huyện Ngân Sơn (Bắc Kạn cũ)
('Nà Phặc',      'Nà Phặc',                            8, 'active'),
('Thượng Ân',    'Thượng Ân, Đức Vân',               8, 'active'),
('Lãng Ngâm',    'Lãng Ngâm, Vân Tùng',              8, 'active'),
('Trung Hòa NS', 'Trung Hòa, Thuần Thủy',             8, 'active'),
('Thượng Quan',  'Thượng Quan',                        8, 'active'),

-- Huyện Chợ Mới (Bắc Kạn cũ)
('Đồng Tâm CM',  'Đồng Tâm',                          8, 'active'),
('Thanh Vận',    'Thanh Vận, Như Cố',                 8, 'active'),
('Nông Hạ',      'Nông Hạ, Tân Sơn',                  8, 'active'),
('Yên Hân',      'Yên Hân, Cao Kỳ',                   8, 'active'),
('Bình Văn',     'Bình Văn, Tân Lập CM',              8, 'active'),
('Yên Cư',       'Yên Cư',                             8, 'active'),

-- Huyện Na Rì (Bắc Kạn cũ)
('Yến Lạc',      'Yến Lạc',                            8, 'active'),
('Kim Hỷ',       'Kim Hỷ, Lương Thượng NR',           8, 'active'),
('Côn Minh',     'Côn Minh, Hữu Thác',               8, 'active'),
('Liêm Thủy',    'Liêm Thủy, Ân Tình',               8, 'active'),
('Dương Sơn',    'Dương Sơn, Kim Lư',                 8, 'active'),
('Văn Minh',     'Văn Minh, Lạng San',               8, 'active'),
('Cư Lễ',        'Cư Lễ',                              8, 'active'),
('Văn Học',      'Văn Học, Xuân Dương',               8, 'active'),
('Đổng Xá',      'Đổng Xá',                            8, 'active'),

-- Huyện Pác Nặm (Bắc Kạn cũ)
('Bằng Thành',   'Bằng Thành',                         8, 'active'),
('Nhạn Môn',     'Nhạn Môn, Cổ Linh',                 8, 'active'),
('Bộc Bố PN',    'Bộc Bố, Cao Tân',                   8, 'active'),
('Giáo Hiệu',    'Giáo Hiệu, Nghiên Loan',            8, 'active'),
('Công Bằng',    'Công Bằng, An Thắng',               8, 'active')

ON CONFLICT (tinh_thanh_id, ten_phuong_xa) DO UPDATE SET
  ten_phuong_xa_cu = EXCLUDED.ten_phuong_xa_cu,
  status           = EXCLUDED.status;
