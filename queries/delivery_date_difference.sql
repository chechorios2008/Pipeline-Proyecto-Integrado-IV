-- TODO: Esta consulta devolverá una tabla con dos columnas: Estado y 
-- Diferencia_Entrega. La primera contendrá las letras que identifican los 
-- estados, y la segunda mostrará la diferencia promedio entre la fecha estimada 
-- de entrega y la fecha en la que los productos fueron realmente entregados al 
-- cliente.
-- PISTAS:
-- 1. Puedes usar la función julianday para convertir una fecha a un número.
-- 2. Puedes usar la función CAST para convertir un número a un entero.
-- 3. Puedes usar la función STRFTIME para convertir order_delivered_customer_date a una cadena, eliminando horas, minutos y segundos.
-- 4. order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL

SELECT customer_state AS Estado, 
       CAST(AVG(julianday(date(order_estimated_delivery_date)) - julianday(date(order_delivered_customer_date))) AS INTEGER) AS Diferencia_Entrega
  FROM olist_orders ord 
INNER JOIN olist_customers cus ON ord.customer_id = cus.customer_id
 WHERE order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL
 GROUP BY customer_state
 ORDER BY Diferencia_Entrega;