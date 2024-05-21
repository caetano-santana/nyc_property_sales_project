-- ## Sales trends by year: aggregated data by year_of_sale & borough for overall sales trends over time 
CREATE VIEW sales_trends_year_and_borough AS
SELECT distinct YEAR(sale_date) AS year_of_sale, borough, COUNT(borough) AS sales_per_borough
FROM nyc_property_sales.nyc_property_sales
Group by year_of_sale, borough
ORDER BY 1;


-- ## Borough AVG sales price comparison: avg, min, max sales prices by borough; land and gross_square_feet avg sales prices and count of sales
CREATE VIEW avg_sales_per_borough AS
SELECT borough,
ROUND(AVG(sale_price)) AS avg_sale_price,
ROUND(AVG(CASE WHEN land_square_feet > 0 AND land_square_feet IS NOT NULL THEN sale_price/land_square_feet END), 0) AS avg_sale_price_land_sq_feet,
ROUND(AVG(CASE WHEN gross_square_feet > 0 AND gross_square_feet IS NOT NULL THEN sale_price/gross_square_feet END), 0) AS avg_sale_price_gross_sq_feet,
MIN(sale_price) AS min_sale_price,
MAX(sale_price) AS max_sale_price,
COUNT(sale_price) as count_of_sales
FROM nyc_property_sales.nyc_property_sales
GROUP BY borough
ORDER BY avg_sale_price DESC;


-- ## Building class AVG sale price: avg, min, max sales prices by building_class_category_brackets & count of properties 
CREATE VIEW avg_sales_price_per_building_cat_brackets_new AS
SELECT  CASE 
        WHEN tax_class_at_time_of_sale IN ('1', '2') THEN 'Residential'
        WHEN tax_class_at_time_of_sale IN ('3', '4') THEN 'Commercial/Other'
    END AS property_type,
	borough,
	building_class_category_brackets, 
	ROUND(AVG(sale_price)) AS avg_sale_price, 
	MIN(sale_price) AS min_sale_price,
    MAX(sale_price) AS max_sale_price,
	COUNT(*) AS count_of_properties
FROM nyc_property_sales.nyc_property_sales
GROUP BY borough, property_type, building_class_category_brackets
ORDER BY avg_sale_price DESC;


-- ##Avg sale price per borough and building class: avg of sold properties per borough per building_class_category_brackets
CREATE VIEW avg_sales_price_per_type_per_borough AS
SELECT borough,
	building_class_category_brackets,
	ROUND(AVG(sale_price),0) AS avg_sale_price,
	COUNT(*) as count_of_properties
FROM nyc_property_sales
GROUP BY borough, building_class_category_brackets
ORDER BY borough;

-- ##Avg sales description_building_class_at_time_of_sale , per decades
CREATE VIEW avg_sales_price_per_type_at_time_of_sale AS
SELECT DISTINCT description_building_class_at_time_of_sale,
    CASE
		WHEN year_built <= 1900 THEN '1900 or before'
		WHEN year_built <= 1930 THEN '1901 - 1930'
		WHEN year_built <= 1950 THEN '1931 - 1950'
		WHEN year_built <= 1970 THEN '1951 - 1970'
		WHEN year_built <= 1990 THEN '1971 - 1990'
		WHEN year_built <= 2010 THEN '1991 - 2010'
		WHEN year_built <= 2024 THEN '2011 - 2024' 
        ELSE 'Other'
	END AS decade_built,
    ROUND(AVG(sale_price),0) AS avg_sale_price,
    COUNT(*) AS count_of_properties
FROM nyc_property_sales
WHERE year_built IS NOT NULL
GROUP BY decade_built, description_building_class_at_time_of_sale
ORDER BY decade_built, description_building_class_at_time_of_sale;

-- ##Avg land and gross square feet per borough, neighborhood and property_type_at_time_of_sale
CREATE VIEW avg_sqr_feet_per_boroug_neighborhood_type AS
SELECT 
	borough,
    neighborhood,
    zip_code,
	description_building_class_at_time_of_sale,
    ROUND(AVG(CASE WHEN land_square_feet > 0 AND land_square_feet IS NOT NULL THEN sale_price/land_square_feet END),0) AS avg_price_land_square_feet, 
    ROUND(AVG(CASE WHEN gross_square_feet > 0 AND gross_square_feet IS NOT NULL THEN sale_price/gross_square_feet END),0) AS avg_price_gross_square_feet
FROM nyc_property_sales
GROUP BY borough, neighborhood, zip_code, description_building_class_at_time_of_sale
ORDER BY borough, description_building_class_at_time_of_sale;

-- ##Avg land and gross square feet per borough, Residential/Other and description_building_class_at_time_of_sale
CREATE VIEW avg_sqr_feet_per_boroug_and_building_class AS
SELECT 
    borough,
    CASE 
        WHEN tax_class_at_time_of_sale IN ('1', '2') THEN 'Residential'
        WHEN tax_class_at_time_of_sale IN ('3', '4') THEN 'Commercial/Other'
    END AS property_type,
    description_building_class_at_time_of_sale,
    ROUND(AVG(land_square_feet), 0) AS avg_land_square_feet, 
    ROUND(AVG(gross_square_feet), 0) AS avg_gross_square_feet
FROM nyc_property_sales
GROUP BY borough, property_type, description_building_class_at_time_of_sale
HAVING avg_land_square_feet > 0 
    AND avg_gross_square_feet > 0
    AND avg_land_square_feet IS NOT NULL
    AND avg_gross_square_feet IS NOT NULL
ORDER BY property_type, borough, description_building_class_at_time_of_sale;
