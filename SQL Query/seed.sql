-- =====================================================================
-- seed.sql : Dữ liệu mẫu cho CSDL tutoring_mini (Đề 01 - Trung tâm gia sư)
-- Chạy SAU schema.sql
-- Quy mô: subjects 5 | tutors 6 | students 10 | lessons 30 | lesson_reports 22 | payments 24
-- =====================================================================
SET NAMES utf8mb4;
USE tutoring_mini;

-- ---------------------------------------------------------------------
-- 1. subjects (5)
-- ---------------------------------------------------------------------
INSERT INTO subjects (subject_id, name) VALUES
(1, 'Toán'),
(2, 'Vật lý'),
(3, 'Hóa học'),
(4, 'Tiếng Anh'),
(5, 'Ngữ văn');   -- chưa có buổi học nào trong quý I/2025

-- ---------------------------------------------------------------------
-- 2. tutors (6)
-- ---------------------------------------------------------------------
INSERT INTO tutors (tutor_id, full_name, email, qualification, subject_id) VALUES
(1, 'Nguyễn Văn An',   'an.nguyen@tutoring.vn',   'Thạc sĩ Toán học',        1),
(2, 'Trần Thị Bình',   'binh.tran@tutoring.vn',   'Cử nhân Sư phạm Toán',    1),
(3, 'Lê Minh Châu',    'chau.le@tutoring.vn',     'Thạc sĩ Vật lý',          2),
(4, 'Phạm Quốc Dũng',  'dung.pham@tutoring.vn',   'Cử nhân Hóa học',         3),
(5, 'Hoàng Thu Hà',    'ha.hoang@tutoring.vn',    'IELTS 8.0, Cử nhân Anh',  4),
(6, 'Đỗ Thanh Hải',    'hai.do@tutoring.vn',      'Thạc sĩ Ngữ văn',         5);  -- không có buổi học nào trong 2025

-- ---------------------------------------------------------------------
-- 3. students (10)
-- ---------------------------------------------------------------------
INSERT INTO students (student_id, full_name, dob, phone) VALUES
(1,  'Nguyễn Hoàng Anh',  '2008-03-15', '0901000001'),   -- 4 buổi Completed trong 2025
(2,  'Trần Minh Khoa',    '2009-07-22', '0901000002'),   -- 4 buổi Completed trong 2025
(3,  'Lê Thị Lan',        '2008-11-05', '0901000003'),
(4,  'Phạm Gia Bảo',      '2010-01-30', '0901000004'),
(5,  'Vũ Ngọc Mai',       '2009-05-12', '0901000005'),
(6,  'Đặng Quang Huy',    '2007-09-09', '0901000006'),
(7,  'Bùi Thu Trang',     '2008-12-18', '0901000007'),
(8,  'Ngô Đức Thịnh',     '2010-04-27', '0901000008'),
(9,  'Đỗ Khánh Linh',     '2009-02-14', '0901000009'),   -- có buổi Completed, chưa thanh toán
(10, 'Hồ Anh Tuấn',       '2008-08-08', '0901000010');   -- chưa có buổi học nào

-- ---------------------------------------------------------------------
-- 4. lessons (30): 22 Completed, 4 Pending, 4 Cancelled
-- ---------------------------------------------------------------------
INSERT INTO lessons (lesson_id, student_id, tutor_id, lesson_date, status) VALUES
-- Tháng 01/2025
(1,  1, 1, '2025-01-05', 'Completed'),
(2,  1, 1, '2025-01-12', 'Completed'),
(23, 7, 1, '2025-01-15', 'Pending'),
(3,  2, 3, '2025-01-20', 'Completed'),
(4,  3, 4, '2025-01-25', 'Completed'),
(18, 2, 1, '2025-01-28', 'Completed'),
-- Tháng 02-03/2025 (còn lại của quý I)
(19, 3, 3, '2025-02-03', 'Completed'),
(5,  1, 1, '2025-02-09', 'Completed'),
(6,  4, 5, '2025-02-15', 'Cancelled'),
(20, 4, 4, '2025-02-20', 'Completed'),
(21, 5, 5, '2025-03-05', 'Completed'),
(7,  5, 2, '2025-03-10', 'Pending'),
(22, 6, 2, '2025-03-18', 'Cancelled'),
(14, 4, 5, '2025-03-22', 'Completed'),
(17, 9, 3, '2025-03-28', 'Completed'),
-- Ngoài quý I nhưng trong 2025
(8,  1, 2, '2025-04-06', 'Completed'),
(15, 5, 2, '2025-05-18', 'Cancelled'),
(24, 8, 3, '2025-05-25', 'Completed'),
(9,  2, 3, '2025-06-14', 'Completed'),
(25, 2, 4, '2025-07-12', 'Completed'),
(12, 3, 4, '2025-08-10', 'Pending'),
(26, 7, 5, '2025-09-14', 'Completed'),
(16, 6, 5, '2025-10-05', 'Pending'),
(27, 3, 2, '2025-11-02', 'Completed'),
(30, 5, 1, '2025-12-07', 'Completed'),
(28, 6, 3, '2025-12-20', 'Cancelled'),
-- Ngoài năm 2025
(29, 8, 5, '2024-10-10', 'Completed'),
(11, 7, 6, '2024-11-20', 'Completed'),
(10, 6, 5, '2024-12-15', 'Completed'),
(13, 8, 1, '2026-01-10', 'Completed');

