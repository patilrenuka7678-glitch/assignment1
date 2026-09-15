create database company101;
use company101;
create table employee (emp_id INT primary key auto_increment,
emp_name VARCHAR(40) not null,
department VARCHAR(45) not null,
salary DECIMAL(10,2),
joining_date DATE not null,
status VARCHAR(25) DEFAULT 'Active');



create table employees_audit (audit_id int primary key auto_increment,
employee_id int,
employee_name VARCHAR(100),
action_type VARCHAR(30),
old_salary DECIMAL(10,2),
new_salary DECIMAL(10,2),
action_date DATETIME);

-- Trigger 1 – BEFORE INSERT
DELIMITER $$
create trigger before_insert_salary
before insert on employee for each row
BEGIN
	if NEW.salary <= 0 then
		signal sqlstate '45000'
        set message_text = 'salary must be greater than 0';
	end if;
end $$
DELIMITER ;

insert into employee (emp_name,department,salary,joining_date) values ('Renuka Patil','IT',-45000,'2026-02-24');
insert into employee (emp_name,department,salary,joining_date) values ('Renuka Patil','IT',-45000,'2026-02-24');
insert into employee (emp_name,department,salary,joining_date) values ('Renuka Patil','IT',45000,'2026-02-24');
select * from employee_audit;

-- Trigger 2 – AFTER INSERT
DELIMITER $$
create trigger after_insert_record
AFTER INSERT on employee for each row
BEGIN
	insert into employees_audit (employee_id,employee_name,action_type,new_salary,action_date) 
    values (NEW.emp_id,NEW.emp_name,'INSERT',NEW.salary,now());
END $$
DELIMITER ;

select * from employees_audit;
SELECT * FROM employee;

DELIMITER $$
create trigger after_update_records
AFTER UPDATE on employee for each row
BEGIN
	insert into employees_audit (employee_id,employee_name,action_type,old_salary,new_salary,action_date) 
    values (NEW.emp_id,NEW.emp_name,'UPDATE',OLD.salary,NEW.salary,now());
END $$
DELIMITER ;

update employee set salary = 55000 where emp_id = 2;

DELIMITER $$
create trigger after_delete_records
AFTER DELETE on employee for each row
BEGIN
	insert into employees_audit (employee_id,employee_name,action_type,old_salary,action_date) 
    values (OLD.emp_id,OLD.emp_name,'DELETE',OLD.salary,now());
END $$
DELIMITER ;

insert into employee (emp_name,department,salary,joining_date,status) values ('Ruhanika patel','Finance',25000,'2022-02-12','Inactive');

delete from employee where emp_id = 3;

