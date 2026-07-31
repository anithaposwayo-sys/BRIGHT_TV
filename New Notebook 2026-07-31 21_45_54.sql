-- Databricks notebook source
---Inspecting the Data---
SELECT *
FROM workspace.default.bright_tv_dataset;

--Inspecting the Race Column--
SELECT DISTINCT Gender
FROM workspace.default.bright_tv_dataset;

--Inspecting the Race Column--
SELECT DISTINCT Race
FROM workspace.default.bright_tv_dataset;

--Inspecting the Province Column--
SELECT DISTINCT Province
FROM workspace.default.bright_tv_dataset;


---Inspecting Gender Columnb--
SELECT DISTINCT Gender
FROM workspace.default.bright_tv_dataset;

---Inspecting the age column---
SELECT MIN(Age) AS min_age, 
       MAX(Age) AS max_age,
       AVG(Age) AS mean_age 
FROM workspace.default.bright_tv_dataset;


---Cleaning the Gender Column--

SELECT *,
  CASE 
            WHEN Gender ='None' THEN 'unknown'  
            WHEN Gender = ' ' THEN 'unknown'  
            WHEN Gender IS NULL THEN 'unknown' 
       ELSE Gender 
       END AS Sex,

-----Cleaning the Race Column---
CASE
            WHEN race = 'other' THEN 'unknown' 
            WHEN race = 'None' THEN 'unknown' 
            WHEN race = ' ' THEN 'unknown' 
            WHEN race IS NULL THEN 'unknown'
        ELSE race 
        END AS Ethnicity,  
        

        ----Cleaning the Province Column---

CASE 
            WHEN province = 'None' THEN 'unknown' 
            WHEN province = ' ' THEN 'unknown' 
            WHEN province IS NULL THEN 'unknown'
        ELSE province 
        END AS Region, 


CASE 
            WHEN 'Email' IS NOT NULL THEN 1
Else 0
END AS Email_flag,
CASE 
          WHEN 'Social media Handle' IS NOT NULL THEN 1
        Else 0
END AS SM_flag,
CASE 
        WHEN Age = 0 THEN 'Infant'
        WHEN Age BETWEEN 1 AND 12 THEN 'Child'
        WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
        WHEN Age BETWEEN 20 AND 35 THEN 'Youth'
        WHEN Age BETWEEN 36 AND 50 THEN 'Adults'
        WHEN Age BETWEEN 51 AND 65 THEN 'Senior'
        ELSE  'Unknown'
END AS Age_Group
FROM workspace.default.bright_tv_dataset;


-----CREATING A NEW TEMP TABLE THAT WILL ONLY CONSIST OF THE CLEANED DATASET----

CREATE OR REPLACE TABLE Cleaned_UserProfile AS
SELECT 
  UserID,
  CASE 
            WHEN Gender ='None' THEN 'unknown'  
            WHEN Gender = ' ' THEN 'unknown'  
            WHEN Gender IS NULL THEN 'unknown' 
       ELSE Gender 
       END AS Sex,

CASE
            WHEN race = 'other' THEN 'unknown' 
            WHEN race = 'None' THEN 'unknown' 
            WHEN race = ' ' THEN 'unknown'
            WHEN race IS NULL THEN 'unknown'
        ELSE race 
        END AS Ethnicity, 
        


CASE 
            WHEN province = 'None' THEN 'unknown' 
            WHEN province = ' ' THEN 'unknown' 
            WHEN province IS NULL THEN 'unknown'
        ELSE province 
        END AS Region,


CASE 
            WHEN 'Email' IS NOT NULL THEN 1
Else 0
END AS Email_flag,
CASE 
          WHEN 'Social media Handle' IS NOT NULL THEN 1
        Else 0
END AS SM_flag,
CASE 
        WHEN Age = 0 THEN 'Infant'
        WHEN Age BETWEEN 1 AND 12 THEN 'Child'
        WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
        WHEN Age BETWEEN 20 AND 35 THEN 'Youth'
        WHEN Age BETWEEN 36 AND 50 THEN 'Adults'
        WHEN Age BETWEEN 51 AND 65 THEN 'Senior'
        ELSE  'Unknown'
END AS Age_Group
FROM workspace.default.bright_tv_dataset;

SELECT *
FROM Cleaned_UserProfile
