-- ============================================================
-- AUTO-GENERATED — chạy được nhiều lần (idempotent)
-- DROP SCHEMA public CASCADE → xoá toàn bộ rồi tạo lại
-- ============================================================
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO gpmb_user;
GRANT ALL ON SCHEMA public TO public;

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateExtension
CREATE EXTENSION IF NOT EXISTS "postgis";

-- CreateEnum
CREATE TYPE "user_role" AS ENUM ('super_admin', 'admin', 'can_bo', 'thuc_dia', 'nhan_vien');

-- CreateEnum
CREATE TYPE "user_status" AS ENUM ('active', 'inactive', 'blocked');

-- CreateEnum
CREATE TYPE "tinh_thanh_status" AS ENUM ('active', 'inactive');

-- CreateEnum
CREATE TYPE "phuong_xa_status" AS ENUM ('active', 'inactive');

-- CreateEnum
CREATE TYPE "du_an_trang_thai" AS ENUM ('chuan_bi', 'dang_thuc_hien', 'hoan_thanh', 'tam_dung');

-- CreateEnum
CREATE TYPE "du_an_uu_tien" AS ENUM ('khan_cap', 'cao', 'trung_binh', 'thap');

-- CreateEnum
CREATE TYPE "thua_dat_trang_thai" AS ENUM ('chua_kiem_ke', 'da_kiem_ke', 'da_xet_phap_ly', 'da_co_phuong_an', 'da_thanh_toan', 'da_ban_giao', 'tu_choi', 'dang_kieu_nai', 'cuong_che');

-- CreateEnum
CREATE TYPE "chu_su_dung_loai" AS ENUM ('ho_gia_dinh', 'ca_nhan', 'to_chuc');

-- CreateEnum
CREATE TYPE "phuong_an_trang_thai" AS ENUM ('du_thao', 'tham_dinh', 'da_tham_dinh', 'phe_duyet', 'da_gui');

-- CreateEnum
CREATE TYPE "niem_yet_loai" AS ENUM ('phuong_an', 'quyet_dinh_phe_duyet');

-- CreateEnum
CREATE TYPE "gis_layer_loai" AS ENUM ('tim_duong', 'ranh_gpmb', 'ranh_du_an', 'khac');

