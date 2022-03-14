# Solution/Explanation

One of the changes I made is to add foreign keys on the tables since the orignal script doesn't have any defined. Foreign keys help related data across tables consistent.
I also made sure the data types are the same for the columns on child and its referenced/parent tables.  This is to avoid data conversions when joining the columns which may lead to poor query performance.

Please see below Explain and Query Runtime on fetching Top 100 employees with highest salary (multiple joins). Results based on 10000 employee records.

SELECT e.employee_id, 
e.first_name, 
e.last_name, 
e.job_id, 
j.job_title,
e.salary, 
e.department_id, 
d.department_name,
d.location_id,
l.country_id,
l.city,
c.country_name,
c.region_id,
r.region_name
FROM 
employees e JOIN departments d ON e.department_id=d.department_id
JOIN jobs j ON e.job_id=j.job_id
JOIN  locations l ON d.location_id=l.location_id
JOIN countries c ON l.country_id = c.country_id
JOIN regions r ON c.region_id=r.region_id
ORDER BY e.SALARY 
DESC LIMIT 100;


I've also prepared 2 versions of the sql -- one works for older versions of mysql, while the other for recent/latest versions. Removed UNSIGNED for the latest and added CHECK constraints instead.
