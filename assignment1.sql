-- ------------ New Assignment ---------------- --

CREATE DATABASE college;
USE college;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50),
    course VARCHAR(50),
    fees DECIMAL(10,2)
);

insert into students (student_name,course,fees) values ('renuka patIl','Data Science',15000);
insert into students (student_name,course,fees) values ('Krishna Patil','Python',16000);

select * from students;

DELIMITER @@
create trigger before_insert_student
BEFORE INSERT on students for each row
BEGIN
	SET NEW.student_name = upper(NEW.student_name);
END @@
DELIMITER ;


-- ------------- QUESTION 2 -------------- --
CREATE TABLE student_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    student_name VARCHAR(50),
    action VARCHAR(50),
    log_date DATETIME
);

insert into students (student_name,course,fees) values ('renuka patIl','Data Science',15000);
insert into students (student_name,course,fees) values ('Rahul Patel','Python',25000);

select * from student_log;

DELIMITER @@
create trigger after_insert_student
AFTER INSERT on students for each row
BEGIN
	insert into student_log (student_id,student_name,action,log_date) values (NEW.student_id,NEW.student_name,'Inserted',now());
END @@
DELIMITER ;