-- ---------------------------------------------------------------------
-- 5. lesson_reports (22): đúng 1 báo cáo cho mỗi buổi Completed
-- ---------------------------------------------------------------------
INSERT INTO lesson_reports (report_id, lesson_id, content, feedback, duration_minutes, fee) VALUES
(1,  1,  'Ôn tập hàm số bậc hai',               'Tiếp thu tốt',               60, 200000.00),
(2,  2,  'Phương trình bậc hai và định lý Viet','Cần luyện thêm bài tập',     60, 200000.00),
(3,  3,  'Dao động điều hòa',                    'Nắm vững lý thuyết',         90, 300000.00),
(4,  4,  'Cân bằng phương trình hóa học',        'Cần chú ý tính toán',        60, 220000.00),
(5,  5,  'Bất phương trình',                     'Tiến bộ rõ rệt',             60, 200000.00),
(6,  8,  'Hình học không gian',                  'Cần luyện vẽ hình',          60, 180000.00),
(7,  9,  'Con lắc lò xo',                        'Làm bài nhanh, chính xác',   90, 300000.00),
(8,  10, 'Ngữ pháp thì hiện tại hoàn thành',     'Phát âm tốt',                45, 150000.00),
(9,  11, 'Phân tích tác phẩm văn học',           'Cần mở rộng vốn từ',         60, 170000.00),
(10, 13, 'Đại số tuyến tính cơ bản',             'Hiểu bài',                   60, 200000.00),
(11, 14, 'Luyện nghe IELTS',                     'Tập trung tốt',              60, 250000.00),
(12, 17, 'Định luật bảo toàn năng lượng',        'Cần ôn lại công thức',       60, 190000.00),
(13, 18, 'Đạo hàm và ứng dụng',                  'Tiếp thu nhanh',             60, 200000.00),
(14, 19, 'Sóng cơ học',                          'Cần luyện bài tập định lượng',90, 300000.00),
(15, 20, 'Phản ứng oxi hóa - khử',               'Hiểu bản chất phản ứng',     60, 220000.00),
(16, 21, 'Luyện nói IELTS Part 2',               'Cần tăng độ trôi chảy',      60, 250000.00),
(17, 24, 'Điện từ học',                          'Làm bài tốt',                90, 300000.00),
(18, 25, 'Este và lipit',                        'Tiến bộ',                    60, 220000.00),
(19, 26, 'Viết luận IELTS Task 2',               'Cần đa dạng cấu trúc câu',   60, 250000.00),
(20, 27, 'Tích phân',                            'Cần luyện thêm',             60, 180000.00),
(21, 29, 'Từ vựng chủ đề môi trường',            'Chăm chỉ',                   60, 250000.00),
(22, 30, 'Xác suất cơ bản',                      'Hiểu bài',                   60, 200000.00);

-- ---------------------------------------------------------------------
-- 6. payments (24)
--    - Trả đủ 1 lần : lesson 1, 3, 5, 8, 10, 11, 14, 18, 20, 24, 25, 27, 29, 30
--    - Trả nhiều lần: lesson 2 (đủ), 19 (đủ), 9 (còn nợ)
--    - Còn nợ       : lesson 4 (100000), 9 (100000), 13 (100000), 21 (150000), 26 (150000)
--    - Chưa trả     : lesson 17 (học viên 9)
-- ---------------------------------------------------------------------
INSERT INTO payments (payment_id, lesson_id, amount, payment_date, method) VALUES
(1,  1,  200000.00, '2025-01-06', 'Cash'),
(2,  2,  100000.00, '2025-01-13', 'BankTransfer'),
(3,  2,  100000.00, '2025-01-20', 'Card'),
(4,  3,  300000.00, '2025-01-21', 'Card'),
(5,  4,  120000.00, '2025-01-26', 'Cash'),
(6,  18, 200000.00, '2025-01-29', 'Cash'),
(7,  19, 150000.00, '2025-02-04', 'BankTransfer'),
(8,  5,  200000.00, '2025-02-10', 'BankTransfer'),
(9,  19, 150000.00, '2025-02-18', 'Card'),
(10, 20, 220000.00, '2025-02-21', 'Cash'),
(11, 21, 100000.00, '2025-03-06', 'Card'),
(12, 14, 250000.00, '2025-03-23', 'Cash'),
(13, 8,  180000.00, '2025-04-07', 'Cash'),
(14, 24, 300000.00, '2025-05-26', 'BankTransfer'),
(15, 9,  150000.00, '2025-06-15', 'BankTransfer'),
(16, 9,   50000.00, '2025-07-01', 'Card'),
(17, 25, 220000.00, '2025-07-13', 'Cash'),
(18, 26, 100000.00, '2025-09-15', 'Card'),
(19, 27, 180000.00, '2025-11-03', 'BankTransfer'),
(20, 30, 200000.00, '2025-12-08', 'Card'),
(21, 29, 250000.00, '2024-10-11', 'Cash'),
(22, 11, 170000.00, '2024-11-21', 'Card'),
(23, 10, 150000.00, '2024-12-16', 'Cash'),
(24, 13, 100000.00, '2026-01-11', 'Cash');

