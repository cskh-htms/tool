-- Migration: thêm cột geom_giai_toa vào thua_dat
-- Chạy 1 lần trên DB đang có dữ liệu (fresh DB đã có trong import-structure.sql)
ALTER TABLE thua_dat ADD COLUMN IF NOT EXISTS geom_giai_toa geometry(MultiPolygon,4326);