-- CreateEnum
CREATE TYPE "tai_san_loai" AS ENUM ('cay_xanh', 'gieng_nuoc', 'nha_o', 'cong_trinh', 'vat_kien_truc', 'khac');

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "user_name" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255),
    "password" TEXT NOT NULL,
    "token_version" INTEGER NOT NULL DEFAULT 1,
    "name" VARCHAR(255),
    "phone" VARCHAR(20),
    "address" TEXT,
    "parent_id" INTEGER,
    "role" "user_role" NOT NULL DEFAULT 'nhan_vien',
    "status" "user_status" NOT NULL DEFAULT 'active',
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "telegram_id" VARCHAR(64),

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "refresh_tokens" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "token" TEXT NOT NULL,
    "user_agent" TEXT,
    "ip_address" TEXT,
    "expires_at" TIMESTAMP(6) NOT NULL,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "refresh_tokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tinh_thanh" (
    "id" SERIAL NOT NULL,
    "ten_tinh_thanh" VARCHAR(255),
    "ten_tinh_thanh_cu" VARCHAR(255),
    "mo_ta" TEXT,
    "status" "tinh_thanh_status" NOT NULL DEFAULT 'active',
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tinh_thanh_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "phuong_xa" (
    "id" SERIAL NOT NULL,
    "ten_phuong_xa" VARCHAR(255),
    "ten_phuong_xa_cu" VARCHAR(255),
    "tinh_thanh_id" INTEGER NOT NULL,
    "status" "phuong_xa_status" NOT NULL DEFAULT 'active',
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "phuong_xa_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chat_message" (
    "id" SERIAL NOT NULL,
    "chat_id" VARCHAR(255) NOT NULL,
    "user_id" VARCHAR(255) NOT NULL,
    "role" VARCHAR(50) NOT NULL,
    "content" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "chat_message_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" BIGSERIAL NOT NULL,
    "table_name" TEXT NOT NULL,
    "record_id" TEXT,
    "action_type" VARCHAR(10) NOT NULL,
    "action_code" TEXT,
    "action_user_id" TEXT,
    "action_agent" TEXT,
    "action_business" TEXT,
    "actor_type" VARCHAR(50),
    "ip_address" TEXT,
    "request_path" TEXT,
    "restore_of_action_code" TEXT,
    "restore_reason" TEXT,
    "old_data" JSONB,
    "new_data" JSONB,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth_event_logs" (
    "id" BIGSERIAL NOT NULL,
    "event_type" TEXT NOT NULL,
    "event_status" TEXT NOT NULL,
    "user_id" INTEGER,
    "user_name" TEXT,
    "role" TEXT,
    "ip_address" TEXT,
    "user_agent" TEXT,
    "reason" TEXT,
    "request_id" TEXT,
    "action_code" TEXT,
    "metadata" JSONB NOT NULL DEFAULT '{}',
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "auth_event_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "du_an" (
    "id" SERIAL NOT NULL,
    "ten_du_an" VARCHAR(500) NOT NULL,
    "mo_ta" TEXT,
    "tinh_thanh_id" INTEGER NOT NULL,
    "chu_dau_tu" VARCHAR(500),
    "don_vi_trien_khai" VARCHAR(500),
    "dien_tich_ha" DECIMAL(12,4),
    "ngay_bat_dau" DATE,
    "ngay_ket_thuc" DATE,
    "trang_thai" "du_an_trang_thai" NOT NULL DEFAULT 'chuan_bi',
    "do_uu_tien" "du_an_uu_tien" NOT NULL DEFAULT 'trung_binh',
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "du_an_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "du_an_don_vi" (
    "id" SERIAL NOT NULL,
    "du_an_id" INTEGER NOT NULL,
    "phuong_xa_id" INTEGER NOT NULL,
    "trang_thai" VARCHAR(20) DEFAULT 'active',
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "du_an_don_vi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "can_bo" (
    "id" SERIAL NOT NULL,
    "du_an_don_vi_id" INTEGER NOT NULL,
    "ho_ten" VARCHAR(255) NOT NULL,
    "chuc_vu" VARCHAR(255),
    "sdt" VARCHAR(20),
    "email" VARCHAR(255),
    "trang_thai" VARCHAR(20) DEFAULT 'active',
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "can_bo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "don_gia" (
    "id" SERIAL NOT NULL,
    "du_an_id" INTEGER NOT NULL,
    "loai_dat" VARCHAR(50) NOT NULL,
    "ten_loai_dat" VARCHAR(255) NOT NULL,
    "don_gia_m2" DECIMAL(18,2) NOT NULL,
    "don_vi_tinh" VARCHAR(20) DEFAULT 'm2',
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "don_gia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "nguyen_tac_boi_thuong" (
    "id" SERIAL NOT NULL,
    "du_an_id" INTEGER NOT NULL,
    "tieu_de" VARCHAR(500) NOT NULL,
    "noi_dung" TEXT NOT NULL,
    "thu_tu" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "nguyen_tac_boi_thuong_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "can_cu_phap_ly" (
    "id" SERIAL NOT NULL,
    "du_an_id" INTEGER NOT NULL,
    "ten_van_ban" VARCHAR(500) NOT NULL,
    "so_hieu" VARCHAR(100),
    "ngay_ban_hanh" DATE,
    "noi_dung" TEXT,
    "file_url" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "can_cu_phap_ly_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chu_su_dung" (
    "id" SERIAL NOT NULL,
    "du_an_id" INTEGER NOT NULL,
    "du_an_don_vi_id" INTEGER NOT NULL,
    "loai" "chu_su_dung_loai" NOT NULL DEFAULT 'ho_gia_dinh',
    "ten_chu_su_dung" VARCHAR(500) NOT NULL,
    "cccd" VARCHAR(20),
    "ngay_cap_cccd" DATE,
    "noi_cap_cccd" VARCHAR(255),
    "dia_chi_thuong_tru" TEXT,
    "sdt" VARCHAR(20),
    "so_tai_khoan" VARCHAR(50),
    "ngan_hang" VARCHAR(255),
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "chu_su_dung_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "thua_dat" (
    "id" SERIAL NOT NULL,
    "du_an_id" INTEGER NOT NULL,
    "du_an_don_vi_id" INTEGER NOT NULL,
    "chu_su_dung_id" INTEGER,
    "so_to_moi" VARCHAR(50),
    "so_to_cu" VARCHAR(50),
    "so_thua_moi" VARCHAR(50),
    "so_thua_cu" VARCHAR(50),
    "dien_tich_m2" DECIMAL(12,2),
    "loai_dat" VARCHAR(20),
    "dien_tich_trong_ranh" DECIMAL(12,2),
    "dien_tich_ngoai_ranh" DECIMAL(12,2),
    "dia_chi_thua_dat" TEXT,
    "ly_do_thu_hoi" VARCHAR(500),
    "geom_giai_toa" geometry(MultiPolygon,4326),
    "geom" geometry(MultiPolygon,4326),
    "trang_thai" "thua_dat_trang_thai" NOT NULL DEFAULT 'chua_kiem_ke',
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "thua_dat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tai_san_tren_dat" (
    "id" SERIAL NOT NULL,
    "thua_dat_id" INTEGER NOT NULL,
    "du_an_id" INTEGER NOT NULL,
    "loai_tai_san" "tai_san_loai" NOT NULL DEFAULT 'khac',
    "ten_tai_san" VARCHAR(200),
    "mo_ta" TEXT,
    "so_luong" INTEGER DEFAULT 1,
    "geom" geometry,
    "hinh_anh_url" TEXT,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tai_san_tren_dat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ke_hoach_thu_hoi" (
    "id" SERIAL NOT NULL,
    "du_an_id" INTEGER NOT NULL,
    "ngay_bat_dau" DATE,
    "ngay_ket_thuc" DATE,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ke_hoach_thu_hoi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "hop_nguoi_co_dat" (
    "id" SERIAL NOT NULL,
    "du_an_id" INTEGER NOT NULL,
    "ngay_hop" DATE,
    "dia_diem" VARCHAR(500),
    "so_nguoi_tham_du" INTEGER,
    "ket_qua" TEXT,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "hop_nguoi_co_dat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "thong_bao_thu_hoi" (
    "id" SERIAL NOT NULL,
    "du_an_don_vi_id" INTEGER NOT NULL,
    "so_thong_bao" VARCHAR(100),
    "ngay_thong_bao" DATE,
    "noi_dung" TEXT,
    "so_ho_dan_nhan" INTEGER,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "thong_bao_thu_hoi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "thong_bao_nguoi_nhan" (
    "id" SERIAL NOT NULL,
    "thong_bao_id" INTEGER NOT NULL,
    "chu_su_dung_id" INTEGER NOT NULL,
    "da_nhan" BOOLEAN NOT NULL DEFAULT false,
    "ngay_nhan" DATE,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "thong_bao_nguoi_nhan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kiem_ke" (
    "id" SERIAL NOT NULL,
    "thua_dat_id" INTEGER NOT NULL,
    "ngay_kiem_ke" DATE,
    "nguoi_kiem_ke" VARCHAR(255),
    "dien_tich_thuc_do" DECIMAL(12,2),
    "so_nhan_khau" INTEGER,
    "so_lao_dong" INTEGER,
    "tinh_trang_su_dung" VARCHAR(255),
    "ket_qua" TEXT,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "kiem_ke_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "xet_phap_ly" (
    "id" SERIAL NOT NULL,
    "thua_dat_id" INTEGER NOT NULL,
    "nguon_goc_dat" VARCHAR(500),
    "ket_qua_xet" TEXT,
    "ngay_xet" DATE,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "xet_phap_ly_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "phuong_an" (
    "id" SERIAL NOT NULL,
    "du_an_don_vi_id" INTEGER NOT NULL,
    "ten_phuong_an" VARCHAR(500) NOT NULL,
    "trang_thai" "phuong_an_trang_thai" NOT NULL DEFAULT 'du_thao',
    "ngay_lap" DATE,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "phuong_an_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "phuong_an_chi_tiet" (
    "id" SERIAL NOT NULL,
    "phuong_an_id" INTEGER NOT NULL,
    "thua_dat_id" INTEGER NOT NULL,
    "so_tien_dat" DECIMAL(18,2),
    "so_tien_tai_san" DECIMAL(18,2),
    "so_tien_ho_tro" DECIMAL(18,2),
    "so_tien_ho_tro_di_chuyen" DECIMAL(18,2),
    "so_tien_ho_tro_on_dinh" DECIMAL(18,2),
    "so_tien_ho_tro_nghe_nghiep" DECIMAL(18,2),
    "tong_so_tien" DECIMAL(18,2),
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "phuong_an_chi_tiet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "niem_yet" (
    "id" SERIAL NOT NULL,
    "du_an_don_vi_id" INTEGER NOT NULL,
    "loai" "niem_yet_loai" NOT NULL DEFAULT 'phuong_an',
    "ngay_bat_dau" DATE,
    "ngay_ket_thuc" DATE,
    "dia_diem" VARCHAR(500),
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "niem_yet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "y_kien_phuong_an" (
    "id" SERIAL NOT NULL,
    "phuong_an_id" INTEGER NOT NULL,
    "nguoi_y_kien" VARCHAR(255),
    "noi_dung_y_kien" TEXT NOT NULL,
    "ngay_y_kien" DATE,
    "ket_qua_xu_ly" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "y_kien_phuong_an_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tham_dinh_phuong_an" (
    "id" SERIAL NOT NULL,
    "phuong_an_id" INTEGER NOT NULL,
    "so_van_ban" VARCHAR(100),
    "ngay_tham_dinh" DATE,
    "ket_qua" TEXT,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tham_dinh_phuong_an_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "phe_duyet_phuong_an" (
    "id" SERIAL NOT NULL,
    "du_an_id" INTEGER NOT NULL,
    "so_quyet_dinh" VARCHAR(100),
    "ngay_quyet_dinh" DATE,
    "noi_dung" TEXT,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "phe_duyet_phuong_an_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gui_phuong_an" (
    "id" SERIAL NOT NULL,
    "chu_su_dung_id" INTEGER NOT NULL,
    "phuong_an_id" INTEGER NOT NULL,
    "ngay_gui" DATE,
    "da_nhan" BOOLEAN NOT NULL DEFAULT false,
    "ngay_nhan" DATE,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "gui_phuong_an_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "boi_thuong" (
    "id" SERIAL NOT NULL,
    "thua_dat_id" INTEGER NOT NULL,
    "so_tien_thuc_tra" DECIMAL(18,2),
    "ngay_thanh_toan" DATE,
    "hinh_thuc_thanh_toan" VARCHAR(100),
    "so_quyet_dinh_thu_hoi" VARCHAR(100),
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "boi_thuong_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ban_giao_mat_bang" (
    "id" SERIAL NOT NULL,
    "thua_dat_id" INTEGER NOT NULL,
    "ngay_ban_giao" DATE,
    "tinh_trang" VARCHAR(255),
    "bien_ban_url" VARCHAR(1000),
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ban_giao_mat_bang_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tai_dinh_cu" (
    "id" SERIAL NOT NULL,
    "chu_su_dung_id" INTEGER NOT NULL,
    "vi_tri_tai_dinh_cu" VARCHAR(500),
    "dien_tich_dat_tai_dinh_cu" DECIMAL(12,2),
    "so_tien_ho_tro" DECIMAL(18,2),
    "ngay_bo_tri" DATE,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tai_dinh_cu_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gis_layer" (
    "id" SERIAL NOT NULL,
    "du_an_id" INTEGER NOT NULL,
    "ten_layer" VARCHAR(100) NOT NULL,
    "loai_layer" "gis_layer_loai" NOT NULL DEFAULT 'khac',
    "geojson" JSONB,
    "kmz_url" TEXT,
    "mau_hien_thi" VARCHAR(20) DEFAULT '#FF0000',
    "do_day_net" INTEGER DEFAULT 2,
    "hien_thi" BOOLEAN NOT NULL DEFAULT true,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "gis_layer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "flycam_anh" (
    "id" SERIAL NOT NULL,
    "du_an_id" INTEGER NOT NULL,
    "ten_anh" VARCHAR(255) NOT NULL,
    "anh_url" TEXT NOT NULL,
    "goc_tay_bac_lon" DECIMAL(12,8) NOT NULL,
    "goc_tay_bac_vi" DECIMAL(12,8) NOT NULL,
    "goc_dong_bac_lon" DECIMAL(12,8) NOT NULL,
    "goc_dong_bac_vi" DECIMAL(12,8) NOT NULL,
    "goc_dong_nam_lon" DECIMAL(12,8) NOT NULL,
    "goc_dong_nam_vi" DECIMAL(12,8) NOT NULL,
    "goc_tay_nam_lon" DECIMAL(12,8) NOT NULL,
    "goc_tay_nam_vi" DECIMAL(12,8) NOT NULL,
    "do_trong_suot" INTEGER NOT NULL DEFAULT 100,
    "thu_tu" INTEGER NOT NULL DEFAULT 0,
    "hien_thi" BOOLEAN NOT NULL DEFAULT true,
    "ghi_chu" TEXT,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "flycam_anh_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tai_lieu" (
    "id" SERIAL NOT NULL,
    "loai_entity" VARCHAR(100) NOT NULL,
    "entity_id" INTEGER NOT NULL,
    "ten_tai_lieu" VARCHAR(500) NOT NULL,
    "mo_ta" TEXT,
    "file_url" TEXT NOT NULL,
    "file_size" INTEGER,
    "file_type" VARCHAR(50),
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tai_lieu_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_user_name_key" ON "users"("user_name");

-- CreateIndex
CREATE INDEX "idx_users_phone" ON "users"("phone");

-- CreateIndex
CREATE INDEX "idx_users_role" ON "users"("role");

-- CreateIndex
CREATE INDEX "idx_users_status" ON "users"("status");

-- CreateIndex
CREATE INDEX "idx_users_parent_id" ON "users"("parent_id");

-- CreateIndex
CREATE UNIQUE INDEX "uq_refresh_tokens_token" ON "refresh_tokens"("token");

-- CreateIndex
CREATE INDEX "idx_refresh_tokens_user" ON "refresh_tokens"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "uq_tinh_thanh_ten" ON "tinh_thanh"("ten_tinh_thanh");

-- CreateIndex
CREATE INDEX "idx_tinh_thanh_ten" ON "tinh_thanh"("ten_tinh_thanh");

-- CreateIndex
CREATE INDEX "idx_phuong_xa_ten" ON "phuong_xa"("ten_phuong_xa");

-- CreateIndex
CREATE INDEX "idx_phuong_xa_tinh" ON "phuong_xa"("tinh_thanh_id");

-- CreateIndex
CREATE UNIQUE INDEX "uq_phuong_xa_tinh_ten" ON "phuong_xa"("tinh_thanh_id", "ten_phuong_xa");

-- CreateIndex
CREATE INDEX "idx_chat_message_chat_user" ON "chat_message"("chat_id", "user_id");

-- CreateIndex
CREATE INDEX "idx_audit_logs_action_code" ON "audit_logs"("action_code");

-- CreateIndex
CREATE INDEX "idx_audit_logs_action_user_id" ON "audit_logs"("action_user_id");

-- CreateIndex
CREATE INDEX "idx_audit_logs_action_business" ON "audit_logs"("action_business");

-- CreateIndex
CREATE INDEX "idx_audit_logs_table_record" ON "audit_logs"("table_name", "record_id");

-- CreateIndex
CREATE INDEX "idx_audit_logs_created_at" ON "audit_logs"("created_at");

-- CreateIndex
CREATE INDEX "idx_audit_logs_action_type" ON "audit_logs"("action_type");

-- CreateIndex
CREATE INDEX "idx_auth_event_logs_action_code" ON "auth_event_logs"("action_code");

-- CreateIndex
CREATE INDEX "idx_auth_event_logs_created_at" ON "auth_event_logs"("created_at");

-- CreateIndex
CREATE INDEX "idx_auth_event_logs_event_type_status" ON "auth_event_logs"("event_type", "event_status");

-- CreateIndex
CREATE INDEX "idx_auth_event_logs_ip_address" ON "auth_event_logs"("ip_address");

-- CreateIndex
CREATE INDEX "idx_auth_event_logs_user_id" ON "auth_event_logs"("user_id");

-- CreateIndex
CREATE INDEX "idx_auth_event_logs_user_name" ON "auth_event_logs"("user_name");

-- CreateIndex
CREATE INDEX "idx_du_an_tinh_thanh" ON "du_an"("tinh_thanh_id");

-- CreateIndex
CREATE INDEX "idx_du_an_trang_thai" ON "du_an"("trang_thai");

-- CreateIndex
CREATE INDEX "idx_du_an_don_vi_du_an" ON "du_an_don_vi"("du_an_id");

-- CreateIndex
CREATE UNIQUE INDEX "uq_du_an_don_vi" ON "du_an_don_vi"("du_an_id", "phuong_xa_id");

-- CreateIndex
CREATE INDEX "idx_can_bo_don_vi" ON "can_bo"("du_an_don_vi_id");

-- CreateIndex
CREATE INDEX "idx_don_gia_du_an" ON "don_gia"("du_an_id");

-- CreateIndex
CREATE INDEX "idx_nguyen_tac_du_an" ON "nguyen_tac_boi_thuong"("du_an_id");

-- CreateIndex
CREATE INDEX "idx_can_cu_phap_ly_du_an" ON "can_cu_phap_ly"("du_an_id");

-- CreateIndex
CREATE INDEX "idx_chu_su_dung_du_an" ON "chu_su_dung"("du_an_id");

-- CreateIndex
CREATE INDEX "idx_chu_su_dung_don_vi" ON "chu_su_dung"("du_an_don_vi_id");

-- CreateIndex
CREATE INDEX "idx_chu_su_dung_cccd" ON "chu_su_dung"("cccd");

-- CreateIndex
CREATE INDEX "idx_thua_dat_du_an" ON "thua_dat"("du_an_id");

-- CreateIndex
CREATE INDEX "idx_thua_dat_don_vi" ON "thua_dat"("du_an_don_vi_id");

-- CreateIndex
CREATE INDEX "idx_thua_dat_chu_su_dung" ON "thua_dat"("chu_su_dung_id");

-- CreateIndex
CREATE INDEX "idx_thua_dat_trang_thai" ON "thua_dat"("trang_thai");

-- CreateIndex
CREATE INDEX "idx_tai_san_tren_dat_thua_dat" ON "tai_san_tren_dat"("thua_dat_id");

-- CreateIndex
CREATE INDEX "idx_tai_san_tren_dat_du_an" ON "tai_san_tren_dat"("du_an_id");

-- CreateIndex
CREATE INDEX "idx_tai_san_tren_dat_loai" ON "tai_san_tren_dat"("loai_tai_san");

-- CreateIndex
CREATE INDEX "idx_ke_hoach_du_an" ON "ke_hoach_thu_hoi"("du_an_id");

-- CreateIndex
CREATE INDEX "idx_hop_nguoi_co_dat_du_an" ON "hop_nguoi_co_dat"("du_an_id");

-- CreateIndex
CREATE INDEX "idx_thong_bao_don_vi" ON "thong_bao_thu_hoi"("du_an_don_vi_id");

-- CreateIndex
CREATE INDEX "idx_tbnn_thong_bao" ON "thong_bao_nguoi_nhan"("thong_bao_id");

-- CreateIndex
CREATE INDEX "idx_tbnn_chu_su_dung" ON "thong_bao_nguoi_nhan"("chu_su_dung_id");

-- CreateIndex
CREATE UNIQUE INDEX "uq_thong_bao_nguoi_nhan" ON "thong_bao_nguoi_nhan"("thong_bao_id", "chu_su_dung_id");

-- CreateIndex
CREATE UNIQUE INDEX "uq_kiem_ke_thua_dat" ON "kiem_ke"("thua_dat_id");

-- CreateIndex
CREATE UNIQUE INDEX "uq_xet_phap_ly_thua_dat" ON "xet_phap_ly"("thua_dat_id");

-- CreateIndex
CREATE INDEX "idx_phuong_an_don_vi" ON "phuong_an"("du_an_don_vi_id");

-- CreateIndex
CREATE INDEX "idx_phuong_an_trang_thai" ON "phuong_an"("trang_thai");

-- CreateIndex
CREATE UNIQUE INDEX "uq_phuong_an_chi_tiet" ON "phuong_an_chi_tiet"("phuong_an_id", "thua_dat_id");

-- CreateIndex
CREATE INDEX "idx_niem_yet_don_vi" ON "niem_yet"("du_an_don_vi_id");

-- CreateIndex
CREATE INDEX "idx_y_kien_phuong_an" ON "y_kien_phuong_an"("phuong_an_id");

-- CreateIndex
CREATE INDEX "idx_tham_dinh_phuong_an" ON "tham_dinh_phuong_an"("phuong_an_id");

-- CreateIndex
CREATE INDEX "idx_phe_duyet_du_an" ON "phe_duyet_phuong_an"("du_an_id");

-- CreateIndex
CREATE UNIQUE INDEX "uq_gui_phuong_an" ON "gui_phuong_an"("chu_su_dung_id", "phuong_an_id");

-- CreateIndex
CREATE UNIQUE INDEX "uq_boi_thuong_thua_dat" ON "boi_thuong"("thua_dat_id");

-- CreateIndex
CREATE UNIQUE INDEX "uq_ban_giao_thua_dat" ON "ban_giao_mat_bang"("thua_dat_id");

-- CreateIndex
CREATE INDEX "idx_tai_dinh_cu_chu_su_dung" ON "tai_dinh_cu"("chu_su_dung_id");

-- CreateIndex
CREATE INDEX "idx_gis_layer_du_an" ON "gis_layer"("du_an_id");

-- CreateIndex
CREATE INDEX "idx_gis_layer_loai" ON "gis_layer"("loai_layer");

-- CreateIndex
CREATE INDEX "idx_flycam_anh_du_an" ON "flycam_anh"("du_an_id");

-- CreateIndex
CREATE INDEX "idx_tai_lieu_entity" ON "tai_lieu"("loai_entity", "entity_id");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "fk_users_parent" FOREIGN KEY ("parent_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "refresh_tokens" ADD CONSTRAINT "fk_refresh_user" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "phuong_xa" ADD CONSTRAINT "fk_phuong_xa_tinh_thanh" FOREIGN KEY ("tinh_thanh_id") REFERENCES "tinh_thanh"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "du_an" ADD CONSTRAINT "fk_du_an_tinh_thanh" FOREIGN KEY ("tinh_thanh_id") REFERENCES "tinh_thanh"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "du_an_don_vi" ADD CONSTRAINT "fk_du_an_don_vi_du_an" FOREIGN KEY ("du_an_id") REFERENCES "du_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "du_an_don_vi" ADD CONSTRAINT "fk_du_an_don_vi_phuong_xa" FOREIGN KEY ("phuong_xa_id") REFERENCES "phuong_xa"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "can_bo" ADD CONSTRAINT "fk_can_bo_don_vi" FOREIGN KEY ("du_an_don_vi_id") REFERENCES "du_an_don_vi"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "don_gia" ADD CONSTRAINT "fk_don_gia_du_an" FOREIGN KEY ("du_an_id") REFERENCES "du_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "nguyen_tac_boi_thuong" ADD CONSTRAINT "fk_nguyen_tac_du_an" FOREIGN KEY ("du_an_id") REFERENCES "du_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "can_cu_phap_ly" ADD CONSTRAINT "fk_can_cu_phap_ly_du_an" FOREIGN KEY ("du_an_id") REFERENCES "du_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "chu_su_dung" ADD CONSTRAINT "fk_chu_su_dung_don_vi" FOREIGN KEY ("du_an_don_vi_id") REFERENCES "du_an_don_vi"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "thua_dat" ADD CONSTRAINT "fk_thua_dat_don_vi" FOREIGN KEY ("du_an_don_vi_id") REFERENCES "du_an_don_vi"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "thua_dat" ADD CONSTRAINT "fk_thua_dat_chu_su_dung" FOREIGN KEY ("chu_su_dung_id") REFERENCES "chu_su_dung"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tai_san_tren_dat" ADD CONSTRAINT "fk_tai_san_tren_dat_thua_dat" FOREIGN KEY ("thua_dat_id") REFERENCES "thua_dat"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ke_hoach_thu_hoi" ADD CONSTRAINT "fk_ke_hoach_du_an" FOREIGN KEY ("du_an_id") REFERENCES "du_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "hop_nguoi_co_dat" ADD CONSTRAINT "fk_hop_nguoi_co_dat_du_an" FOREIGN KEY ("du_an_id") REFERENCES "du_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "thong_bao_thu_hoi" ADD CONSTRAINT "fk_thong_bao_don_vi" FOREIGN KEY ("du_an_don_vi_id") REFERENCES "du_an_don_vi"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "thong_bao_nguoi_nhan" ADD CONSTRAINT "fk_tbnn_thong_bao" FOREIGN KEY ("thong_bao_id") REFERENCES "thong_bao_thu_hoi"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "thong_bao_nguoi_nhan" ADD CONSTRAINT "fk_tbnn_chu_su_dung" FOREIGN KEY ("chu_su_dung_id") REFERENCES "chu_su_dung"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "kiem_ke" ADD CONSTRAINT "fk_kiem_ke_thua_dat" FOREIGN KEY ("thua_dat_id") REFERENCES "thua_dat"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "xet_phap_ly" ADD CONSTRAINT "fk_xet_phap_ly_thua_dat" FOREIGN KEY ("thua_dat_id") REFERENCES "thua_dat"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "phuong_an" ADD CONSTRAINT "fk_phuong_an_don_vi" FOREIGN KEY ("du_an_don_vi_id") REFERENCES "du_an_don_vi"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "phuong_an_chi_tiet" ADD CONSTRAINT "fk_phuong_an_chi_tiet_phuong_an" FOREIGN KEY ("phuong_an_id") REFERENCES "phuong_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "phuong_an_chi_tiet" ADD CONSTRAINT "fk_phuong_an_chi_tiet_thua_dat" FOREIGN KEY ("thua_dat_id") REFERENCES "thua_dat"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "niem_yet" ADD CONSTRAINT "fk_niem_yet_don_vi" FOREIGN KEY ("du_an_don_vi_id") REFERENCES "du_an_don_vi"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "y_kien_phuong_an" ADD CONSTRAINT "fk_y_kien_phuong_an" FOREIGN KEY ("phuong_an_id") REFERENCES "phuong_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tham_dinh_phuong_an" ADD CONSTRAINT "fk_tham_dinh_phuong_an" FOREIGN KEY ("phuong_an_id") REFERENCES "phuong_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "phe_duyet_phuong_an" ADD CONSTRAINT "fk_phe_duyet_du_an" FOREIGN KEY ("du_an_id") REFERENCES "du_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "gui_phuong_an" ADD CONSTRAINT "fk_gui_phuong_an_chu_su_dung" FOREIGN KEY ("chu_su_dung_id") REFERENCES "chu_su_dung"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "gui_phuong_an" ADD CONSTRAINT "fk_gui_phuong_an_phuong_an" FOREIGN KEY ("phuong_an_id") REFERENCES "phuong_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "boi_thuong" ADD CONSTRAINT "fk_boi_thuong_thua_dat" FOREIGN KEY ("thua_dat_id") REFERENCES "thua_dat"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ban_giao_mat_bang" ADD CONSTRAINT "fk_ban_giao_thua_dat" FOREIGN KEY ("thua_dat_id") REFERENCES "thua_dat"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tai_dinh_cu" ADD CONSTRAINT "fk_tai_dinh_cu_chu_su_dung" FOREIGN KEY ("chu_su_dung_id") REFERENCES "chu_su_dung"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "gis_layer" ADD CONSTRAINT "fk_gis_layer_du_an" FOREIGN KEY ("du_an_id") REFERENCES "du_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "flycam_anh" ADD CONSTRAINT "fk_flycam_anh_du_an" FOREIGN KEY ("du_an_id") REFERENCES "du_an"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

