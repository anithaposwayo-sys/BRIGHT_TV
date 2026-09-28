**📺 BrightTV User & Viewership Analytics**
📌 Project Overview

This project analyses BrightTV subscriber and viewership data to uncover user behaviour, viewing patterns, and content consumption trends.
The objective was to transform raw subscriber and viewing-session data into actionable insights that could help BrightTV understand its audience, identify viewing trends, and develop strategies to increase engagement and user retention.

The project covers the full data analytics workflow, from data cleaning and transformation to SQL analysis, dashboard development, and business recommendations.

**🎯 Business Questions**
The analysis aimed to answer the following questions:

How does viewership change over time?
What days and times do users watch BrightTV the most?
Which regions contribute the most to viewership?
What are the demographic characteristics of BrightTV's viewers?
Which channels receive the most viewing activity?
What factors may influence viewing behaviour?
How can BrightTV encourage users to watch more content during low-consumption periods?
What initiatives could help increase user engagement and grow the subscriber base?
🗂️ Dataset

The project used two main datasets:

**1. User Profiles**
Contains subscriber-level information such as:

Subscriber ID
Name
Username
Gender
Age
Race
Province
Email
Social media information

**2. Viewership Data**
Contains individual subscriber viewing sessions, including:

Subscriber ID
Viewing date/time
TV channel
Watch duration

The viewership timestamps were provided in UTC and were converted to South African Standard Time (SAST) for analysis.

**🛠️ Tools & Technologies**
Tool	Purpose
Databricks	Data cleaning, transformation and SQL analysis
SQL	Data preparation, joins, calculated fields and analysis
Microsoft Excel	Interactive dashboard and exploratory analysis
Power BI	KPI visualisation and data presentation
Looker Studio	Interactive dashboard and reporting
GitHub	Project documentation and portfolio

**🔄 Data Preparation**
The raw datasets were cleaned and transformed in Databricks before analysis.
Key steps included:

Cleaning subscriber and viewership data
Handling missing values using COALESCE
Joining the user profile and viewership datasets
Converting UTC timestamps to South African time
Creating date and time-based variables
Creating viewing-time categories
Creating screen-time duration buckets
Creating age groups
Standardising demographic fields
Preparing the final analytical dataset for dashboarding


**📊 Dashboard**
The project included interactive dashboards developed using Excel, Looker Studio and Power BI.
The dashboards focused on:

Key Performance Indicators
Total Watch Time
Average Watch Time
Total Views/Sessions
Returning User Rate
Viewer demographics
Interactive Analysis

Users can explore the data using filters such as:

Month
Day
Province
Gender
Age Group
TV Channel
Time of Day
