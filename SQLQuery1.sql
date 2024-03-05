-- 01) 
select distinct(p.product_name), f.product_code, f.base_price, f.promo_type
from dim_products as p
inner join fact_events as f
on  p.product_code = f.product_code
where base_price > 500 and promo_type = "BOGOF"
order by product_name asc;


-- 02) find how much store at one city --
select distinct (city), count(store_id)
from dim_stores
group by city 
order by count(store_id) desc;


--03)_
SELECT campaign_name,
SUM(quantity_sold_before_promo * base_price) AS total_revenue_before_promotion,
SUM(quantity_sold_after_promo * base_price) AS total_revenue_after_promotion
FROM dim_campaigns AS c
INNER JOIN fact_events AS f 
ON c.campaign_id = f.campaign_id
GROUP BY campaign_name
ORDER BY campaign_name ASC;

--04)
Select p.category, 
Round((((Sum(quantity_sold_after_promo) - Sum(quantity_sold_before_promo)) / Sum(quantity_sold_before_promo)) * 100), 2) as ISU_PERCENTAGE,
Rank() Over (Order by (((Sum(quantity_sold_after_promo) - Sum(quantity_sold_before_promo)) / Sum(quantity_sold_before_promo)) * 100) desc) as Rank_order
From dim_products as p
Inner Join fact_events as f
on p.product_code = f.product_code
Where f.campaign_id = "CAMP_DIW_01"
Group By p.category;


--05)
Select p.product_name, p.category,
Round((((SUM(quantity_sold_after_promo * base_price) - SUM(quantity_sold_before_promo * base_price)) / SUM(quantity_sold_before_promo * base_price))*100), 2) As IR_PERCENTAGE
from dim_products as p
Inner Join fact_events as f
on p.product_code = f.product_code
Group By p.product_name, p.category
Order By IR_PERCENTAGE desc
Limit 5;








