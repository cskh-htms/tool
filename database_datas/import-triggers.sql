-- ============================================================
-- GPMB — Audit log tập trung
-- Idempotent: chạy nhiều lần không lỗi
-- PostGIS 3.x required (geometry → jsonb cast via GeoJSON)
-- ============================================================

-- ============================================================
-- 1. BẢNG audit_logs
-- ============================================================
CREATE TABLE IF NOT EXISTS audit_logs (
  id                      BIGSERIAL     PRIMARY KEY,
  table_name              TEXT          NOT NULL,
  record_id               TEXT,
  action_type             TEXT          NOT NULL CHECK (action_type IN ('INSERT','UPDATE','DELETE')),
  action_code             TEXT,
  action_user_id          TEXT,
  action_agent            TEXT,
  action_business         TEXT,
  actor_type              TEXT,
  ip_address              TEXT,
  request_path            TEXT,
  restore_of_action_code  TEXT,
  restore_reason          TEXT,
  old_data                JSONB,
  new_data                JSONB,
  created_at              TIMESTAMPTZ   NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_audit_logs_action_code     ON audit_logs (action_code);
CREATE INDEX IF NOT EXISTS idx_audit_logs_action_user_id  ON audit_logs (action_user_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_action_business ON audit_logs (action_business);
CREATE INDEX IF NOT EXISTS idx_audit_logs_table_record    ON audit_logs (table_name, record_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_created_at      ON audit_logs (created_at);
CREATE INDEX IF NOT EXISTS idx_audit_logs_action_type     ON audit_logs (action_type);

-- ============================================================
-- 2. TRIGGER FUNCTION DÙNG CHUNG
-- Đọc session vars được set bởi setActionContext() trước tx
-- ============================================================
CREATE OR REPLACE FUNCTION audit_log_changes()
RETURNS TRIGGER AS $$
DECLARE
  v_action_code             TEXT;
  v_action_user_id          TEXT;
  v_action_agent            TEXT;
  v_action_business         TEXT;
  v_actor_type              TEXT;
  v_ip_address              TEXT;
  v_request_path            TEXT;
  v_restore_of_action_code  TEXT;
  v_restore_reason          TEXT;
  v_record_id               TEXT;
BEGIN
  v_action_code            := current_setting('audit.action_code',            true);
  v_action_user_id         := current_setting('audit.action_user_id',         true);
  v_action_agent           := current_setting('audit.action_agent',           true);
  v_action_business        := current_setting('audit.action_business',        true);
  v_actor_type             := current_setting('audit.actor_type',             true);
  v_ip_address             := current_setting('audit.ip_address',             true);
  v_request_path           := current_setting('audit.request_path',           true);
  v_restore_of_action_code := current_setting('audit.restore_of_action_code', true);
  v_restore_reason         := current_setting('audit.restore_reason',         true);

  IF v_action_code IS NULL OR v_action_code = '' THEN
    RAISE EXCEPTION '[audit] Missing audit.action_code — bảng: %', TG_TABLE_NAME;
  END IF;
  IF v_action_user_id IS NULL OR v_action_user_id = '' THEN
    RAISE EXCEPTION '[audit] Missing audit.action_user_id — bảng: %', TG_TABLE_NAME;
  END IF;
  IF v_action_business IS NULL OR v_action_business = '' THEN
    RAISE EXCEPTION '[audit] Missing audit.action_business — bảng: %', TG_TABLE_NAME;
  END IF;

  IF TG_OP = 'INSERT' THEN
    v_record_id := (to_jsonb(NEW) ->> 'id');
    INSERT INTO audit_logs (
      table_name, record_id, action_type,
      action_code, action_user_id, action_agent, action_business,
      actor_type, ip_address, request_path,
      restore_of_action_code, restore_reason,
      old_data, new_data
    ) VALUES (
      TG_TABLE_NAME, v_record_id, 'INSERT',
      v_action_code, v_action_user_id, v_action_agent, v_action_business,
      v_actor_type, v_ip_address, v_request_path,
      v_restore_of_action_code, v_restore_reason,
      NULL, to_jsonb(NEW)
    );
    RETURN NEW;
  END IF;

  IF TG_OP = 'UPDATE' THEN
    v_record_id := COALESCE(to_jsonb(NEW) ->> 'id', to_jsonb(OLD) ->> 'id');
    INSERT INTO audit_logs (
      table_name, record_id, action_type,
      action_code, action_user_id, action_agent, action_business,
      actor_type, ip_address, request_path,
      restore_of_action_code, restore_reason,
      old_data, new_data
    ) VALUES (
      TG_TABLE_NAME, v_record_id, 'UPDATE',
      v_action_code, v_action_user_id, v_action_agent, v_action_business,
      v_actor_type, v_ip_address, v_request_path,
      v_restore_of_action_code, v_restore_reason,
      to_jsonb(OLD), to_jsonb(NEW)
    );
    RETURN NEW;
  END IF;

  IF TG_OP = 'DELETE' THEN
    v_record_id := (to_jsonb(OLD) ->> 'id');
    INSERT INTO audit_logs (
      table_name, record_id, action_type,
      action_code, action_user_id, action_agent, action_business,
      actor_type, ip_address, request_path,
      restore_of_action_code, restore_reason,
      old_data, new_data
    ) VALUES (
      TG_TABLE_NAME, v_record_id, 'DELETE',
      v_action_code, v_action_user_id, v_action_agent, v_action_business,
      v_actor_type, v_ip_address, v_request_path,
      v_restore_of_action_code, v_restore_reason,
      to_jsonb(OLD), NULL
    );
    RETURN OLD;
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- ============================================================
-- 3. GẮN TRIGGER VÀO CÁC BẢNG GPMB
-- ============================================================

DROP TRIGGER IF EXISTS trg_audit_du_an ON du_an;
CREATE TRIGGER trg_audit_du_an
AFTER INSERT OR UPDATE OR DELETE ON du_an
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_du_an_don_vi ON du_an_don_vi;
CREATE TRIGGER trg_audit_du_an_don_vi
AFTER INSERT OR UPDATE OR DELETE ON du_an_don_vi
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_can_bo ON can_bo;
CREATE TRIGGER trg_audit_can_bo
AFTER INSERT OR UPDATE OR DELETE ON can_bo
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_don_gia ON don_gia;
CREATE TRIGGER trg_audit_don_gia
AFTER INSERT OR UPDATE OR DELETE ON don_gia
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_nguyen_tac_boi_thuong ON nguyen_tac_boi_thuong;
CREATE TRIGGER trg_audit_nguyen_tac_boi_thuong
AFTER INSERT OR UPDATE OR DELETE ON nguyen_tac_boi_thuong
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_can_cu_phap_ly ON can_cu_phap_ly;
CREATE TRIGGER trg_audit_can_cu_phap_ly
AFTER INSERT OR UPDATE OR DELETE ON can_cu_phap_ly
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_chu_su_dung ON chu_su_dung;
CREATE TRIGGER trg_audit_chu_su_dung
AFTER INSERT OR UPDATE OR DELETE ON chu_su_dung
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

-- thua_dat có geometry — PostGIS 3.x tự cast geom → GeoJSON trong to_jsonb()
DROP TRIGGER IF EXISTS trg_audit_thua_dat ON thua_dat;
CREATE TRIGGER trg_audit_thua_dat
AFTER INSERT OR UPDATE OR DELETE ON thua_dat
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

-- tai_san_tren_dat có geometry (Point)
DROP TRIGGER IF EXISTS trg_audit_tai_san_tren_dat ON tai_san_tren_dat;
CREATE TRIGGER trg_audit_tai_san_tren_dat
AFTER INSERT OR UPDATE OR DELETE ON tai_san_tren_dat
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_ke_hoach_thu_hoi ON ke_hoach_thu_hoi;
CREATE TRIGGER trg_audit_ke_hoach_thu_hoi
AFTER INSERT OR UPDATE OR DELETE ON ke_hoach_thu_hoi
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_hop_nguoi_co_dat ON hop_nguoi_co_dat;
CREATE TRIGGER trg_audit_hop_nguoi_co_dat
AFTER INSERT OR UPDATE OR DELETE ON hop_nguoi_co_dat
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_thong_bao_thu_hoi ON thong_bao_thu_hoi;
CREATE TRIGGER trg_audit_thong_bao_thu_hoi
AFTER INSERT OR UPDATE OR DELETE ON thong_bao_thu_hoi
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_kiem_ke ON kiem_ke;
CREATE TRIGGER trg_audit_kiem_ke
AFTER INSERT OR UPDATE OR DELETE ON kiem_ke
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_xet_phap_ly ON xet_phap_ly;
CREATE TRIGGER trg_audit_xet_phap_ly
AFTER INSERT OR UPDATE OR DELETE ON xet_phap_ly
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_phuong_an ON phuong_an;
CREATE TRIGGER trg_audit_phuong_an
AFTER INSERT OR UPDATE OR DELETE ON phuong_an
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_phuong_an_chi_tiet ON phuong_an_chi_tiet;
CREATE TRIGGER trg_audit_phuong_an_chi_tiet
AFTER INSERT OR UPDATE OR DELETE ON phuong_an_chi_tiet
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_niem_yet ON niem_yet;
CREATE TRIGGER trg_audit_niem_yet
AFTER INSERT OR UPDATE OR DELETE ON niem_yet
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_y_kien_phuong_an ON y_kien_phuong_an;
CREATE TRIGGER trg_audit_y_kien_phuong_an
AFTER INSERT OR UPDATE OR DELETE ON y_kien_phuong_an
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_tham_dinh_phuong_an ON tham_dinh_phuong_an;
CREATE TRIGGER trg_audit_tham_dinh_phuong_an
AFTER INSERT OR UPDATE OR DELETE ON tham_dinh_phuong_an
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_phe_duyet_phuong_an ON phe_duyet_phuong_an;
CREATE TRIGGER trg_audit_phe_duyet_phuong_an
AFTER INSERT OR UPDATE OR DELETE ON phe_duyet_phuong_an
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_gui_phuong_an ON gui_phuong_an;
CREATE TRIGGER trg_audit_gui_phuong_an
AFTER INSERT OR UPDATE OR DELETE ON gui_phuong_an
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_boi_thuong ON boi_thuong;
CREATE TRIGGER trg_audit_boi_thuong
AFTER INSERT OR UPDATE OR DELETE ON boi_thuong
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_ban_giao_mat_bang ON ban_giao_mat_bang;
CREATE TRIGGER trg_audit_ban_giao_mat_bang
AFTER INSERT OR UPDATE OR DELETE ON ban_giao_mat_bang
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_tai_dinh_cu ON tai_dinh_cu;
CREATE TRIGGER trg_audit_tai_dinh_cu
AFTER INSERT OR UPDATE OR DELETE ON tai_dinh_cu
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_gis_layer ON gis_layer;
CREATE TRIGGER trg_audit_gis_layer
AFTER INSERT OR UPDATE OR DELETE ON gis_layer
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_flycam_anh ON flycam_anh;
CREATE TRIGGER trg_audit_flycam_anh
AFTER INSERT OR UPDATE OR DELETE ON flycam_anh
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_tai_lieu ON tai_lieu;
CREATE TRIGGER trg_audit_tai_lieu
AFTER INSERT OR UPDATE OR DELETE ON tai_lieu
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();

DROP TRIGGER IF EXISTS trg_audit_thong_bao_nguoi_nhan ON thong_bao_nguoi_nhan;
CREATE TRIGGER trg_audit_thong_bao_nguoi_nhan
AFTER INSERT OR UPDATE OR DELETE ON thong_bao_nguoi_nhan
FOR EACH ROW EXECUTE FUNCTION audit_log_changes();
