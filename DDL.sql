SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

/*Table structure for table 'Students'*/
CREATE OR REPLACE TABLE Students (
    student_id int NOT NULL AUTO_INCREMENT,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    email varchar(50) NOT NULL UNIQUE,
    gpa float NOT NULL,
    grade int NOT NULL,
    CONSTRAINT full_name UNIQUE(first_name, last_name),
    PRIMARY KEY (student_id)
);

/*Dumping data for table 'Students'*/
INSERT INTO Students (first_name, last_name, email, gpa, grade)
VALUES
("Lucas", "Bradley", "bradleyl@aldine.com", 3.6, 11),
("Dexter", "Ryan", "ryand@aldine.com", 3.0, 10),
("Brooke", "Bridges", "bridgesb@aldine.com", 3.8, 11),
("Paige", "Palmer", "palmerp@aldine.com", 3.1, 12),
("Kai", "Hunter", "hunterk@aldine.com", 2.6, 9),
("Logan", "Baldwin", "baldwinl@aldine.com", 2.8, 12),
("Bailey", "Hayes", "hayesb@aldine.com", 2.4, 12);

/*Table structure for table 'Teachers'*/
CREATE OR REPLACE TABLE Teachers (
    teacher_id int NOT NULL AUTO_INCREMENT,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    email varchar(50) NOT NULL,
    CONSTRAINT full_name UNIQUE(first_name, last_name),
    PRIMARY KEY (teacher_id)
);

/*Dumping data for table 'Teachers'*/
INSERT INTO Teachers (first_name, last_name, email)
VALUES
("Hank", "Kerr", "kerrh@aldine.com"),
("Billy", "Reid", "reidb@aldine.com"),
("Simon", "Clark", "clarks@aldine.com");

/*Table structure for table 'Classes'*/
CREATE OR REPLACE TABLE Classes (
    class_id int NOT NULL AUTO_INCREMENT,
    teacher_id int NOT NULL,
    class_subject varchar(50) NOT NULL,
    class_name varchar(50) NOT NULL UNIQUE,
    class_start_time int NOT NULL, -- in military time, i.e. 8:30AM = 0830, 2PM = 1400
    PRIMARY KEY(class_id),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id) ON DELETE CASCADE
);

/*Dumping data for table 'Classes'*/
INSERT INTO Classes (teacher_id, class_subject, class_name, class_start_time)
VALUES
((SELECT teacher_id from Teachers where first_name = "Hank" and last_name = "Kerr"), "Math", "Algebra 2", 0830),
((SELECT teacher_id from Teachers where first_name = "Hank" and last_name = "Kerr"), "Math", "Algebra 1", 1000),
((SELECT teacher_id from Teachers where first_name = "Billy" and last_name = "Reid"), "English", "Language Arts 12", 1200),
((SELECT teacher_id from Teachers where first_name = "Simon" and last_name = "Clark"), "Science", "Physics 1", 1400);

/*Table structure for table 'Enrollments'*/
CREATE OR REPLACE TABLE Enrollments (
    student_id int NOT NULL,
    class_id int NOT NULL,
    registration_date date NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE,
    PRIMARY KEY(class_id, student_id)
);

/*Dumping data for table 'Enrollments'*/
INSERT INTO Enrollments (student_id, class_id, registration_date)
VALUES
((SELECT student_id from Students where first_name = "Lucas" and last_name = "Bradley"), (SELECT class_id from Classes where class_name = "Algebra 2"), "2023-08-26"),
((SELECT student_id from Students where first_name = "Paige" and last_name = "Palmer"), (SELECT class_id from Classes where class_name = "Algebra 2"), "2023-08-26"),
((SELECT student_id from Students where first_name = "Logan" and last_name = "Baldwin"), (SELECT class_id from Classes where class_name = "Algebra 2"), "2023-08-28"),
((SELECT student_id from Students where first_name = "Kai" and last_name = "Hunter"), (SELECT class_id from Classes where class_name = "Algebra 1"), "2023-07-19"),
((SELECT student_id from Students where first_name = "Paige" and last_name = "Palmer"), (SELECT class_id from Classes where class_name = "Language Arts 12"), "2023-08-26"),
((SELECT student_id from Students where first_name = "Logan" and last_name = "Baldwin"), (SELECT class_id from Classes where class_name = "Language Arts 12"), "2023-08-26"),
((SELECT student_id from Students where first_name = "Bailey" and last_name = "Hayes"), (SELECT class_id from Classes where class_name = "Language Arts 12"), "2023-08-26"),
((SELECT student_id from Students where first_name = "Logan" and last_name = "Baldwin"), (SELECT class_id from Classes where class_name = "Physics 1"), "2023-08-28")
;

/*Table structure for table 'Tests'*/
CREATE OR REPLACE TABLE Tests (
    test_id int NOT NULL AUTO_INCREMENT,
    class_id int NOT NULL,
    average_grade float NOT NULL,
    test_date date NOT NULL,
    PRIMARY KEY (test_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE
);

/*Dumping data for table 'Tests'*/
INSERT INTO Tests (class_id, average_grade, test_date)
VALUES
((SELECT class_id from Classes where class_name = "Algebra 2"), 72.2, "2023-11-13"),
((SELECT class_id from Classes where class_name = "Algebra 2"), 68.4, "2023-12-04"),
((SELECT class_id from Classes where class_name = "Physics 1"), 77.3, "2023-11-27"),
((SELECT class_id from Classes where class_name = "Algebra 1"), 74.8, "2023-12-02");

/*Table structure for table 'Disciplinary_Incidents'*/
CREATE OR REPLACE TABLE Disciplinary_Incidents (
    incident_id int NOT NULL AUTO_INCREMENT,
    student_id int NOT NULL,
    class_id int,
    incident_description varchar(255) NOT NULL,
    discipline_type varchar(50) NOT NULL,
    discipline_length int NOT NULL, -- unit: days
    PRIMARY KEY (incident_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id) ON DELETE CASCADE
);

/*Dumping data for table 'Disciplinary_Incidents'*/
INSERT INTO Disciplinary_Incidents (student_id, class_id, incident_description, discipline_type, discipline_length)
VALUES
((SELECT student_id from Students where first_name = "Logan" and last_name = "Baldwin"), (SELECT class_id from Classes where class_name = "Algebra 2"), "Disrupting Class", "Afterschool Detention", 2),
((SELECT student_id from Students where first_name = "Bailey" and last_name = "Hayes"), (SELECT class_id from Classes where class_name = "Language Arts 12"), "Tardy 5 Times", "Lunch Detention", 2),
((SELECT student_id from Students where first_name = "Kai" and last_name = "Hunter"), (SELECT class_id from Classes where class_name = "Algebra 1"), "Passing Notes", "Lunch Detention", 1);

SET FOREIGN_KEY_CHECKS=1;
COMMIT;