
SELECT DISTINCT 
prod.product_weight_g AS weight,
AVG(ord_it.freight_value) AS freight_value
FROM olist_order_items ord_it
INNER JOIN olist_products prod ON ord_it.product_id = prod.product_id
group by prod.product_id
