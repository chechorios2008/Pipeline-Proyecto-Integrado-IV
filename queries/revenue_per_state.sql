-- TODO: Esta consulta devolverá una tabla con dos columnas; customer_state y Revenue.
-- La primera contendrá las abreviaturas que identifican a los 10 estados con mayores ingresos,
-- y la segunda mostrará el ingreso total de cada uno.
-- PISTA: Todos los pedidos deben tener un estado "delivered" y la fecha real de entrega no debe ser nula.

SELECT 
    cus.customer_state AS customer_state,
    SUM(pay.payment_value) AS Revenue
FROM olist_orders AS ord
INNER JOIN olist_customers AS cus ON ord.customer_id = cus.customer_id
INNER JOIN olist_order_payments AS pay ON ord.order_id = pay.order_id
WHERE ord.order_status = 'delivered'
AND ord.order_delivered_customer_date IS NOT NULL
GROUP BY cus.customer_state
ORDER BY Revenue DESC
LIMIT 10;