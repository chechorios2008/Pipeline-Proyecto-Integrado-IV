SELECT 
    order_purchase_timestamp, 
    COUNT(*) AS order_count, 
    order_purchase_timestamp AS date, 
    CASE 
        WHEN holiday THEN 'True' 
        ELSE 'False' 
    END AS holiday
FROM (
    SELECT 
        strftime('%Y-%m-%d', ord.order_purchase_timestamp) AS order_purchase_timestamp, 
        hol.date IS NOT NULL AS holiday 
    FROM olist_orders ord
    LEFT JOIN public_holidays hol 
        ON strftime('%Y-%m-%d', ord.order_purchase_timestamp) = strftime('%Y-%m-%d', hol.date)
    WHERE strftime('%Y', ord.order_purchase_timestamp) = '2017'
) AS orders
GROUP BY order_purchase_timestamp, holiday;