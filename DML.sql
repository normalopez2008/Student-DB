-- Query for add a new character functionality with colon : character being used to 
-- denote the variables that will have data from the backend programming language

-- CREATE QUERIES

-- Student create
INSERT INTO Students (first_name, last_name, email, gpa, grade)
VALUES(:fname_input, :lname_input, :email_input, :gpaInput, :grade_input);

-- Teacher create
INSERT INTO Teachers (first_name, last_name, email)
VALUES(:fname_input, :lname_input, :email_input);

-- Class create
INSERT INTO Classes (teacher_id, class_subject, class_name, class_start_time)
VALUES(:teacher_from_dropdown_input, :class_subject_input, :class_name_input, :class_start_time_input);

-- Test create
INSERT INTO Tests (class_id, average_grade, test_date)
VALUES(:class_from_dropdown_input, :average_grade_input, :test_date_input);

-- Enrollments create
INSERT INTO Enrollments(student_id, class_id, registration_date)
VALUES(:student_id_from_dropdown_input, :class_id_from_dropdown_input, :registration_date_input);

-- Disciplinary_Incidents
INSERT INTO Disciplinary_Incidents(student_id, class_id, incident_description, discipline_type, discipline_length)
VALUES(:student_from_dropdown_input, :class_from_dropdown_input, :incident_description_input, :discipline_type_input, :discipline_length_input);


-- READ QUERIES

-- Student select
SELECT * FROM Students;

-- Teacher select
SELECT * FROM Teachers;

-- Class select
SELECT * FROM Classes INNER JOIN Teachers ON Classes.teacher_id = Teachers.teacher_id;

-- Test select
SELECT * FROM Tests INNER JOIN Classes ON Tests.class_id = Classes.class_id;

-- Enrollments select
SELECT * FROM Enrollments INNER JOIN Students ON Enrollments.student_id = Students.student_id INNER JOIN Classes ON Enrollments.class_id = Classes.class_id;

-- Disciplinary_Incidents select
SELECT * FROM Disciplinary_Incidents INNER JOIN Students ON Disciplinary_Incidents.student_id = Students.student_id INNER JOIN Classes ON Disciplinary_Incidents.class_id = Classes.class_id;


-- UPDATE QUERIES

-- Student Update
UPDATE Students
    SET first_name = :fname_input, last_name= :lname_input, email = :email_input, gpa= :gpa_input, grade = :grade_input
    WHERE student_id = :student_id_from_the_update_form;

-- Teacher Update
UPDATE Teachers
    SET first_name = :fname_input, last_name= :lname_input, email = :email_input
    WHERE teacher_id = :teacher_id_from_update_form;

-- Class Update
UPDATE Classes
    SET teacher_id = :teacher_from_dropdown_input, class_subject = :class_subject_input, class_name = :class_name_input, class_start_time = :class_start_time_input
    WHERE class_id = :class_id_from_update_form;

-- Test Update
UPDATE Tests
    SET class_id = :class_from_dropdown_input, average_grade = :average_grade_input, test_date = :test_date_input
    WHERE test_id = :test_id_from_update_form;

-- Enrollments Update
UPDATE Enrollments
    SET registration_date = :registration_date_input
    WHERE student_id = :student_id_from_update_form AND class_id = :class_id_from_update_form;

-- Disciplinary_Incidents Update
UPDATE Disciplinary_Incidents
    SET student_id = :student_from_dropdown_input, class_id = :class_from_dropdown_input, incident_description = :incident_description_input, discipline_type = :discipline_type_input, discipline_length = :discipline_length_input
    WHERE incident_id = :incident_id_from_update_form;


-- DELETE QUERIES

-- Student Delete
DELETE FROM Students WHERE student_id = :student_id_from_browser_page;

-- Teacher Delete
DELETE FROM Teachers WHERE teacher_id = :teacher_id_from_browser_page;

-- Class Delete
DELETE FROM Classes WHERE class_id = :class_id_from_browser_page;

-- Test Delete
DELETE FROM Tests WHERE test_id = :test_id_from_browser_page;

-- Enrollments Delete
DELETE FROM Enrollments WHERE student_id = :student_id_from_browser_page AND class_id = :class_id_from_browser_page;

-- Disciplinary_Incidents Delete
DELETE FROM Disciplinary_Incidents WHERE incident_id = :incident_id_from_browser_page;
