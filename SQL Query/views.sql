--v_detail
USE tutoring_mini;

CREATE OR REPLACE VIEW v_detail AS
SELECT 
lessons.lesson_id,
lessons.lesson_date,
lessons.status,
students.full_name AS student_name,
tutors.full_name AS tutor_name,
subjects.name AS subject_name,
lesson_reports.fee
FROM lessons
LEFT JOIN students USING (student_id)
LEFT JOIN tutors USING (tutor_id)
LEFT JOIN subjects USING (subject_id)
LEFT JOIN lesson_reports USING (lesson_id);

SELECT * FROM v_detail

--v_group_summary
CREATE OR REPLACE VIEW v_group_summary AS
SELECT 
subjects.subject_id,
subjects.name AS subject_name,
COUNT(lessons.lesson_id) AS total_lessons,
COUNT(CASE WHEN lessons.status = "Completed" THEN 1 END) AS completed,
COUNT(CASE WHEN lessons.status = "Cancelled" THEN 1 END) AS cancelled,
IFNULL(Sum(lesson_reports.fee),0) AS total_fee
FROM subjects
LEFT JOIN tutors USING (subject_id)
LEFT JOIN lessons USING (tutor_id)
LEFT JOIN lesson_reports USING (lesson_id)
GROUP BY subjects.subject_id, subject_name;

SELECT * FROM v_group_summary;


--v_debt
CREATE OR REPLACE VIEW v_debt AS
SELECT 
    students.student_id,
    students.full_name,
    IFNULL(fee_sub.total_fee, 0) AS total_fee,
    IFNULL(paid_fee.total_paid, 0) AS total_paid,
    IFNULL(fee_sub.total_fee, 0) - IFNULL(paid_fee.total_paid, 0) AS debt
FROM students
LEFT JOIN (
    SELECT lessons.student_id, SUM(lesson_reports.fee) AS total_fee
    FROM lessons
    JOIN lesson_reports USING (lesson_id)
    GROUP BY lessons.student_id
) AS fee_sub USING (student_id)
LEFT JOIN (
    SELECT student_id, SUM(payments.amount) AS total_paid
    FROM lessons
    JOIN payments USING (lesson_id)
    GROUP BY lessons.student_id
)AS paid_fee USING (student_id);

SELECT * FROM v_debt;
















































































































































































































































































































































