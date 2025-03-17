-- TODO: Esta consulta devolverá una tabla con dos columnas: estado_pedido y
-- Cantidad. La primera contendrá las diferentes clases de estado de los pedidos,
-- y la segunda mostrará el total de cada uno.
select order_status as estado_pedido, count(order_status) as Cantidad
from olist_orders
group by order_status