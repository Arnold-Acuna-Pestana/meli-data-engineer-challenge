
-- 1. Listar los usuarios que cumplan años el día de hoy cuya cantidad de ventas realizadas en enero 2020 sea superior a 1500.
SELECT 
  c.customer_id,
  c.nombre,
  c.apellido,
  c.nacimiento,
  SUM(o.precio * o.cantidad) AS total_ventas
FROM public.customer c
JOIN public.orders o ON o.seller_id = c.customer_id
WHERE 
  EXTRACT(MONTH FROM o.order_date) = 1 AND
  EXTRACT(YEAR FROM o.order_date) = 2020 AND
  TO_CHAR(c.nacimiento, 'MM-DD') = TO_CHAR(CURRENT_DATE, 'MM-DD')
GROUP BY c.customer_id
HAVING SUM(o.precio * o.cantidad) > 1500;

-- 2. Por cada mes del 2020, se solicita el top 5 de usuarios que más vendieron($) en lacategoría Celulares. Se requiere el mes y año de 
-- análisis, nombre y apellido del vendedor, cantidad de ventas realizadas, cantidad de productos vendidos y el monto total transaccionado.
WITH ventas AS (
  SELECT 
    EXTRACT(MONTH FROM o.order_date) AS mes,
    c.customer_id,
    c.nombre,
    c.apellido,
    COUNT(o.order_id) AS cantidad_ventas,
    SUM(o.cantidad) AS productos_vendidos,
    SUM(o.precio * o.cantidad) AS total
  FROM public.orders o
  JOIN public.item i ON o.item_id = i.item_id
  JOIN public.category cat ON i.category_id = cat.category_id
  JOIN public.customer c ON c.customer_id = o.seller_id
  WHERE 
    DATE_PART('year', o.order_date) = 2020 AND
    cat.nombre_categoria ILIKE '%celulares%'
  GROUP BY mes, c.customer_id, c.nombre, c.apellido
),
ranked AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY mes ORDER BY total DESC) AS ranking
  FROM ventas
)
SELECT *
FROM ranked
WHERE ranking <= 5;


-- 3. Se solicita poblar una nueva tabla con el precio y estado de los Ítems a fin del día.
-- Tener en cuenta que debe ser reprocesable. Vale resaltar que en la tabla Item, vamos a tener únicamente el 
-- último estado informado por la PK definida. (Se puede resolver a través de StoredProcedure)
CREATE OR REPLACE PROCEDURE snapshot_item_state(p_fecha DATE)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO item_history (item_id, snapshot_date, precio, status)
    SELECT 
        item_id, 
        p_fecha, 
        precio, 
        status
    FROM item
    ON CONFLICT (item_id, snapshot_date) DO UPDATE
    SET precio = EXCLUDED.precio,
        status = EXCLUDED.status;
END;
$$;