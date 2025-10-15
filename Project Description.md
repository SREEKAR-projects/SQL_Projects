Data Cleaning Project (Practical Application)

Concept: Transforming raw data into a more usable and consistent format.
Steps:
Remove Duplicates: Identifying and eliminating redundant rows, often using ROW_NUMBER() with PARTITION BY across all relevant columns and inserting into a staging table for deletion.
Standardize Data: Fixing inconsistencies like spelling variations, casing, or extra spaces (e.g., using TRIM() for whitespace, UPPER()/LOWER() for casing, REPLACE() or LIKE with UPDATE for content variations like "crypto" vs. "cryptocurrency" or removing trailing periods).
Handle Null/Blank Values: Identifying and deciding whether to populate (e.g., based on other rows for the same company using self-joins) or remove missing data.
Remove Unnecessary Columns/Rows: Dropping irrelevant columns (ALTER TABLE ... DROP COLUMN) or rows that provide no useful information for analysis.
Staging Tables: The importance of creating copies of raw data (staging tables) to work on, preserving the original data.
Date Conversion: Using STRING_TO_DATE() to convert text dates to a proper DATE data type for time-series analysis and ALTER TABLE ... MODIFY COLUMN to change the column's data type.


Exploratory Data Analysis (EDA) Project (Practical Application)

Concept: Exploring data to find insights, trends, and patterns, often done in conjunction with data cleaning.
Basic Analysis:
Finding MAX() values for key metrics (e.g., max total laid off, max percentage laid off).
Aggregating data by company, industry, country, year, and stage using GROUP BY and SUM().
Determining date ranges (MIN() and MAX() dates) of the dataset.
Time-Series Analysis:
Extracting year (YEAR() function) or month (SUBSTRING() on date) for time-based grouping.
Rolling Sum (Cumulative Total): Using window functions (SUM() OVER (ORDER BY date/month)) to calculate cumulative layoffs over time.
Ranking Analysis:
Ranking companies by total layoffs per year using DENSE_RANK() with PARTITION BY year and ORDER BY total laid off.
Combining multiple CTEs to build complex queries for layered analysis.


