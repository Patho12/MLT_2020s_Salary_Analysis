USE [MLS Salary]
----

-- Checking to see both tables are in the database --
SELECT * 
FROM salary2022
--
SELECT * 
FROM salary2023
-------------------------


--		1.Salary + Position title + years of experience (Both 2022 and 2023) 
--			Comparing salary vs title vs experience in MLT field 
SELECT 
	salary,
	currency,
	title,
	experience
FROM salary2022
WHERE
	salary is not null
	AND
	experience is not null
	AND 
	experience < 1000
	AND
	title is not null
UNION ALL
SELECT 
	salary,
	currency,
	job_title,
	experience
FROM salary2023
WHERE
	salary is not null
	AND
	experience is not null
	AND 
	job_title is not null
Order by 2,1,3;

------------------------------

--		2.Salary + Hours worked + ShiftDif
--			Comparing salary vs hours worked vs shift differential 
--Data from 2022
SELECT 
	title,
	salary,
	currency,
	hours_worked,
	shift_differential
FROM salary2022
WHERE
	salary is not null
	AND
	hours_worked is not null
	AND
	shift_differential is not null

--Data from 2023 (Doesn't have hours worked)
SELECT 
	job_Title, 
	currency, 
	salary, 
	shift_differential 
FROM salary2023 
WHERE
	salary is not null
	AND
	shift_differential is not null

-- Data from 2022 and 2023 combined
SELECT 
	title, 
	salary, 
	currency, 
	shift_differential
FROM salary2022
WHERE
	salary is not null
	AND
	shift_differential is not null
UNION ALL
SELECT 
	job_title, 
	salary, 
	currency, 
	shift_differential 
FROM salary2023 
WHERE
	salary is not null
	AND
	shift_differential is not null
----------------------------

--		3.Salary + Education + years Exp
--			Comparing salary vs education vs years of exp
-- Data from 2022
SELECT 
	salary, 
	currency, 
	education, 
	experience 
FROM salary2022 
WHERE 
	experience <100 
	AND 
	experience is not null 
	AND
	salary is not null
	AND
	education is not null

	--Notes: 
	--	Experience <100 to filter out outliers that were not taken out in data cleaning 

-- Data from 2023
SELECT 
	salary, 
	currency, 
	education_level, 
	experience 
FROM salary2023 
WHERE 
	salary is not null 
	AND
	experience is not null
	AND
	education_level is not null

--Data from 2022 and 2023 together
SELECT 
	salary, 
	currency, 
	education, 
	experience 
FROM salary2022 
WHERE 
	experience <100 
	AND 
	salary is not null 
	AND
	experience is not null
	AND
	education is not null
UNION ALL
SELECT salary, currency, education_level, experience 
FROM salary2023 
WHERE 
	salary is not null 
	AND
	experience is not null
	AND
	education_level is not null
Order by experience asc

	--Notes: 
	--	Experience <100 to filter out outliers that were not taken out in data cleaning 


--		4.Salary + Job type + Location + Benefits
--			Comparing salary vs job type vs location vs benefits

-- Data from 2022
SELECT 
	salary, 
	currency, 
	title, 
	country, 
	state, 
	benefits
FROM salary2022
WHERE
	salary is not null
	AND
	title is not null
	AND 
	country is not null
	AND 
	state is not null
	AND
	benefits is not null
--Data from 2023 
SELECT 
	salary, 
	currency, 
	job_title, 
	country, 
	state, 
	benefits
FROM salary2023
WHERE
	salary is not null
	AND
	job_title is not null
	AND 
	country is not null
	AND 
	state is not null
	AND 
	benefits is not null

--Data from 2022 and 2023 together
SELECT 
	salary, 
	currency, 
	title, 
	country, 
	state, 
	benefits
FROM salary2022
WHERE
	salary is not null
	AND
	title is not null
	AND 
	country is not null
	AND 
	state is not null
	AND
	benefits is not null
UNION ALL
SELECT 
	salary, 
	currency, 
	job_title, 
	country, 
	state, 
	benefits
FROM salary2023
WHERE
	salary is not null
	AND
	job_title is not null
	AND 
	country is not null
	AND 
	state is not null
	AND 
	benefits is not null

--		5.Salary + Certifications + Location
--			Comparing salary vs certifications vs location
--Data from 2022
SELECT 
	salary, 
	currency, 
	certification, 
	country, 
	state 
FROM salary2022
WHERE
	salary is not null
	AND
	certification is not null
	AND
	country is not null
	AND 
	state is not null
--2023 data does not have certifications

--		6. Average salary per Job title and exp/location
--			Comparing the AVG salary based on experience and location 
-- Hourly 2022
SELECT 
	experience, 
	AVG(salary) as Average_salary
FROM salary2022
WHERE
	salary is not null
	AND
	salary < 1000
	AND
	experience is not null
	AND
	experience < 100
GROUP BY experience; 

--Notes: 
	--	Salary <1000 to filter out data for yearly salary
	--	Experience < 100 to filter out outliers 
-- Salary 2022 (Yearly)
SELECT 
	experience, 
	AVG(salary) as Average_salary
FROM salary2022
WHERE
	salary is not null
	AND
	salary > 1000
	AND
	experience is not null
	AND
	experience < 100
GROUP BY experience;

--Notes: 
	--	Salary > 1000 to filter out data for hourly salary
	--	Experience < 100 to filter out outliers 
--Hourly 2023
SELECT 
	experience, 
	AVG(salary) as Average_salary
FROM salary2023
WHERE
	salary is not null
	AND
	salary < 1000
	AND
	experience is not null
	AND
	experience < 100
GROUP BY experience;

--Notes: 
	--	Salary <1000 to filter out data for yearly salary
	--	Experience < 100 to filter out outliers 

--Salary 2023
SELECT 
	experience, 
	AVG(salary) as Average_salary
FROM salary2023
WHERE
	salary is not null
	AND
	salary > 1000
	AND
	experience is not null
	AND
	experience < 100
GROUP BY experience;

--Notes: 
	--	Salary > 1000 to filter out data for hourly salary
	--	Experience < 100 to filter out outliers 

-- Both 2022 and 2023 together (Salary Yearly)
SELECT 
	experience, 
	AVG(salary) AS average_salary
FROM (
	SELECT 
		experience, 
		salary
	FROM salary2022
	WHERE
		salary is not null
		AND
		salary > 1000
		AND
		experience is not null
		AND
		experience < 100
	UNION ALL
	SELECT 
		experience, 
		salary
	FROM salary2023
	WHERE
		salary is not null
		AND
		salary > 1000
		AND
		experience is not null
		AND
		experience < 100
)	
AS combined_data
GROUP BY experience
ORDER BY experience asc;


-- Both 2022 and 2023 together (Salary Hourly)
SELECT 
	experience, 
	AVG(salary) AS average_salary
FROM (
	SELECT 
		experience, 
		salary
	FROM salary2022
	WHERE
		salary is not null
		AND
		salary < 1000
		AND
		experience is not null
		AND
		experience < 100
	UNION ALL
	SELECT 
		experience, 
		salary
	FROM salary2023
	WHERE
		salary is not null
		AND
		salary < 1000
		AND
		experience is not null
		AND
		experience < 100
)	
AS combined_data
GROUP BY experience
ORDER BY experience asc;

--		7. Average salary Province
SELECT 
	state, 
	AVG(salary) AS average_salary
FROM (
	SELECT state, salary
	FROM salary2022
	UNION ALL
	SELECT state, salary
	FROM salary2023
)	
AS combined_data
WHERE 
	state is not null 
	AND
	salary is not null
	AND 
	salary <1000
GROUP BY state;


--@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@
--@@@@@@@@@@@
--@@@@@@@@@
-- Bellow need to have the Data cleaned to work properly

--		2a.Salary + Location + CPI (USA)
SELECT salary, currency, title, experience, country, state2, rank
FROM salary2022
INNER JOIN USACPI2022 
	ON state = state
WHERE 
	country = 'United States'
	and
	salary is not null
	AND
	experience is not null
	AND
	Salary < 1000
	AND
	Experience < 100
Order by rank asc
--

--		2b.Salary + Location + CPI (CAD)
SELECT salary, currency, title, experience, country, province, cpi
FROM salary2022
INNER JOIN CADCPI2022 
	ON state = state
WHERE 
	country = 'Canada'
	and
	salary is not null
	AND
	experience is not null
Order by cpi asc