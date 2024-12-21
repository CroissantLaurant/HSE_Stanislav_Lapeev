-- Таблица студентов
CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    group_id INT NOT NULL,
    UNIQUE (first_name, last_name, birth_date, phone, email)
);

-- Таблица преподавателей
CREATE TABLE Teachers (
    teacher_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    UNIQUE (first_name, last_name, birth_date, phone, email)
);

-- Таблица предметов
CREATE TABLE Subjects (
    subject_id SERIAL PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    category VARCHAR(20) NOT NULL CHECK (category IN ('Гуманитарные', 'Математические', 'Естественные')),
    teacher_id INT NOT NULL REFERENCES Teachers(teacher_id)
);

-- Таблица оценок
CREATE TABLE Grades (
    grade_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES Students(student_id),
    subject_id INT NOT NULL REFERENCES Subjects(subject_id),
    grade INT NOT NULL CHECK (grade BETWEEN 1 AND 5),
    grade_date DATE NOT NULL
);

-- Ограничение по количеству предметов для преподавателей в течение учебного года
CREATE OR REPLACE FUNCTION check_teacher_subjects() RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM Subjects
        WHERE teacher_id = NEW.teacher_id AND
              EXTRACT(MONTH FROM CURRENT_DATE) BETWEEN 9 AND 6) > 5 THEN
        RAISE EXCEPTION 'Преподаватель не может вести более 5 предметов в течение учебного года';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_teacher_subjects
BEFORE INSERT OR UPDATE ON Subjects
FOR EACH ROW
EXECUTE FUNCTION check_teacher_subjects();

-- Ограничение по количеству предметов для студентов в течение учебного года
CREATE OR REPLACE FUNCTION student_subject_check() RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM Grades g
        JOIN Subjects s ON g.subject_id = s.subject_id
        WHERE g.student_id = NEW.student_id AND
              EXTRACT(MONTH FROM CURRENT_DATE) BETWEEN 9 AND 6) > 8 THEN
        RAISE EXCEPTION 'Студент не может быть записан более чем на 8 предметов в течение учебного года';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER student_subject_trigger
BEFORE INSERT ON Grades
FOR EACH ROW
EXECUTE FUNCTION student_subject_check();