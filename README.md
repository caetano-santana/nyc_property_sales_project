# nyc_property_sales_project
NYC Property Sales Analysis

**To access the original data set**, visit the oficial NYC gov site: https://data.cityofnewyork.us/City-Government/NYC-Citywide-Annualized-Calendar-Sales-Update/w2pb-icbu/data_preview

This project was created with the purpose of serving as a practice exercise.


# **Analysis tools:**
Excel was used to clean & transform the data;
MySQL was used to query & analyze;
Power BI to create the final data visualization.

--

## **Excel to clean & transform the data: step-by-step proccess:**
- Transformation and Load of the original dataset using Power Query;
- Data validation;
- Normalization of "BOROUGH" column: the data was originally stored both using the names of the boroughs and numerals in reference to it.
  It was necessary to replace from numbers to the borough's text descriptions;
- Format of columns "LAND SQUARE FEET" & "GROSS SQUARE FEET": the original data was stored as text, with commas as separators, which made it not possible to simply format them as "number". The commas were first replaced by _blank_, and then formatted as number;
- "YEAR BUILT" column: replacement of outliars values to _null_;
- "SALE DATE" column: its values had originally "/" as a separator. To input the data with no errors into MySQL, it was changed to yyyymmdd and formatted to text
- Deletion of rows where "PRICE SALE" > US$10.000

## **SQL analysis summary:**
- Sales By Year: aggregated data by year_of_sale & borough for overall sales trends over time;

- Borough AVG Sales Price Comparison: AVG, MIN, MAX sales prices by borough; land and gross_square_feet avg sales prices and count of sales;

- Building class AVG sale price: AVG, MIN, MAX sales prices by building_class_category_brackets & count of properties;

- Average sale price per borough and building class: AVG of sold properties per borough per building_class_category_brackets;

- Average sales description_building_class_at_time_of_sale, per decades;

- Average land and gross square feet per borough, neighborhood and property_type_at_time_of_sale;

- Average land and gross square feet per borough, type of property (residential or commercial) and description_building_class_at_time_of_sale;


## **Power BI dashboard summary description:**
- Sales By Year: clustered columns per borough, displaying the count of sold properties, filtered by year (2016-2022);

- AVG Prices/Gross & Land ft²: line and stacked columns chart displaying average sales prices per borough, and the averages prices of both gross and land ft² at the time of sale;

- Time of Building: count of sold properties by decade of building, displayed in a donut chart, divided by decades clusters;

- AVG Sale Price by Property Category: line and stacked columns chart displaying the count of sold properties and avg sales prices by property categories clusters, with the option to filter by type of property (commercial/other & residential);

- Property Types by Borough: line and stacked columns chart displaying the average sales prices & count of sold properties by borough, with the option to filter by building category.
