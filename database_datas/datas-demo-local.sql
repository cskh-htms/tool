--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg110+2)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1.pgdg110+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.audit_logs DISABLE TRIGGER ALL;



ALTER TABLE public.audit_logs ENABLE TRIGGER ALL;

--
-- Data for Name: auth_event_logs; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.auth_event_logs DISABLE TRIGGER ALL;

INSERT INTO public.auth_event_logs VALUES (1, 'refresh', 'failed', NULL, NULL, NULL, '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'INVALID_REFRESH_TOKEN', 'db17890c-682b-41df-b034-be9bbdad64a6', '7797f9aa-0d74-4ed2-9d35-d025de163bc7', '{}', '2026-05-14 05:04:31.897376+00');
INSERT INTO public.auth_event_logs VALUES (2, 'refresh', 'failed', NULL, NULL, NULL, '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'INVALID_REFRESH_TOKEN', '78f754ff-9b57-4fda-8fb8-93b6912361a1', 'e62c1ca7-a7b9-4293-b06b-219f9932c0b7', '{}', '2026-05-14 05:04:34.573423+00');
INSERT INTO public.auth_event_logs VALUES (3, 'login', 'failed', NULL, 'admin', NULL, '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'SERVER_ERROR', 'f5867ca2-1e13-49fd-9efa-b24cb0cc7bd4', '4d5d8faf-9dba-49d7-93e0-8d6d864600e5', '{}', '2026-05-14 05:04:37.822897+00');
INSERT INTO public.auth_event_logs VALUES (4, 'login', 'failed', NULL, 'admin', NULL, '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'SERVER_ERROR', '1d93d9a8-8fac-4197-ba2f-608fad640701', '3de2a4d8-46d3-4eb4-9013-4d5c94b6cb7a', '{}', '2026-05-14 05:04:44.556904+00');
INSERT INTO public.auth_event_logs VALUES (5, 'refresh', 'failed', NULL, NULL, NULL, '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'INVALID_REFRESH_TOKEN', '944dbd59-1707-4d50-9668-3f4957c74097', 'bf003693-f657-4019-9f52-86f89d7a6f3e', '{}', '2026-05-14 05:04:47.48561+00');
INSERT INTO public.auth_event_logs VALUES (6, 'login', 'failed', NULL, 'admin', NULL, '172.21.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'SERVER_ERROR', 'eab1d93d-a676-457a-85ef-14dc230dc8e3', '57dbe95d-b83f-4a1a-9cd6-46847af77629', '{}', '2026-05-14 05:06:07.874634+00');


ALTER TABLE public.auth_event_logs ENABLE TRIGGER ALL;

--
-- Data for Name: tinh_thanh; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.tinh_thanh DISABLE TRIGGER ALL;

INSERT INTO public.tinh_thanh VALUES (1, 'Lâm Đồng', 'Lâm Đồng, Bình Thuận, Đắk Nông', 'Tỉnh Lâm Đồng mới sau khi gộp 3 tỉnh', 'active', '2026-05-14 05:04:16.687846', '2026-05-14 05:04:16.687846');


ALTER TABLE public.tinh_thanh ENABLE TRIGGER ALL;

--
-- Data for Name: du_an; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.du_an DISABLE TRIGGER ALL;



ALTER TABLE public.du_an ENABLE TRIGGER ALL;

--
-- Data for Name: phuong_xa; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.phuong_xa DISABLE TRIGGER ALL;

INSERT INTO public.phuong_xa VALUES (1, 'Lạc Dương', 'Đạ Sar, Đạ Nhim, Đạ Chais', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (2, 'Đơn Dương', 'Thạnh Mỹ, Đạ Ròn, Tu Tra', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (3, 'Ka Đô', 'Lạc Lâm, Ka Đô', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (4, 'Quảng Lập', 'Ka Đơn, Quảng Lập', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (5, 'D''Ran', 'D''Ran, Lạc Xuân', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (6, 'Hiệp Thạnh', 'Hiệp An, Liên Hiệp, Hiệp Thạnh', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (7, 'Đức Trọng', 'Liên Nghĩa, Phú Hội', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (8, 'Tân Hội', 'Tân Thành (Đức Trọng), N''Thôn Hạ, Tân Hội', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (9, 'Tà Hine', 'Ninh Loan, Đà Loan, Tà Hine', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (10, 'Tà Năng', 'Đa Quyn, Tà Năng', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (11, 'Đinh Văn Lâm Hà', 'Bình Thạnh (Đức Trọng), Tân Văn, Đinh Văn', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (12, 'Phú Sơn Lâm Hà', 'Phú Sơn, Đạ Đờn', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (13, 'Nam Hà Lâm Hà', 'Nam Hà, Phi Tô', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (14, 'Nam Ban Lâm Hà', 'Nam Ban, Đông Thanh, Mê Linh, Gia Lâm', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (15, 'Tân Hà Lâm Hà', 'Tân Hà (Lâm Hà), Hoài Đức, Đan Phượng, Liên Hà', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (16, 'Phúc Thọ Lâm Hà', 'Phúc Thọ, Tân Thanh', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (17, 'Đam Rông 1', 'Phi Liêng, Đạ K''Nàng', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (18, 'Đam Rông 2', 'Rô Men, Liêng Srônh', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (19, 'Đam Rông 3', 'Đạ Rsal, Đạ M''Rông', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (20, 'Đam Rông 4', 'Đạ Tông, Đạ Long, Đưng K''Nớ', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (21, 'Di Linh', 'Di Linh, Liên Đầm, Tân Châu, Gung Ré', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (22, 'Hòa Ninh', 'Đinh Trang Hòa, Hòa Trung, Hòa Ninh', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (23, 'Hòa Bắc', 'Hòa Nam, Hòa Bắc', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (24, 'Đinh Trang Thượng', 'Tân Lâm, Tân Thượng, Đinh Trang Thượng', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (25, 'Bảo Thuận', 'Đinh Lạc, Tân Nghĩa, Bảo Thuận', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (26, 'Sơn Điền', 'Gia Bắc, Sơn Điền', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (27, 'Gia Hiệp', 'Tam Bố, Gia Hiệp', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (28, 'Bảo Lâm 1', 'Lộc Thắng, Lộc Quảng, Lộc Ngãi', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (29, 'Bảo Lâm 2', 'Lộc An, Lộc Đức, Tân Lạc', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (30, 'Bảo Lâm 3', 'Lộc Thành, Lộc Nam', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (31, 'Bảo Lâm 4', 'Lộc Phú, Lộc Lâm, B''Lá', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (32, 'Bảo Lâm 5', 'Lộc Bảo, Lộc Bắc', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (33, 'Đạ Huoai', 'Mađaguôi (thị trấn + xã), Đạ Oai', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (34, 'Đạ Huoai 2', 'Đạ M''ri, Hà Lâm', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (35, 'Đạ Tẻh', 'Đạ Tẻh, An Nhơn, Đạ Lây', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (36, 'Đạ Tẻh 2', 'Quảng Trị, Đạ Pal, Đạ Kho', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (37, 'Đạ Tẻh 3', 'Mỹ Đức, Quốc Oai', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (38, 'Cát Tiên', 'Cát Tiên, Nam Ninh, Quảng Ngãi', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (39, 'Cát Tiên 2', 'Phước Cát, Phước Cát 2, Đức Phổ', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (40, 'Cát Tiên 3', 'Gia Viễn, Tiên Hoàng, Đồng Nai Thượng', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (41, 'Vĩnh Hảo', 'Vĩnh Tân, Vĩnh Hảo', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (42, 'Liên Hương', 'Liên Hương, Bình Thạnh (Tuy Phong), Phước Thể, Phú Lạc', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (43, 'Tuy Phong', 'Phan Dũng, một phần Phong Phú', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (44, 'Phan Rí Cửa', 'Phan Rí Cửa, Chí Công, Hòa Minh, phần còn lại của Phong Phú', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (45, 'Bắc Bình', 'Chợ Lầu, Phan Hòa, Phan Hiệp, Phan Rí Thành', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (46, 'Hồng Thái', 'Phan Thanh, Hồng Thái, một phần Hòa Thắng', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (47, 'Hải Ninh', 'Bình An, Phan Điền, Hải Ninh', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (48, 'Phan Sơn', 'Phan Lâm, Phan Sơn', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (49, 'Sông Lũy', 'Phan Tiến, Bình Tân, Sông Lũy', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (50, 'Lương Sơn', 'Lương Sơn, Sông Bình', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (51, 'Hòa Thắng', 'Hồng Phong, phần còn lại của Hòa Thắng', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (52, 'Đông Giang', 'Đông Tiến, Đông Giang', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (53, 'La Dạ', 'Đa Mi, La Dạ', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (54, 'Hàm Thuận Bắc', 'Thuận Hòa, Hàm Trí, Hàm Phú', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (55, 'Hàm Thuận', 'Ma Lâm, Thuận Minh, Hàm Đức', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (56, 'Hồng Sơn', 'Hồng Liêm, Hồng Sơn', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (57, 'Hàm Liêm', 'Hàm Chính, Hàm Liêm', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (58, 'Tuyên Quang', 'Tiến Lợi, Hàm Mỹ', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (59, 'Hàm Thạnh', 'Mỹ Thạnh, Hàm Cần, Hàm Thạnh', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (60, 'Hàm Kiệm', 'Mương Mán, Hàm Cường, Hàm Kiệm', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (61, 'Tân Thành', 'Tân Thành (Hàm Thuận Nam), Thuận Quý, Tân Thuận', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (62, 'Hàm Thuận Nam', 'Thuận Nam, Hàm Minh', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (63, 'Tân Lập', 'Sông Phan, Tân Lập', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (64, 'Tân Minh', 'Tân Minh, Tân Đức, Tân Phúc', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (65, 'Hàm Tân', 'Tân Hà (Hàm Tân), Tân Xuân, Tân Nghĩa', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (66, 'Sơn Mỹ', 'Tân Thắng, Thắng Hải, Sơn Mỹ', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (67, 'Tân Hải', 'Tân Tiến, Tân Hải', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (68, 'Nghị Đức', 'Đức Phú, Nghị Đức', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (69, 'Bắc Ruộng', 'Măng Tố, Bắc Ruộng', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (70, 'Đồng Kho', 'Huy Khiêm, La Ngâu, Đức Bình, Đồng Kho', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (71, 'Tánh Linh', 'Lạc Tánh, Gia An, Đức Thuận', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (72, 'Suối Kiết', 'Gia Huynh, Suối Kiết', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (73, 'Nam Thành', 'Mê Pu, Sùng Nhơn, Đa Kai', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (74, 'Đức Linh', 'Võ Xu, Nam Chính, Vũ Hòa', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (75, 'Hoài Đức', 'Đức Tài, Đức Tín, Đức Hạnh', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (76, 'Trà Tân', 'Tân Hà (Đức Linh), Đông Hà, Trà Tân', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (77, 'Đắk Wil', 'Ea Pô, Đắk Wil', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (78, 'Nam Dong', 'Đắk D''rông, Nam Dong', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (79, 'Cư Jút', 'Ea T''ling, Trúc Sơn, Tâm Thắng, Cư K''nia', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (80, 'Thuận An', 'Đắk Lao, Thuận An', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (81, 'Đức Lập', 'Đắk Mil, Đức Mạnh, Đức Minh', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (82, 'Đắk Mil', 'Đắk Gằn, Đắk N''Drót, Đắk R''La', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (83, 'Đắk Sắk', 'Nam Xuân, Long Sơn, Đắk Sắk', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (84, 'Nam Đà', 'Buôn Choáh, Đắk Sôr, Nam Đà', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (85, 'Krông Nô', 'Tân Thành (Krông Nô), Đắk Drô, Đắk Mâm', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (86, 'Nâm Nung', 'Nâm N''Đir, Nâm Nung', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (87, 'Quảng Phú', 'Đức Xuyên, Đắk Nang, Quảng Phú', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (88, 'Đắk Song', 'Đắk Môl, Đắk Hòa', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (89, 'Đức An', 'Đức An, Đắk N''Drung, Nam Bình', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (90, 'Thuận Hạnh', 'Thuận Hà, Thuận Hạnh', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (91, 'Trường Xuân', 'Nâm N''Jang, Trường Xuân', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (92, 'Tà Đùng', 'Đắk Som, Đắk R''Măng', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (93, 'Quảng Khê', 'Đắk Plao, Quảng Khê', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (94, 'Quảng Tân', 'Đắk Ngo, Quảng Tân', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (95, 'Tuy Đức', 'Quảng Tâm, Đắk R''Tíh, Đắk Búk So', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (96, 'Kiến Đức', 'Kiến Đức, Đạo Nghĩa, Nghĩa Thắng, Kiến Thành', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (97, 'Nhân Cơ', 'Nhân Đạo, Đắk Wer, Nhân Cơ', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (98, 'Quảng Tín', 'Đắk Sin, Hưng Bình, Đắk Ru, Quảng Tín', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (99, 'Phường Xuân Hương - Đà Lạt', 'Phường 1, Phường 2, Phường 3, Phường 4, Phường 10 (Đà Lạt)', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (100, 'Phường Cam Ly - Đà Lạt', 'Phường 5, Phường 6, Tà Nung', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (101, 'Phường Lâm Viên - Đà Lạt', 'Phường 8, Phường 9, Phường 12', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (102, 'Phường Xuân Trường - Đà Lạt', 'Phường 11, Xuân Thọ, Xuân Trường, Trạm Hành', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (103, 'Phường Lang Biang - Đà Lạt', 'Phường 7, Lạc Dương, Lát', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (104, 'Phường 1 - Bảo Lộc', 'Phường 1, Lộc Phát, Lộc Thanh (Bảo Lộc)', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (105, 'Phường 2 - Bảo Lộc', 'Phường 2, Lộc Tân, ĐamBri (Bảo Lộc)', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (106, 'Phường 3 - Bảo Lộc', 'Lộc Tiến, Lộc Châu, Đại Lào (Bảo Lộc)', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (107, 'Phường B''Lao', 'Lộc Sơn, B''Lao, Lộc Nga (Bảo Lộc)', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (108, 'Phường Hàm Thắng', 'Xuân An, Phú Long, Hàm Thắng', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (109, 'Phường Bình Thuận', 'Phú Tài, Phong Nẫm, Hàm Hiệp', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (110, 'Phường Mũi Né', 'Hàm Tiến, Mũi Né, Thiện Nghiệp', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (111, 'Phường Phú Thủy', 'Thanh Hải, Phú Hài, Phú Thủy', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (112, 'Phường Phan Thiết', 'Phú Trinh, Lạc Đạo, Bình Hưng', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (113, 'Phường Tiến Thành', 'Đức Long, Tiến Thành', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (114, 'Phường La Gi', 'Tân An, Bình Tân, Tân Thiện, Tân Bình', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (115, 'Phường Phước Hội', 'Phước Lộc, Phước Hội, Tân Phước', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (116, 'Phường Bắc Gia Nghĩa', 'Quảng Thành, Nghĩa Thành, Nghĩa Đức, Đắk Ha', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (117, 'Phường Nam Gia Nghĩa', 'Nghĩa Phú, Nghĩa Tân, Đắk R''Moan', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (118, 'Phường Đông Gia Nghĩa', 'Nghĩa Trung, Đắk Nia', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (119, 'Đặc khu Phú Quý', 'Long Hải, Ngũ Phụng, Tam Thanh', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (120, 'Đổi tên thành Đạ Huoai 3', 'Bà Gia', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (121, 'Xã Quảng Hòa', 'Giữ nguyên xã Quảng Hòa', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (122, 'Xã Quảng Sơn', 'Giữ nguyên xã Quảng Sơn', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (123, 'Xã Quảng Trực', 'Giữ nguyên xã Quảng Trực', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');
INSERT INTO public.phuong_xa VALUES (124, 'Xã Ninh Gia', 'Giữ nguyên xã Ninh Gia', 1, 'active', '2026-05-14 05:04:16.693675', '2026-05-14 05:04:16.693675');


ALTER TABLE public.phuong_xa ENABLE TRIGGER ALL;

--
-- Data for Name: du_an_don_vi; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.du_an_don_vi DISABLE TRIGGER ALL;



ALTER TABLE public.du_an_don_vi ENABLE TRIGGER ALL;

--
-- Data for Name: chu_su_dung; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.chu_su_dung DISABLE TRIGGER ALL;



ALTER TABLE public.chu_su_dung ENABLE TRIGGER ALL;

--
-- Data for Name: thua_dat; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.thua_dat DISABLE TRIGGER ALL;



ALTER TABLE public.thua_dat ENABLE TRIGGER ALL;

--
-- Data for Name: ban_giao_mat_bang; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.ban_giao_mat_bang DISABLE TRIGGER ALL;



ALTER TABLE public.ban_giao_mat_bang ENABLE TRIGGER ALL;

--
-- Data for Name: boi_thuong; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.boi_thuong DISABLE TRIGGER ALL;



ALTER TABLE public.boi_thuong ENABLE TRIGGER ALL;

--
-- Data for Name: can_bo; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.can_bo DISABLE TRIGGER ALL;



ALTER TABLE public.can_bo ENABLE TRIGGER ALL;

--
-- Data for Name: can_cu_phap_ly; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.can_cu_phap_ly DISABLE TRIGGER ALL;



ALTER TABLE public.can_cu_phap_ly ENABLE TRIGGER ALL;

--
-- Data for Name: chat_message; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.chat_message DISABLE TRIGGER ALL;



ALTER TABLE public.chat_message ENABLE TRIGGER ALL;

--
-- Data for Name: don_gia; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.don_gia DISABLE TRIGGER ALL;



ALTER TABLE public.don_gia ENABLE TRIGGER ALL;

--
-- Data for Name: flycam_anh; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.flycam_anh DISABLE TRIGGER ALL;



ALTER TABLE public.flycam_anh ENABLE TRIGGER ALL;

--
-- Data for Name: gis_layer; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.gis_layer DISABLE TRIGGER ALL;



ALTER TABLE public.gis_layer ENABLE TRIGGER ALL;

--
-- Data for Name: phuong_an; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.phuong_an DISABLE TRIGGER ALL;



ALTER TABLE public.phuong_an ENABLE TRIGGER ALL;

--
-- Data for Name: gui_phuong_an; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.gui_phuong_an DISABLE TRIGGER ALL;



ALTER TABLE public.gui_phuong_an ENABLE TRIGGER ALL;

--
-- Data for Name: hop_nguoi_co_dat; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.hop_nguoi_co_dat DISABLE TRIGGER ALL;



ALTER TABLE public.hop_nguoi_co_dat ENABLE TRIGGER ALL;

--
-- Data for Name: ke_hoach_thu_hoi; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.ke_hoach_thu_hoi DISABLE TRIGGER ALL;



ALTER TABLE public.ke_hoach_thu_hoi ENABLE TRIGGER ALL;

--
-- Data for Name: kiem_ke; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.kiem_ke DISABLE TRIGGER ALL;



ALTER TABLE public.kiem_ke ENABLE TRIGGER ALL;

--
-- Data for Name: nguyen_tac_boi_thuong; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.nguyen_tac_boi_thuong DISABLE TRIGGER ALL;



ALTER TABLE public.nguyen_tac_boi_thuong ENABLE TRIGGER ALL;

--
-- Data for Name: niem_yet; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.niem_yet DISABLE TRIGGER ALL;



ALTER TABLE public.niem_yet ENABLE TRIGGER ALL;

--
-- Data for Name: phe_duyet_phuong_an; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.phe_duyet_phuong_an DISABLE TRIGGER ALL;



ALTER TABLE public.phe_duyet_phuong_an ENABLE TRIGGER ALL;

--
-- Data for Name: phuong_an_chi_tiet; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.phuong_an_chi_tiet DISABLE TRIGGER ALL;



ALTER TABLE public.phuong_an_chi_tiet ENABLE TRIGGER ALL;

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users VALUES (1, 'super_admin', NULL, '$2a$10$uclP13lHKBHEUS/RR2nZOOP1GM5PUPRFmNanPJECEIBiX0YoqC.uW', 1, 'Super Admin', NULL, NULL, NULL, 'super_admin', 'active', '2026-05-14 05:04:16.591214', '2026-05-14 05:04:16.591214', NULL);
INSERT INTO public.users VALUES (2, 'admin', NULL, '$2a$10$uclP13lHKBHEUS/RR2nZOOP1GM5PUPRFmNanPJECEIBiX0YoqC.uW', 1, 'Admin', NULL, NULL, NULL, 'admin', 'active', '2026-05-14 05:04:16.591214', '2026-05-14 05:04:16.591214', NULL);
INSERT INTO public.users VALUES (3, 'ctv', NULL, '$2a$10$uclP13lHKBHEUS/RR2nZOOP1GM5PUPRFmNanPJECEIBiX0YoqC.uW', 1, 'Cộng tác viên', NULL, NULL, NULL, 'ctv', 'active', '2026-05-14 05:04:16.591214', '2026-05-14 05:04:16.591214', NULL);
INSERT INTO public.users VALUES (4, 'tracuu', NULL, '$2a$10$uclP13lHKBHEUS/RR2nZOOP1GM5PUPRFmNanPJECEIBiX0YoqC.uW', 1, 'Tra cứu', NULL, NULL, NULL, 'tracuu', 'active', '2026-05-14 05:04:16.591214', '2026-05-14 05:04:16.591214', NULL);


ALTER TABLE public.users ENABLE TRIGGER ALL;

--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.refresh_tokens DISABLE TRIGGER ALL;



ALTER TABLE public.refresh_tokens ENABLE TRIGGER ALL;

--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.spatial_ref_sys DISABLE TRIGGER ALL;



ALTER TABLE public.spatial_ref_sys ENABLE TRIGGER ALL;

--
-- Data for Name: tai_dinh_cu; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.tai_dinh_cu DISABLE TRIGGER ALL;



ALTER TABLE public.tai_dinh_cu ENABLE TRIGGER ALL;

--
-- Data for Name: tai_lieu; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.tai_lieu DISABLE TRIGGER ALL;



ALTER TABLE public.tai_lieu ENABLE TRIGGER ALL;

--
-- Data for Name: tai_san_tren_dat; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.tai_san_tren_dat DISABLE TRIGGER ALL;



ALTER TABLE public.tai_san_tren_dat ENABLE TRIGGER ALL;

--
-- Data for Name: tham_dinh_phuong_an; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.tham_dinh_phuong_an DISABLE TRIGGER ALL;



ALTER TABLE public.tham_dinh_phuong_an ENABLE TRIGGER ALL;

--
-- Data for Name: thong_bao_thu_hoi; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.thong_bao_thu_hoi DISABLE TRIGGER ALL;



ALTER TABLE public.thong_bao_thu_hoi ENABLE TRIGGER ALL;

--
-- Data for Name: xet_phap_ly; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.xet_phap_ly DISABLE TRIGGER ALL;



ALTER TABLE public.xet_phap_ly ENABLE TRIGGER ALL;

--
-- Data for Name: y_kien_phuong_an; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.y_kien_phuong_an DISABLE TRIGGER ALL;



ALTER TABLE public.y_kien_phuong_an ENABLE TRIGGER ALL;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 1, false);


--
-- Name: auth_event_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_event_logs_id_seq', 33, true);


--
-- Name: ban_giao_mat_bang_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ban_giao_mat_bang_id_seq', 1, false);


--
-- Name: boi_thuong_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.boi_thuong_id_seq', 1, false);


--
-- Name: can_bo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.can_bo_id_seq', 1, false);


--
-- Name: can_cu_phap_ly_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.can_cu_phap_ly_id_seq', 1, false);


--
-- Name: chat_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.chat_message_id_seq', 1, false);


--
-- Name: chu_su_dung_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.chu_su_dung_id_seq', 1, false);


--
-- Name: don_gia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.don_gia_id_seq', 1, false);


--
-- Name: du_an_don_vi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.du_an_don_vi_id_seq', 1, false);


--
-- Name: du_an_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.du_an_id_seq', 1, false);


--
-- Name: flycam_anh_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.flycam_anh_id_seq', 1, false);


--
-- Name: gis_layer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gis_layer_id_seq', 1, false);


--
-- Name: gui_phuong_an_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gui_phuong_an_id_seq', 1, false);


--
-- Name: hop_nguoi_co_dat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.hop_nguoi_co_dat_id_seq', 1, false);


--
-- Name: ke_hoach_thu_hoi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ke_hoach_thu_hoi_id_seq', 1, false);


--
-- Name: kiem_ke_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.kiem_ke_id_seq', 1, false);


--
-- Name: nguyen_tac_boi_thuong_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.nguyen_tac_boi_thuong_id_seq', 1, false);


--
-- Name: niem_yet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.niem_yet_id_seq', 1, false);


--
-- Name: phe_duyet_phuong_an_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.phe_duyet_phuong_an_id_seq', 1, false);


--
-- Name: phuong_an_chi_tiet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.phuong_an_chi_tiet_id_seq', 1, false);


--
-- Name: phuong_an_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.phuong_an_id_seq', 1, false);


--
-- Name: phuong_xa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.phuong_xa_id_seq', 132, true);


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 1, false);


--
-- Name: tai_dinh_cu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tai_dinh_cu_id_seq', 1, false);


--
-- Name: tai_lieu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tai_lieu_id_seq', 1, false);


--
-- Name: tai_san_tren_dat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tai_san_tren_dat_id_seq', 1, false);


--
-- Name: tham_dinh_phuong_an_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tham_dinh_phuong_an_id_seq', 1, false);


--
-- Name: thong_bao_thu_hoi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.thong_bao_thu_hoi_id_seq', 1, false);


--
-- Name: thua_dat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.thua_dat_id_seq', 1, false);


--
-- Name: tinh_thanh_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tinh_thanh_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 33, true);


--
-- Name: xet_phap_ly_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.xet_phap_ly_id_seq', 1, false);


--
-- Name: y_kien_phuong_an_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.y_kien_phuong_an_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

