--câu 1
USE tutoring_mini;
SELECT 
	lesson_id,
    student_id.full_name AS student_name,
    tutor_id.full_name AS tutor_name,
    lesson_date,
    status
FROM lessons
WHERE status = 'Completed'
	AND lesson_date >= '2025-01-01'
	AND lesson_date < '2025-02-01';


--câu 2 
SELECT
    s.subject_id,
    s.name AS subject_name,
    COUNT(l.lesson_id) AS total_lessons
FROM subjects s
LEFT JOIN tutors t USING (subject_id)
LEFT JOIN lessons l ON t.tutor_id = l.tutor_id
    AND l.lesson_date >= '2025-01-01'
    AND l.lesson_date < '2025-04-01'
GROUP BY s.subject_id, s.name
ORDER BY s.subject_id;


--câu 3
SELECT DISTINCT
    s.student_id,
    s.full_name
FROM students s
JOIN lessons l USING (student_id)
LEFT JOIN lesson_reports r USING (lesson_id)
WHERE 
    l.status = 'Completed'
    AND r.report_id IS NULL
ORDER BY s.student_id;


--câu 4
SELECT 
	s.subject_id,
    s.name AS subject_name,
    COALESCE(ROUND(AVG(r.fee),2),0) AS average_fee
FROM subjects s
LEFT JOIN tutors t USING (subject_id)
LEFT JOIN lessons l USING (tutor_id)
LEFT JOIN lesson_reports r USING (lesson_id)
WHERE l.status = 'Completed'
GROUP BY s.subject_id, s.name
ORDER BY s.subject_id;


--câu 5
SELECT 
	t.tutor_id,
    t.full_name,
    COUNT(l.lesson_id) AS total_completed
FROM tutors t
JOIN lessons l USING (tutor_id)
WHERE l.status = 'Completed'
 AND l.lesson_date >= '2025-01-01'
 AND l.lesson_date < '2025-02-01'
GROUP BY t.tutor_id, t.full_name
ORDER BY total_completed DESC, t.tutor_id ASC
LIMIT 3;


--câu 6
SELECT s.student_id, s.full_name, COALESCE(SUM(p.amount), 0) AS total_paid
FROM students s 
LEFT JOIN lessons l USING (student_id)
LEFT JOIN payments p ON l.lesson_id = p.lesson_id
	AND p.payment_date >= '2025-01-01 00:00:00'
    AND p.payment_date <= '2025-12-31 23:59:59'
GROUP BY s.student_id, s.full_name;


--câu 7
SELECT s.student_id, s.full_name
FROM students s
JOIN lessons l USING (student_id)
LEFT JOIN payments p USING (lesson_id)
GROUP BY s.student_id, s.full_name
HAVING COUNT(p.payment_id) = 0;


--câu 8
SELECT s.student_id, s.full_name, COALESCE(SUM(r.fee), 0) AS total_confirmed_fee
FROM students s
LEFT JOIN lessons l ON s.student_id = l.student_id AND l.status = 'Completed'
LEFT JOIN lesson_reports r USING (lesson_id)
GROUP BY s.student_id, s.full_name
ORDER BY total_confirmed_fee DESC, s.student_id ASC;


--câu 9
SELECT t.tutor_id, t.full_name,
	CASE
		WHEN COUNT(l.lesson_id) = 0 THEN null
        ELSE ROUND((SUM(CASE WHEN l.status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0) / COUNT(l.lesson_id), 2)
	END AS cancellation_rate
FROM tutors t
LEFT JOIN lessons l ON t.tutor_id = l.tutor_id
	AND l.lesson_date >= '2025-01-01 00:00:00'
    AND l.lesson_date <= '2025-12-31 23:59:59'
GROUP BY t.tutor_id, t.full_name;


--câu 10
SELECT s.student_id, s.full_name, COUNT(l.lesson_id) AS completed_count
FROM students s
JOIN lessons l ON s.student_id = l.student_id
WHERE l.status = 'Completed'
	AND l.lesson_date >= '2025-01-01 00:00:00'
    AND l.lesson_date <= '2025-12-31 23:59:59'
GROUP BY s.student_id, s.full_name
HAVING completed_count > 3
ORDER BY completed_count DESC;