-- =====================================================================
-- PHẦN KIỂM TRA DỮ LIỆU (K1-K7: đúng thì trả về 0 dòng)
-- =====================================================================

-- K1. Khóa ngoại: tutors -> subjects
SELECT t.tutor_id FROM tutors t
LEFT JOIN subjects s ON s.subject_id = t.subject_id
WHERE s.subject_id IS NULL;

-- K2. Khóa ngoại: lessons -> students / tutors
SELECT l.lesson_id FROM lessons l
LEFT JOIN students st ON st.student_id = l.student_id
LEFT JOIN tutors tu   ON tu.tutor_id   = l.tutor_id
WHERE st.student_id IS NULL OR tu.tutor_id IS NULL;

-- K3. Khóa ngoại: lesson_reports / payments -> lessons
SELECT r.report_id FROM lesson_reports r
LEFT JOIN lessons l ON l.lesson_id = r.lesson_id WHERE l.lesson_id IS NULL;
SELECT p.payment_id FROM payments p
LEFT JOIN lessons l ON l.lesson_id = p.lesson_id WHERE l.lesson_id IS NULL;

-- K4. Buổi Completed phải có đúng 1 báo cáo
SELECT l.lesson_id, COUNT(r.report_id) AS so_bao_cao
FROM lessons l
LEFT JOIN lesson_reports r ON r.lesson_id = l.lesson_id
WHERE l.status = 'Completed'
GROUP BY l.lesson_id
HAVING COUNT(r.report_id) <> 1;

-- K5. Buổi Pending/Cancelled không được có báo cáo
SELECT l.lesson_id, l.status
FROM lessons l
JOIN lesson_reports r ON r.lesson_id = l.lesson_id
WHERE l.status <> 'Completed';

-- K6. Chỉ thu tiền khi đã có chi phí xác nhận (có báo cáo)
SELECT p.payment_id, p.lesson_id
FROM payments p
LEFT JOIN lesson_reports r ON r.lesson_id = p.lesson_id
WHERE r.report_id IS NULL;

-- K7. Tổng tiền thu không vượt chi phí
SELECT r.lesson_id, r.fee, SUM(p.amount) AS da_thu
FROM lesson_reports r
JOIN payments p ON p.lesson_id = r.lesson_id
GROUP BY r.lesson_id, r.fee
HAVING SUM(p.amount) > r.fee;

-- K8. Quan sát công nợ theo buổi học (không cộng lặp chi phí khi trả nhiều lần)
SELECT r.lesson_id, r.fee,
       COALESCE(SUM(p.amount), 0) AS da_thu,
       r.fee - COALESCE(SUM(p.amount), 0) AS con_no
FROM lesson_reports r
LEFT JOIN payments p ON p.lesson_id = r.lesson_id
GROUP BY r.lesson_id, r.fee
ORDER BY r.lesson_id;


-- ---------------------------------------------------------------------
-- Ví dụ INSERT vi phạm ràng buộc (để trong chú thích để tệp vẫn chạy được)
-- ---------------------------------------------------------------------
-- INSERT INTO lessons (lesson_id, student_id, tutor_id, lesson_date, status)
--   VALUES (99, 1, 1, '2025-01-01', 'Done');                          -- trạng thái không hợp lệ
-- INSERT INTO lesson_reports (report_id, lesson_id, content, feedback, duration_minutes, fee)
--   VALUES (99, 1, 'x', 'y', 60, 100000);                             -- trùng lesson_id (UNIQUE)
-- INSERT INTO lesson_reports (report_id, lesson_id, content, feedback, duration_minutes, fee)
--   VALUES (98, 3, 'x', 'y', 0, 100000);                              -- duration_minutes phải > 0
-- INSERT INTO payments (payment_id, lesson_id, amount, payment_date, method)
--   VALUES (99, 1, 50000, '2025-01-07', 'Cash');                      -- tổng thu vượt chi phí (K7 phát hiện)
-- INSERT INTO payments (payment_id, lesson_id, amount, payment_date, method)
--   VALUES (98, 1, 10000, '2025-01-07', 'Momo');                      -- phương thức không hợp lệ
