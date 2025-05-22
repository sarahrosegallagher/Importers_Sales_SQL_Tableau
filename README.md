# Advanced SQL for Sales & Profit Analysis

Built a suite of intermediate-to-advanced SQL queries to analyze customer behavior, product categories, and profit trends using the Wide World Importers DW schema. Used window functions, CTEs, and conditional logic to support KPI dashboards, customer segmentation, and profitability insights. Designed to power Power BI and Tableau visualizations with features like custom item categories and chiller/dry product segmentation.


<img src = "https://github.com/sarahrosegallagher/Importers_Sales_SQL_Tableau/blob/dbba14820a493257b00e71737798579bc24b24fa/Images/mssm.png" width="300">

<img src = "https://github.com/sarahrosegallagher/Importers_Sales_SQL_Tableau/blob/dbba14820a493257b00e71737798579bc24b24fa/Images/tableautips_30.png" width="300">


## Overview of the Analysis:

Context:
* This analysis is from the World Wide Importers Database, consisting of 30 relationally connected tables. I primarily used the Sales table to gather KPI data (200k+ records). 

Purpose:
*  Create a dashboard to visualize KPIs trends in Tableau from data gathered in SQL 

Tasks:
* Explore the database in Microsoft SQL Server Management Studio by creating an Entity Relationship Diagram and executing various test queries to check for nulls, look at summary statistics, and develop next step questions. 

* Write and execute SQL queries to be read into Tableau for visualization. SQL query constructs used include: 
  * **CTEs**
  * **Subqueries**
  * **Window Functions**
  * **Case Statements**
  * **Aggregations**
  * **Joins**
  
 * Read the data from SQL into Tableau and create a dashboard of visualizations on sales, profit, stock items, and customers. 

## Results:

### See [Queries.sql](https://github.com/sarahrosegallagher/Importers_Sales_SQL_Tableau/blob/ffc5b23b276f225d6ddfd50885366e86f9524876/Queries.sql) file for SQL work. 

### [Click here to view interactive dashboard on Tableau Public. ](https://public.tableau.com/views/test_16744357801420/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link)


Dashboard Default Display 

<img src = "https://github.com/sarahrosegallagher/Importers_Sales_SQL_Tableau/blob/main/Images/dashboard1.png" >

Dashboard with Tooltip and Drilldown 
<img src = "https://github.com/sarahrosegallagher/Importers_Sales_SQL_Tableau/blob/main/Images/dashboard2.png" >


Entity Relationship Diagram 
<img src = "https://github.com/sarahrosegallagher/Importers_Sales_SQL_Tableau/blob/main/Images/WWI_ERD.png">




