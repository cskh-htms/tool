-- Migration: add missing fields
-- Run against existing DB after schema.prisma update

-- thua_dat
ALTER TABLE thua_dat ADD COLUMN IF NOT EXISTS ly_do_thu_hoi VARCHAR(500);
ALTER TABLE thua_dat ADD COLUMN IF NOT EXISTS geom_giai_toa geometry(MultiPolygon, 4326);

-- kiem_ke
ALTER TABLE kiem_ke ADD COLUMN IF NOT EXISTS dien_tich_thuc_do DECIMAL(12,2);
ALTER TABLE kiem_ke ADD COLUMN IF NOT EXISTS so_nhan_khau INTEGER;
ALTER TABLE kiem_ke ADD COLUMN IF NOT EXISTS so_lao_dong INTEGER;
ALTER TABLE kiem_ke ADD COLUMN IF NOT EXISTS tinh_trang_su_dung VARCHAR(255);

-- phuong_an_chi_tiet
ALTER TABLE phuong_an_chi_tiet ADD COLUMN IF NOT EXISTS so_tien_ho_tro_di_chuyen DECIMAL(18,2);
ALTER TABLE phuong_an_chi_tiet ADD COLUMN IF NOT EXISTS so_tien_ho_tro_on_dinh DECIMAL(18,2);
ALTER TABLE phuong_an_chi_tiet ADD COLUMN IF NOT EXISTS so_tien_ho_tro_nghe_nghiep DECIMAL(18,2);

-- ban_giao_mat_bang
ALTER TABLE ban_giao_mat_bang ADD COLUMN IF NOT EXISTS bien_ban_url VARCHAR(1000);

-- Enum: thua_dat_trang_thai - add new values
ALTER TYPE thua_dat_trang_thai ADD VALUE IF NOT EXISTS 'tu_choi';
ALTER TYPE thua_dat_trang_thai ADD VALUE IF NOT EXISTS 'dang_kieu_nai';
ALTER TYPE thua_dat_trang_thai ADD VALUE IF NOT EXISTS 'cuong_che';

-- Enum: phuong_an_trang_thai - add new value
ALTER TYPE phuong_an_trang_thai ADD VALUE IF NOT EXISTS 'da_gui';

-- New table: thong_bao_nguoi_nhan
CREATE TABLE IF NOT EXISTS thong_bao_nguoi_nhan (
  id SERIAL PRIMARY KEY,
  thong_bao_id INTEGER NOT NULL,
  chu_su_dung_id INTEGER NOT NULL,
  da_nhan BOOLEAN NOT NULL DEFAULT FALSE,
  ngay_nhan DATE,
  ghi_chu TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  CONSTRAINT fk_tbnn_thong_bao FOREIGN KEY (thong_bao_id) REFERENCES thong_bao_thu_hoi(id) ON DELETE CASCADE,
  CONSTRAINT fk_tbnn_chu_su_dung FOREIGN KEY (chu_su_dung_id) REFERENCES chu_su_dung(id) ON DELETE CASCADE,
  CONSTRAINT uq_thong_bao_nguoi_nhan UNIQUE (thong_bao_id, chu_su_dung_id)
);
CREATE INDEX IF NOT EXISTS idx_tbnn_thong_bao ON thong_bao_nguoi_nhan(thong_bao_id);
CREATE INDEX IF NOT EXISTS idx_tbnn_chu_su_dung ON thong_bao_nguoi_nhan(chu_su_dung_id);

-- Audit trigger for thong_bao_nguoi_nhan
DROP TRIGGER IF EXISTS trg_audit_thong_bao_nguoi_nhan ON thong_bao_nguoi_nhan;
CREATE TRIGGER trg_audit_thong_bao_nguoi_nhan
AFTER INSERT OR UPDATE OR DELETE ON thong_bao_nguoi_nhan
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();
