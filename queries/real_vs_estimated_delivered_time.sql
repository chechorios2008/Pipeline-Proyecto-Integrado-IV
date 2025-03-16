-- TODO: Esta consulta devolverá una tabla con las diferencias entre los tiempos 
-- reales y estimados de entrega por mes y año. Tendrá varias columnas: 
-- month_no, con los números de mes del 01 al 12; month, con las primeras 3 letras 
-- de cada mes (ej. Ene, Feb); Year2016_real_time, con el tiempo promedio de 
-- entrega real por mes de 2016 (NaN si no existe); Year2017_real_time, con el 
-- tiempo promedio de entrega real por mes de 2017 (NaN si no existe); 
-- Year2018_real_time, con el tiempo promedio de entrega real por mes de 2018 
-- (NaN si no existe); Year2016_estimated_time, con el tiempo promedio estimado 
-- de entrega por mes de 2016 (NaN si no existe); Year2017_estimated_time, con 
-- el tiempo promedio estimado de entrega por mes de 2017 (NaN si no existe); y 
-- Year2018_estimated_time, con el tiempo promedio estimado de entrega por mes 
-- de 2018 (NaN si no existe).
-- PISTAS:
-- 1. Puedes usar la función julianday para convertir una fecha a un número.
-- 2. order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL
-- 3. Considera tomar order_id distintos.
    SELECT 
    month_no,
    CASE 
        WHEN month_no = 1 THEN 'Ene'
        WHEN month_no = 2 THEN 'Feb'
        WHEN month_no = 3 THEN 'Mar'
        WHEN month_no = 4 THEN 'Abr'
        WHEN month_no = 5 THEN 'May'
        WHEN month_no = 6 THEN 'Jun'
        WHEN month_no = 7 THEN 'Jul'
        WHEN month_no = 8 THEN 'Ago'
        WHEN month_no = 9 THEN 'Sep'
        WHEN month_no = 10 THEN 'Oct'
        WHEN month_no = 11 THEN 'Nov'
        WHEN month_no = 12 THEN 'Dic'
    END AS month_,
    AVG(CASE WHEN year = 2016 THEN real_time END) AS Year2016_real_time,
    AVG(CASE WHEN year = 2017 THEN real_time END) AS Year2017_real_time,
    AVG(CASE WHEN year = 2018 THEN real_time END) AS Year2018_real_time,
    AVG(CASE WHEN year = 2016 THEN estimated_time END) AS Year2016_estimated_time,
    AVG(CASE WHEN year = 2017 THEN estimated_time END) AS Year2017_estimated_time,
    AVG(CASE WHEN year = 2018 THEN estimated_time END) AS Year2018_estimated_time
FROM (
    SELECT 
        CAST(strftime('%m', order_delivered_customer_date) AS INTEGER) AS month_no,
        CAST(strftime('%Y', order_delivered_customer_date) AS INTEGER) AS year,
        julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date) AS real_time,
        julianday(order_estimated_delivery_date) - julianday(order_purchase_timestamp) AS estimated_time
    FROM olist_orders
    WHERE order_status = 'delivered' 
      AND order_delivered_customer_date IS NOT NULL
) AS subquery
GROUP BY month_no
ORDER BY month_no;