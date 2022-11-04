-- 1) Split the column Employee Skills (emp_skills) present in the Employee table into 3 different Employee Skill column based on field separator ',' and populate it into a new table
-- 2) Unselect the old column Employee Skills (emp_skills)
-- 3) Rename the column name 'emp_no' and 'emp_name' with relevant column headings

CREATE TABLE 
    data_management_2.demo4_output
AS SELECT
    emp_no AS Employee_Number,
    emp_name AS Employee_Name,
    SPLIT(emp_skills, ',')[OFFSET(0)] AS Employee_Skills_1,
    SPLIT(emp_skills, ',')[OFFSET(1)] AS Employee_Skills_2,
    SPLIT(emp_skills, ',')[OFFSET(2)] AS Employee_Skills_3
FROM
    data_management_2.demo4_employee