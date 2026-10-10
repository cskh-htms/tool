-- ==============================================================
-- import-init.sql
-- Seed dữ liệu người dùng mặc định (5 role)
-- Chạy sau khi import-structure.sql xong
-- ==============================================================

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ── Users ──────────────────────────────────────────────────────
DO $$
DECLARE
  pwd TEXT := crypt('123456', gen_salt('bf', 10));
BEGIN
  INSERT INTO users (user_name, password, role, status, name, created_at, updated_at)
  VALUES
    ('super_admin', pwd, 'super_admin', 'active', 'Super Admin', NOW(), NOW()),
    ('admin',       pwd, 'admin',       'active', 'Admin',       NOW(), NOW()),
    ('can_bo',      pwd, 'can_bo',      'active', 'Cán bộ',      NOW(), NOW()),
    ('thuc_dia',    pwd, 'thuc_dia',    'active', 'Thực địa',    NOW(), NOW()),
    ('nhan_vien',   pwd, 'nhan_vien',   'active', 'Nhân viên',   NOW(), NOW())
  ON CONFLICT (user_name) DO NOTHING;
END;
$$;
