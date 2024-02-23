---which table to use?--
USE fudgemart_v3

--creating required data set--
DROP TABLE IF EXISTS timesheets;
GO

SELECT * INTO timesheets
FROM fudgemart_employees
JOIN fudgemart_employee_timesheets
ON employee_id = timesheet_employee_id;



--\\\\\\QUESTION #1\\\\\\\---
----initial query to be improved by an index --
SELECT   employee_id,
	     employee_firstname,
	     employee_lastname,
	     SUM(timesheet_hourlyrate*timesheet_hours) AS Earnings
FROM     timesheets
GROUP BY employee_id, employee_firstname, employee_lastname;

---nonclustered index --
DROP INDEX IF EXISTS ix_employees_timesheet ON timesheets
GO

CREATE NONCLUSTERED INDEX  ix_employees_timesheet
ON		timesheets(employee_lastname)
INCLUDE (employee_firstname, timesheet_hourlyrate, timesheet_hours)
GO



--\\\\\\QUESTION #2\\\\\\\---
---Querry using index seek (employee_lastname)--
SELECT employee_firstname, SUM(timesheet_hourlyrate * timesheet_hours) AS Earnings
FROM timesheets
WHERE employee_lastname = 'Ladd'
GROUP BY employee_firstname
GO



--\\\\\\QUESTION #3 PART A\\\\\\\---
---query to improve---
SELECT		employee_department, SUM(timesheet_hours) AS Earnings
FROM		timesheets
GROUP BY	employee_department;
GO

--improving single columnstore index---
DROP INDEX IF EXISTS ix_timesheet_dept ON timesheets;
GO

CREATE NONCLUSTERED COLUMNSTORE INDEX ix_timesheet_dept
ON			 timesheets(employee_department)
GO

--calling the columstore index scan
SELECT SUM(timesheet_hours) AS total_hours
FROM   timesheets
WHERE  employee_department = 'Clothing';



--\\\\\\QUESTION #3 PART B\\\\\\\---
--query to improve---
SELECT		employee_jobtitle, AVG(timesheet_hourlyrate) AS Hourly_Rate
FROM		timesheets
GROUP BY	employee_jobtitle;
GO	



--selecting with single columnstore seek--
SELECT	AVG(timesheet_hourlyrate) AS total_hours
FROM	timesheets
WHERE	employee_jobtitle = 'CEO';
GO



--\\\\\\QUESTION #4\\\\\\\---
DROP VIEW IF EXISTS v_employees;
GO

---the view--
CREATE VIEW v_employees
--WITH SCHEMABINDING
AS
	SELECT DISTINCT employee_id, employee_firstname, employee_lastname, employee_jobtitle, employee_department
	FROM timesheets
GO


---index on the view---
DROP INDEX IF EXISTS ix_unique_employees ON timesheets
GO

CREATE UNIQUE CLUSTERED INDEX ix_unique_employees
ON timesheets(employee_id, employee_firstname, employee_lastname, employee_jobtitle, employee_department)
GO







--\\\\\\QUESTION #5\\\\\\\---
--the table---
SELECT	employee_id,
		employee_firstname,
		employee_lastname,
		timesheet_hours,
		employee_hourlywage * timesheet_hours AS Earnings,
		employee_hourlywage AS Avg_hourly_rate
FROM timesheets
FOR JSON AUTO;
GO