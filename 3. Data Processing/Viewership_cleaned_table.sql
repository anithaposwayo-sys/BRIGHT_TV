-- Databricks notebook source
SELECT *
FROM workspace.default.viewership_table;


SELECT COALESCE (UserID0, userid4) AS User_id,-- combining two user ids into one
              From_UTC_Timestamp(RecordDate2, 'Africa/Johannesburg') AS RecordDate_SAST,--converting timestamp to SA time
              Channel2,
             `Duration 2`,
        TO_DATE(TO_DATE(RecordDate2)) AS Watch_date,
        DAYNAME(TO_DATE(RecordDate2)) AS Day_name,
        DAYOFWEEK(TO_DATE(RecordDate2)) AS Day_of_Week,
        MONTHNAME(TO_DATE(RecordDate2)) AS Month_name,
        MONTH(TO_DATE(RecordDate2)) AS Month_Id,
        YEAR(TO_DATE(RecordDate2)) AS Year,
     DATE_FORMAT(`Duration 2`, 'HH:mm:ss') AS duration,
    HOUR(TO_TIMESTAMP(`Duration 2`, 'HH:mm:ss')) +
    MINUTE(TO_TIMESTAMP(`Duration 2`, 'HH:mm:ss')) / 60.0 + --converting minutes to seconds
    SECOND(TO_TIMESTAMP(`Duration 2`, 'HH:mm:ss')) / 3600.0--converting seconds to minutes
    AS Duration_hours,
        
    HOUR(TO_TIMESTAMP(`Duration 2`, 'HH:mm:ss')) * 3600 + --converting hours to seconds
    MINUTE(TO_TIMESTAMP(`Duration 2`, 'HH:mm:ss')) * 60 + ---converting minutes to seconds
    SECOND(TO_TIMESTAMP(`Duration 2`, 'HH:mm:ss'))
    AS Duration_seconds,
   
    CASE
    WHEN Channel2 IN ('SawSee','Sawsee') THEN 'SawSee'
    WHEN Channel2 IN ('SuperSport Live Events','Live on SuperSport', 'Supersport Live Events',
    'DStv Events 1') THEN 'Live Events'
    ELSE Channel2
    END AS Tv_channel,date_format(RecordDate2, 'HH:mm:ss') AS watch_time,
    CASE
    WHEN DATE_FORMAT(`Duration 2`, 'HH:mm:ss') BETWEEN '00:05:00' AND '00:30:00'
        THEN '01. Low Usage: <30 min'
    WHEN DATE_FORMAT(`Duration 2`, 'HH:mm:ss') BETWEEN '00:30:01' AND '00:59:59'
        THEN '02. Med Usage: <60 min'
    WHEN DATE_FORMAT(`Duration 2`, 'HH:mm:ss') > '00:59:59'
        THEN '03. High Usage: >60 min'
    ELSE '04. No Usage'
    END AS screen_time_bucket,
    CASE 
WHEN hour(`RecordDate2`) BETWEEN 0 AND 5 THEN '01.Midnight'
WHEN hour(`RecordDate2`) BETWEEN 6 AND 11 THEN '02.Morning'
WHEN hour(`RecordDate2`) BETWEEN 12 AND 16 THEN '03.Afternoon'
WHEN hour(`RecordDate2`) BETWEEN 17 AND 23 THEN '04.Evening'
END AS Time_of_day,
CASE
WHEN DAYNAME(TO_TIMESTAMP(RecordDate2)) IN ('Sat', 'Sun') THEN 'weekend'
ELSE 'weekday'
END AS day_classification
FROM workspace.default.viewership_table;
