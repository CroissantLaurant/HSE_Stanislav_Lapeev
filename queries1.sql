-- 1. Вывести список студентов по определённому предмету
SELECT s.first_name, s.last_name
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
JOIN Subjects subj ON g.subject_id = subj.subject_id
WHERE subj.subject_name = 'Название_предмета';

-- 2. Вывести список предметов, которые преподаёт конкретный преподаватель
SELECT subj.subject_name
FROM Subjects subj
JOIN Teachers t ON subj.teacher_id = t.teacher_id
WHERE t.first_name = 'Имя' AND t.last_name = 'Фамилия';

-- 3. Вывести средний балл студента по всем предметам
SELECT s.first_name, s.last_name, AVG(g.grade) AS average_grade
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
GROUP BY s.student_id, s.first_name, s.last_name;

-- 4. Вывести рейтинг преподавателей по средней оценке студентов
SELECT t.first_name, t.last_name, AVG(g.grade) AS average_grade
FROM Teachers t
JOIN Subjects subj ON t.teacher_id = subj.teacher_id
JOIN Grades g ON subj.subject_id = g.subject_id
GROUP BY t.teacher_id, t.first_name, t.last_name
ORDER BY average_grade DESC;

-- 5. Вывести список преподавателей, которые преподавали более 3 предметов за последний год
SELECT t.first_name, t.last_name, COUNT(subj.subject_id) AS subject_count
FROM Teachers t
JOIN Subjects subj ON t.teacher_id = subj.teacher_id
WHERE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM subj.subject_id) <= 1
GROUP BY t.teacher_id, t.first_name, t.last_name
HAVING COUNT(subj.subject_id) > 3;

-- 6. Вывести список студентов, которые имеют средний балл выше 4 по математическим предметам, но ниже 3 по гуманитарным
SELECT s.first_name, s.last_name
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
JOIN Subjects subj ON g.subject_id = subj.subject_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING AVG(CASE WHEN subj.category = 'Математические' THEN g.grade END) > 4
   AND AVG(CASE WHEN subj.category = 'Гуманитарные' THEN g.grade END) < 3;

-- 7. Определить предметы, по которым больше всего двоек в текущем семестре
SELECT subj.subject_name, COUNT(g.grade) AS count_twos
FROM Grades g
JOIN Subjects subj ON g.subject_id = subj.subject_id
WHERE g.grade = 2 AND g.grade_date BETWEEN '2024-01-01' AND '2024-06-30'
GROUP BY subj.subject_name
ORDER BY count_twos DESC
LIMIT 1;

-- 8. Вывести студентов, которые получили высший балл по всем своим экзаменам, и преподавателей, которые вели эти предметы
SELECT s.first_name AS student_first_name, s.last_name AS student_last_name, t.first_name AS teacher_first_name, t.last_name AS teacher_last_name
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
JOIN Subjects subj ON g.subject_id = subj.subject_id
JOIN Teachers t ON subj.teacher_id = t.teacher_id
GROUP BY s.student_id, t.teacher_id, s.first_name, s.last_name, t.first_name, t.last_name
HAVING MIN(g.grade) = 5;

-- 9. Просмотреть изменение среднего балла студента по годам обучения
SELECT s.first_name, s.last_name, EXTRACT(YEAR FROM g.grade_date) AS year, AVG(g.grade) AS average_grade
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
GROUP BY s.student_id, s.first_name, s.last_name, EXTRACT(YEAR FROM g.grade_date)
ORDER BY year;

-- 10. Определить группы, в которых средний балл выше, чем в других, по аналогичным предметам
SELECT g1.group_id, subj.subject_name, AVG(g1.grade) AS group_avg_grade
FROM Grades g1
JOIN Students s1 ON g1.student_id = s1.student_id
JOIN Subjects subj ON g1.subject_id = subj.subject_id
GROUP BY g1.group_id, subj.subject_name
HAVING AVG(g1.grade) > ALL (
    SELECT AVG(g2.grade)
    FROM Grades g2
    JOIN Students s2 ON g2.student_id = s2.student_id
    WHERE g2.subject_id = subj.subject_id AND s2.group_id <> s1.group_id
);

-- 11. Обновить номер телефона преподавателя на основе его Фамилии и Имени
UPDATE Teachers
SET phone = 'Новый_номер'
WHERE first_name = 'Имя' AND last_name = 'Фамилия';

-- 12. Удалить запись о предмете, который больше не преподают (учитывая зависимости)
DELETE FROM Subjects
WHERE subject_id = (SELECT subj.subject_id FROM Subjects subj LEFT JOIN Grades g ON subj.subject_id = g.subject_id WHERE g.subject_id IS NULL);

-- 13. Вставить новую запись об оценке, выставленной студенту по определенному предмету
INSERT INTO Grades (student_id, subject_id, grade, grade_date)
VALUES (1, 1, 5, '2024-01-15');

-- 14. Вставить запись о новом студенте с указанием его данных
INSERT INTO Students (first_name, last_name, birth_date, phone, email, group_id)
VALUES ('Станислав', 'Лапеев', '1995-11-09', '89638835982', 's.a.lapeev@yandex.ru', 3);