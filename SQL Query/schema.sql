DROP DATABASE IF EXISTS tutoring_mini;
CREATE DATABASE tutoring_mini;
USE tutoring_mini;

CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE tutors (
    tutor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    qualification VARCHAR(100),
    subject_id INT NOT NULL,
    FOREIGN KEY (subject_id)
        REFERENCES subjects(subject_id)
);


CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    dob DATE,
    phone VARCHAR(15) UNIQUE
);


CREATE TABLE lessons (
    lesson_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    tutor_id INT NOT NULL,
    lesson_date DATETIME NOT NULL,
    status ENUM('Pending', 'Completed', 'Cancelled')
        NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (tutor_id) REFERENCES tutors(tutor_id)
);


CREATE TABLE lesson_reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    lesson_id INT NOT NULL UNIQUE,
    content TEXT NOT NULL,
    feedback TEXT,
    duration_minutes INT NOT NULL,
    fee DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id),
    CHECK (duration_minutes > 0),
    CHECK (fee >= 0)
);



CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    lesson_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME NOT NULL,
    method ENUM('Cash', 'BankTransfer', 'Card') NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id),
    CHECK (amount > 0)
);