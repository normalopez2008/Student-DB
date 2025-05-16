
# Student-DB

Aldine High School is looking to build a database to help keep track of their 500 students. A database driven website will record student information as well as the classes information, tests the students will be taking and the teachers that will be teaching the classes. Aldine High School administration is looking to monitor student schedules and make sure testing is done in each class. This database will
help keep track of the number of students in each class and the teachers assigned to teach the class. Through the design and implementation of this database, administrative tasks will be streamlined and classroom allocations will be managed effectively and efficiently. This centralized database will help this high school to improve their allocation of resources, help enhance their understanding of their academic environment, and keep track of disciplinary incident information.

---

## Database Outline:

**Students:**
An entity that stores data associated with a single student at Aldine High School, the entity contains information about the student including id number, name, email, gpa and year they are in. A student can have multiple classes, tests, and disciplinary incidents associated with them.
● student_id: int, not NULL, primary key
● first_name: varchar, not NULL
● last_name: varchar, not NULL
● full_name: (first_name, last_name), unique
● email: varchar, not NULL, unique
● gpa: float, NULL
● grade: int, not NULL

Relationship: a 1:M relationship with enrollments
Relationship: a M:N relationship with classes
Relationship: a M:N relationship with tests
Relationship: a 1:M relationship with disciplinary incidents

**Teachers:**
An entity that stores data associated with a single teacher at Aldine High School, the entity contains information about the teacher’s name, id number and email. A teacher can teach multiple classes.
● teacher_id: int, not NULL, primary key
● first_name: varchar, not NULL
● last_name: varchar, not NULL
● full_name: (first_name, last_name), unique
● email: varchar, not NULL, unique

Relationship: a 1:M relationship with classes

**Classes:**
An entity that stores data associated with an individual class at Aldine High School, the entity contains the class id, the id of the teacher that teaches the class, the name and subject of the class, and the start time of the class, the start time of the class is saved in military time (i.e. 8:30AM = 0830). A class has multiple students, it can have multiple tests and disciplinary incidents, but will only have one teacher.
● class_id: int, not NULL, primary key
● teacher_id: int, not NULL, foreign key
● class_subject: varchar, not NULL
● class_name: varchar, not NULL UNIQUE
● class_start_time: int, not NULL

Relationship: a 1:M relationship with enrollments
Relationship: a M:N relationship with students
Relationship: a 1:M relationship with teachers
Relationship: a 1:M relationship with tests
Relationship a 1:M relationship with disciplinary incident

**Enrollments:**
An entity that stores data associated with individual enrollments at Aldine High School. The entity contains the id of the student enrolling, the id of the class they are enrolling in, as well as the date they enrolled. Each enrollment only has one student and one class associated with it.
● student_id: int, not NULL, foreign key, co-primary key
● class_id: int, not NULL, foreign key, co-primary key
● registration_date: date, not NULL

Relationship: a 1:M relationship with students
Relationship: a 1:M relationship with classes

**Tests:**
An entity that stores data associated with a test at Aldine High School, the entity contains the test id, the
id of the class the tests is associated with and the average grade on the test. A test belongs to a singular
class and is taken by every student in the class.
● test_id: int, not NULL, primary key
● class_id: int, not NULL, foreign key
● average_grade: int, not NULL
● test_date: date, not NULL

Relationship: a 1:M relationship with classes
Relationship: a M:N relationship with students

**Disciplinary_Incidents:**
An entity that stores data associated with an individual disciplinary incident at Aldine High School, the entity contains the incident id, the id of the student who had the disciplinary incident, class the incident occurred in, as well as the type of incident and the length of discipline. Each disciplinary incident only has one class and one student associated with it.
● incident_id : int, not NULL, primary key
● student_id: int, not NULL, foreign key
● class_id: int, not NULL, foreign key
● incident_description: varchar, not NULL
● discipline_type: varchar, not NULL
● discipline_length: int, not NULL

Relationship: a 1:M relationship with students
Relationship: a 1:M relationship with classes

---

## 🚀 Getting Started

### 📦 Prerequisites

- [Node.js](https://nodejs.org/)
- [MySQL](https://www.mysql.com/)

---

### 📁 Project Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/normalopez2008/Student-DB.git
   cd Student-DB
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Create your `.env` file**
   Copy the example and edit it with your database credentials:
   ```bash
   cp .env.example .env
   ```

4. **Edit `.env` file**
   ```env
   DB_HOST=localhost
   DB_USER=your_mysql_username
   DB_PASSWORD=your_mysql_password
   DB_NAME=your_database_name
   PORT=6464
   ```

---

## 🧱 Database Setup

1. Open MySQL Workbench, phpMyAdmin, or your MySQL terminal.
2. Select your database (same name as in `.env`).
3. Run the following file to set up tables and insert sample data:

```sql
SOURCE DDL.sql;
```

📌 **Note**: `DML.sql` contains SQL query templates with placeholders (like `:fname_input`). These are **not meant to be executed directly**, but are used by the backend routes in the app.

---

## 🖥️ Run the Application

```bash
npm start
```

Visit `http://localhost:6464/` in your browser.

For development with auto-restart:
```bash
npm run dev
```

---

## 📸 Example Data:

**Classes:**

![App Screenshot](Classes.png)

**Disciplinary_Incidents:**

![App Screenshot](discipline.png)

**Enrollments:**

![App Screenshot](enrollments.png)

**Students:**

![App Screenshot](students.png)

**Teachers:**

![App Screenshot](teachers.png)

**Tests:**

![App Screenshot](tests.png)

---

## 👥 Authors

- Jace Bolante
- Norma Lopez
- Tanvi Patel

---
