-- TODO: Esta consulta devolverá una tabla con los ingresos por mes y año.
-- Tendrá varias columnas: month_no, con los números de mes del 01 al 12;
-- month, con las primeras 3 letras de cada mes (ej. Ene, Feb);
-- Year2016, con los ingresos por mes de 2016 (0.00 si no existe);
-- Year2017, con los ingresos por mes de 2017 (0.00 si no existe); y
-- Year2018, con los ingresos por mes de 2018 (0.00 si no existe).

SELECT 
    strftime('%m', order_purchase_timestamp) AS month_no,
    CASE 
        WHEN strftime('%m', order_purchase_timestamp) = '01' THEN 'Ene'
        WHEN strftime('%m', order_purchase_timestamp) = '02' THEN 'Feb'
        WHEN strftime('%m', order_purchase_timestamp) = '03' THEN 'Mar'
        WHEN strftime('%m', order_purchase_timestamp) = '04' THEN 'Abr'
        WHEN strftime('%m', order_purchase_timestamp) = '05' THEN 'May'
        WHEN strftime('%m', order_purchase_timestamp) = '06' THEN 'Jun'
        WHEN strftime('%m', order_purchase_timestamp) = '07' THEN 'Jul'
        WHEN strftime('%m', order_purchase_timestamp) = '08' THEN 'Ago'
        WHEN strftime('%m', order_purchase_timestamp) = '09' THEN 'Sep'
        WHEN strftime('%m', order_purchase_timestamp) = '10' THEN 'Oct'
        WHEN strftime('%m', order_purchase_timestamp) = '11' THEN 'Nov'
        WHEN strftime('%m', order_purchase_timestamp) = '12' THEN 'Dic'
    END AS month,
    SUM(CASE WHEN strftime('%Y', order_purchase_timestamp) = '2016' THEN payment_value ELSE 0 END) AS Year2016,
    SUM(CASE WHEN strftime('%Y', order_purchase_timestamp) = '2017' THEN payment_value ELSE 0 END) AS Year2017,
    SUM(CASE WHEN strftime('%Y', order_purchase_timestamp) = '2018' THEN payment_value ELSE 0 END) AS Year2018
FROM olist_orders AS ord
INNER JOIN olist_order_payments AS pay ON ord.order_id = pay.order_id
WHERE order_status = 'delivered' 
AND order_delivered_customer_date IS NOT NULL
GROUP BY month_no
ORDER BY CAST(month_no AS INTEGER);
