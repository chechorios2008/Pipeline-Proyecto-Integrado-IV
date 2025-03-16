-- TODO: Esta consulta devolverá una tabla con las 10 categorías con mayores ingresos
-- (en inglés), el número de pedidos y sus ingresos totales. La primera columna será
-- Category, que contendrá las 10 categorías con mayores ingresos; la segunda será
-- Num_order, con el total de pedidos de cada categoría; y la última será Revenue,
-- con el ingreso total de cada categoría.
-- PISTA: Todos los pedidos deben tener un estado 'delivered' y tanto la categoría
-- como la fecha real de entrega no deben ser nulas.

SELECT 
    prod.product_category_name AS Category,
    COUNT(DISTINCT ord.order_id) AS Num_order,
    SUM(pay.payment_value) AS Revenue
FROM olist_orders ord 
INNER JOIN olist_order_items ord_it ON ord.order_id = ord_it.order_id
INNER JOIN olist_products prod ON ord_it.product_id = prod.product_id
INNER JOIN olist_order_payments pay ON ord.order_id = pay.order_id
WHERE ord.order_status = 'delivered'
AND ord.order_delivered_customer_date IS NOT NULL
GROUP BY prod.product_category_name
ORDER BY SUM(pay.payment_value) DESC
LIMIT 10;