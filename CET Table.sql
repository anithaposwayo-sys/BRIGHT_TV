-- Databricks notebook source
-- Combined user profiles and viewership data
WITH user_profiles AS (
    SELECT UserID,
        CASE 
            WHEN Gender = 'None' THEN 'unknown'  
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
            WHEN Email IS NOT NULL THEN 1
            ELSE 0
        END AS Email_flag,
        CASE 
            WHEN `Social media Handle` IS NOT NULL THEN 1
            ELSE 0
        END AS SM_flag,
        CASE 
            WHEN Age = 0 THEN 'Infant'
            WHEN Age BETWEEN 1 AND 12 THEN 'Child'
            WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
            WHEN Age BETWEEN 20 AND 35 THEN 'Youth'
            WHEN Age BETWEEN 36 AND 50 THEN 'Adults'
            WHEN Age BETWEEN 51 AND 65 THEN 'Senior'
            ELSE 'Unknown'
        END AS Age_Group
    FROM workspace.default.bright_tv_dataset
),
cleaned_viewership AS (
    SELECT 
        COALESCE(UserID0, userid4) AS userid,   
        DATE_FORMAT(`Duration 2`, 'HH:mm:ss') AS duration,
        TO_DATE(RecordDate2) AS Record_Timestamp,
        FROM_UTC_timestamp(RecordDate2, 'Africa/Johannesburg') AS RecordDate_SAST,
        TO_DATE(TO_DATE(RecordDate2)) AS Watch_date,
        DAYNAME(TO_DATE(RecordDate2)) AS Day_name,
        DAYOFWEEK(TO_DATE(RecordDate2)) AS Day_of_Week,
        MONTHNAME(TO_DATE(RecordDate2)) AS Month_name,
        MONTH(TO_DATE(RecordDate2)) AS Month_Id,
        YEAR(TO_DATE(RecordDate2)) AS Year,
        HOUR(TO_TIMESTAMP(`Duration 2`, 'HH:mm:ss')) + MINUTE(TO_TIMESTAMP(`Duration 2`, 'HH:mm:ss')) / 60.0 + SECOND(TO_TIMESTAMP(`Duration 2`, 'HH:mm:ss')) / 3600.0 AS Duration_hours,
        HOUR(TO_TIMESTAMP(`Duration 2`, 'HH:mm:ss')) * 3600 + MINUTE(TO_TIMESTAMP(`Duration 2`, 'HH:mm:ss')) * 60 + SECOND(TO_TIMESTAMP(`Duration 2`, 'HH:mm:ss')) AS Duration_seconds,
        CASE
            WHEN DAYNAME(TO_TIMESTAMP(RecordDate2)) IN ('Sat', 'Sun') THEN 'weekend'
            ELSE 'weekday'
        END AS day_classification,
        CASE
            WHEN Channel2 IN ('SawSee', 'Sawsee') THEN 'SawSee'
            WHEN Channel2 IN ('SuperSport Live Events', 'Live on SuperSport', 'Supersport Live Events', 'DStv Events 1') THEN 'Live Events'
            ELSE Channel2
        END AS Tv_channel,
        date_format(RecordDate2, 'HH:mm:ss') AS watch_time,
        CASE 
            WHEN hour(RecordDate2) BETWEEN 0 AND 5 THEN '01.Midnight'
            WHEN hour(RecordDate2) BETWEEN 6 AND 11 THEN '02.Morning'
            WHEN hour(RecordDate2) BETWEEN 12 AND 16 THEN '03.Afternoon'
            WHEN hour(RecordDate2) BETWEEN 17 AND 23 THEN '04.Evening'
        END AS Time_of_day,
        CASE
            WHEN DATE_FORMAT(`Duration 2`, 'HH:mm:ss') BETWEEN '00:05:00' AND '00:30:00' THEN '01. Low Usage: <30 min'
            WHEN DATE_FORMAT(`Duration 2`, 'HH:mm:ss') BETWEEN '00:30:01' AND '00:59:59' THEN '02. Med Usage: <60 min'
            WHEN DATE_FORMAT(`Duration 2`, 'HH:mm:ss') > '00:59:59' THEN '03. High Usage: >60 min'
            ELSE '04. No Usage'
        END AS screen_time_bucket,
        DATE_FORMAT(`Duration 2`, 'HH:mm:ss') AS duration
    FROM workspace.default.viewership_table
)
SELECT 
    COALESCE(u.UserID, v.userid) AS sub_id,
    v.Year,
    v.Month_Id,
    v.Month_name,
    v.Watch_date,
    v.Day_name,
    v.Day_of_Week,
    v.day_classification,
    v.Tv_channel,
    v.watch_time,
    v.Time_of_day,
    v.Duration_hours,
    v.Duration_seconds,
    v.screen_time_bucket,
    v.RecordDate_SAST,
    u.Sex,
    u.Ethnicity,
    u.Region,
    u.Email_flag,
    u.SM_flag,
    u.Age_Group
FROM cleaned_viewership v
LEFT JOIN user_profiles u ON u.UserID = v.userid;
