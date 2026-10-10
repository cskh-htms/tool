-- Đổi cột geom từ geometry(Point) sang geometry chung để hỗ trợ cả Point và Polygon
ALTER TABLE tai_san_tren_dat ALTER COLUMN geom TYPE geometry USING geom::geometry;
