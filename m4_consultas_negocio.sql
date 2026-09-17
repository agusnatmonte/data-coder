-- Consulta 1: Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio, por mes.
-- =====================================================================
SELECT
    MONTH(fecha_venta)                      AS mes,
    SUM(cantidad * precio_unitario)         AS total_facturado,
    COUNT(*)                                AS cantidad_pedidos,
    AVG(cantidad * precio_unitario)         AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- =====================================================================
-- Consulta 2: Ranking de productos
-- Top 5 productos por total facturado, con unidades vendidas.
-- =====================================================================
SELECT TOP 5
    id_producto,
    SUM(cantidad)                           AS unidades_vendidas,
    SUM(cantidad * precio_unitario)         AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
 
 
-- =====================================================================
-- Consulta 3: Clientes recurrentes
-- Clientes con más de un pedido, cantidad de pedidos y total gastado.
-- =====================================================================
SELECT
    id_cliente,
    COUNT(*)                                AS cantidad_pedidos,
    SUM(cantidad * precio_unitario)         AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;
 
 
-- =====================================================================
-- Consulta 4: Meses por encima/por debajo del promedio
-- Total facturado por mes, etiquetado contra el promedio mensual general.
-- =====================================================================
WITH ventas_por_mes AS (
    SELECT
        MONTH(fecha_venta)                  AS mes,
        SUM(cantidad * precio_unitario)     AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)
SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado >= (SELECT AVG(total_facturado) FROM ventas_por_mes)
            THEN 'Por encima'
        ELSE 'Por debajo'
    END                                      AS comparacion_promedio
FROM ventas_por_mes
ORDER BY mes;
 
 
-- =====================================================================
-- Hallazgos
-- =====================================================================
-- 1. El producto 1 (Laptop Pro 15) concentra el 55,9% de la facturación
--    total ($3.600 de $6.444), muy por encima del resto de los productos:
--    es, por lejos, el que más ingresos genera de todo el catálogo.
--
-- 2. Los 5 clientes cargados compraron exactamente 2 veces cada uno.
--    No hay ningún cliente de compra única en esta muestra, así que la
--    consulta de clientes recurrentes devuelve el 100% de la base actual.
--
-- 3. Las 10 ventas cargadas en Ventas_Tech_DB caen todas en marzo de 2024, así que
--    el agrupado mensual (consultas 1 y 4) devuelve una sola fila. Para
--    ver variación real entre meses hace falta cargar transacciones de
--    otros períodos.