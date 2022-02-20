/*
Домашнее задание №1 - 
Выбор и фильтрация данных, запрос SELECT
1. Написать запрос для выбора 
студентов в порядке их регистрации.
*/

SELECT * FROM students
ORDER BY registration_date;

/*
2. Написать запрос для выбора 5
 самых дорогих курсов,
 на которых более 4 студентов,
 и которые длятся более 10 часов.
*/

SELECT name, duration, price, 
students_count
FROM courses
WHERE students_count > 4
AND duration > 10
ORDER BY price DESC
LIMIT 5;


/*
3. Написать один (!) запрос,
 который выведет одновременно 
 список из имен трёх самых молодых студентов,
 имен трёх самых старых учителей и
 названий трёх самых продолжительных курсов.
*/

(SELECT name FROM students ORDER BY age LIMIT 3) UNION
(SELECT name FROM teachers ORDER BY age DESC LIMIT 3)UNION
(SELECT name FROM courses ORDER BY duration DESC LIMIT 3);


/*
Домашнее задание №2 - Функции и выражения, агрегация данных

Написать запрос для выбора среднего возраста всех учителей с зарплатой более 10 000.
*/

SELECT AVG(age) FROM teachers WHERE salary > 10000;

/*
Написать запрос для расчета суммы, сколько будет стоить купить все курсы по дизайну.
*/

SELECT SUM(price) FROM courses WHERE type = "DESIGN";

/*
Написать запрос для расчёта, сколько минут (!) длятся все курсы по программированию.
*/

SELECT SUM(duration)*60 FROM courses WHERE type="PROGRAMMING";

/*
Домашнее задание №3 - Группировка, соединение таблиц (JOIN)
*/

/*
Напишите запрос, который выводит сумму, 
сколько часов должен в итоге проучиться каждый студент
(сумма длительности всех курсов на которые он подписан).
*/

SELECT 
students.name AS student_name,
SUM(courses.duration) AS duration_hours
FROM
students JOIN subscriptions
ON students.id = subscriptions.student_id
JOIN courses ON
courses.id = subscriptions.course_id
GROUP BY students.id
ORDER BY students.name;

/*
Напишите запрос, который посчитает для каждого учителя средний возраст его учеников.
В результате запрос возвращает две колонки: Имя Учителя — Средний Возраст Учеников.
*/


SELECT 
teachers.name AS teacher_name,
AVG(students.age) AS students_avg_age
FROM
teachers JOIN courses ON 
teachers.id = courses.teacher_id
JOIN subscriptions ON
courses.id = subscriptions.course_id
JOIN students ON
students.id = subscriptions.student_id
GROUP BY teachers.id;


/*
Напишите запрос, который выводит среднюю зарплату учителей для каждого типа курса (Дизайн/Программирование/Маркетинг и т.д.).
В результате запрос возвращает две колонки: Тип Курса — Средняя зарплата.
*/

SELECT 
courses.type AS course_type,
AVG(teachers.salary) AS avg_salary
FROM 
teachers JOIN courses ON 
teachers.id = courses.teacher_id
GROUP BY course_type;
