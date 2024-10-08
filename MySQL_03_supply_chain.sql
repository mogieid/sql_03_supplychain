#----------Supply Chain anlysis using MySQL------------

# Create the table we need in the database

CREATE TABLE supply_chain_01( 

	product_type varchar(100) ,
	sku varchar(100) NOT NULL,
	price varchar(100),
	availability varchar(100),
	number_of_products_sold varchar(100),
	revenue_generated varchar(100),
	customer_demographics varchar(100),
	stock_levels varchar(100),
	lead_times varchar(100),
	order_quantities varchar(100),
	shipping_times varchar(100),
	shipping_carriers varchar(100),
	shipping_costs varchar(100),
	supplier_name varchar(100),
	location varchar(100),
	lead_time varchar(100),
	production_volumes varchar(100),
	manufacturing_lead_time varchar(100),
	manufacturing_costs varchar(100),
	inspection_results varchar(100),
	defect_rates varchar(100),
	transportation_modes varchar(100),
	routes varchar(100),
	costs varchar(100),
	
    PRIMARY KEY (sku)  
);  

#-------------- Analysis Details-----------------#

#1. Product Sales and Revenue Analysis
#This query gives you the total number of products sold,
#the revenue generated, and the average price by product type.

SELECT 
    product_type,
    SUM(number_of_products_sold) AS total_products_sold,
    round(SUM(revenue_generated),2) AS total_revenue_generated,
    round(AVG(price), 2) AS avg_price
FROM 
    supply_chain_01
GROUP BY 
    product_type;

   
#2. Lead Time and Shipping Analysis
#This analysis combines lead times, shipping times,
#and the associated costs to give insights into how lead times and shipping affect operational costs.
   
   
SELECT 
    product_type,
    lead_times,
    shipping_times,
    shipping_carriers,
    SUM(shipping_costs) AS total_shipping_costs,
    AVG(lead_times + shipping_times) AS avg_total_delivery_time
FROM 
    supply_chain_01
GROUP BY 
    product_type, lead_times, shipping_times, shipping_carriers;
   
   
   
#4. Supplier and Manufacturing Analysis
#This query gives insights into supplier performance,
#focusing on lead time, production volumes, and manufacturing costs by supplier name and product type.
   
SELECT 
    supplier_name,
    product_type,
    round(AVG(manufacturing_lead_time),2)  AS avg_manufacturing_lead_time,
    SUM(production_volumes) AS total_production_volumes,
    round(AVG(manufacturing_costs),2)  AS avg_manufacturing_costs
FROM 
    supply_chain_01
GROUP BY 
    supplier_name, product_type;
   
   
#5. Defect Rate and Inspection Results Analysis
#This query shows defect rates, inspection results,
#and transportation modes for product types to assess quality control and logistics.
   

SELECT 
    product_type,
    transportation_modes,
    round(AVG(defect_rates),2) AS avg_defect_rate,
    COUNT(CASE WHEN inspection_results = 'Pass' THEN 1 END) AS passed_inspections,
    COUNT(CASE WHEN inspection_results = 'Fail' THEN 1 END) AS failed_inspections
FROM 
    supply_chain_01
GROUP BY 
    product_type, transportation_modes;
   

#6. Customer Demographics and Sales
#This query shows the number of products sold and revenue generated by customer demographics.
   
SELECT 
    customer_demographics,
    SUM(number_of_products_sold) AS total_products_sold,
    round(SUM(revenue_generated),2)  AS total_revenue_generated
FROM 
    supply_chain_01
GROUP BY 
    customer_demographics;
   
   
   
