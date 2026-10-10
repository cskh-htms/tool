-- ============================================================
-- GPMB — Search indexes (pg_trgm + unaccent)
-- Idempotent: chạy nhiều lần không lỗi
-- ============================================================

CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS unaccent;

-- Hàm unaccent IMMUTABLE — bắt buộc để dùng trong GIN index
CREATE OR REPLACE FUNCTION immutable_unaccent(text)
RETURNS text
LANGUAGE sql
IMMUTABLE
PARALLEL SAFE
AS $$
  SELECT public.unaccent($1)
$$;

-- ============================================================
-- tinh_thanh — tìm theo tên tỉnh/thành
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_trgm_tinh_thanh_ten
ON tinh_thanh
USING gin (
  immutable_unaccent(lower(coalesce(ten_tinh_thanh, ''))) gin_trgm_ops
);

-- ============================================================
-- phuong_xa — tìm theo tên phường/xã
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_trgm_phuong_xa_ten
ON phuong_xa
USING gin (
  immutable_unaccent(lower(coalesce(ten_phuong_xa, ''))) gin_trgm_ops
);

-- ============================================================
-- chu_su_dung — tìm theo tên, CCCD, SĐT, địa chỉ
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_trgm_chu_su_dung_search
ON chu_su_dung
USING gin (
  immutable_unaccent(lower(
    coalesce(ten_chu_su_dung, '') || ' ' ||
    coalesce(cccd, '')            || ' ' ||
    coalesce(sdt, '')             || ' ' ||
    coalesce(dia_chi_thuong_tru, '')
  )) gin_trgm_ops
);

-- index riêng cho CCCD (exact lookup)
CREATE INDEX IF NOT EXISTS idx_chu_su_dung_cccd
ON chu_su_dung (cccd)
WHERE cccd IS NOT NULL;

-- ============================================================
-- thua_dat — tìm theo số tờ, số thửa, địa chỉ thửa
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_trgm_thua_dat_search
ON thua_dat
USING gin (
  immutable_unaccent(lower(
    coalesce(so_to_moi, '')       || ' ' ||
    coalesce(so_thua_moi, '')     || ' ' ||
    coalesce(so_to_cu, '')        || ' ' ||
    coalesce(so_thua_cu, '')      || ' ' ||
    coalesce(dia_chi_thua_dat, '')
  )) gin_trgm_ops
);

-- ============================================================
-- du_an — tìm theo tên dự án, chủ đầu tư
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_trgm_du_an_search
ON du_an
USING gin (
  immutable_unaccent(lower(
    coalesce(ten_du_an, '')       || ' ' ||
    coalesce(chu_dau_tu, '')      || ' ' ||
    coalesce(don_vi_trien_khai, '')
  )) gin_trgm_ops
);

-- ============================================================
-- users — tìm theo tên, username
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_trgm_users_search
ON users
USING gin (
  immutable_unaccent(lower(
    coalesce(name, '')      || ' ' ||
    coalesce(user_name, '') || ' ' ||
    coalesce(phone, '')
  )) gin_trgm_ops
);
