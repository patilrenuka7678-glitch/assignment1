create database new_imp;
use new_imp;

create table students (Stud_id int primary key not null,name varchar(40),attendance varchar(35));

create table attendance (a_id int primary key not null,stud_id int, message varchar(45), foreign key (stud_id) references students (Stud_id));

insert into students values (102,'Renuka',NUll);

select * from students;
select * from attendance;

DELIMITER @@
create trigger after_insert_student
AFTER INSERT on students FOR EACH row
BEGIN
	if NEW.attendance IS NULL THEN 
		INSERT INTO attendance (stud_id,message)
        VALUES (NEW.Stud_id,CONCAT('HI ', NEW.name,' ,please update your attendance'));
	END IF;
END @@
DELIMITER ;


