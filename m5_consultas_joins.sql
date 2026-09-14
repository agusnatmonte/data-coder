USE Ventas_Tech_DB;


-- =====================================================================
-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- =====================================================================
SELECT
    v.fecha_Venta,
    c.nombre_Cliente                      AS cliente,
    c.ciudad,
    p.nombre_Producto,
    cat.nombre_Categoria                  AS categoria,
    v.cantidad,
    v.precio_Unitario,
    (v.cantidad * v.precio_Unitario)      AS total_venta
FROM Ventas v
JOIN Clientes c    ON v.id_Cliente = c.id_Cliente
JOIN Productos p   ON v.id_Producto = p.id_Productos
JOIN Categorias cat ON p.id_Categoria = cat.id_Categoria
ORDER BY v.fecha_Venta;


-- =====================================================================
-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- =====================================================================
SELECT
    c.nombre_Cliente,
    c.email,
    c.fecha_registro
FROM Clientes c
LEFT JOIN Ventas v ON c.id_Cliente = v.id_Cliente
WHERE v.id_Venta IS NULL;


-- =====================================================================
-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- =====================================================================
SELECT
    p.nombre_Producto,
    cat.nombre_Categoria AS categoria,
    p.precio_producto
FROM Productos p
INNER JOIN Categorias cat ON p.id_Categoria = cat.id_Categoria
LEFT JOIN Ventas v ON p.id_Productos = v.id_Producto
WHERE v.id_Venta IS NULL;


-- =====================================================================
-- Consulta 4: Consolidado por canal (UNION ALL)
-- =====================================================================
WITH ventas_con_canal AS (
    SELECT fecha_Venta, (cantidad * precio_Unitario) AS total, 'Primera quincena' AS canal
    FROM Ventas
    WHERE fecha_Venta < '2024-03-10'

    UNION ALL

    SELECT fecha_Venta, (cantidad * precio_Unitario) AS total, 'Segunda quincena' AS canal
    FROM Ventas
    WHERE fecha_Venta >= '2024-03-10'
)
SELECT
    canal,
    COUNT(*)      AS cantidad_ventas,
    SUM(total)    AS total_facturado
FROM ventas_con_canal
GROUP BY canal
ORDER BY canal;


-- =====================================================================
-- Hallazgos
-- =====================================================================
-- 1. Tras agregar a M3 un cliente y un producto sin ventas (id_Cliente=6,
--    Pablo Treyer, y id_Productos=7, Laptop Pro 14), las Consultas 2 y 3
--    ahora sí devuelven 1 fila cada una: Pablo Treyer nunca compró nada,
--    y la Laptop Pro 14 nunca se vendió. Antes de este agregado, ambas
--    consultas daban 0 filas porque los 5 clientes y los 6 productos
--    originales ya tenían movimiento — el caso NULL del LEFT JOIN no se
--    veía reflejado hasta sumar estos dos registros "sin actividad".
--
-- 2. La Primera quincena ($3.230) y la Segunda quincena ($3.214) de
--    marzo 2024 están casi parejas en facturación, a pesar de que la
--    Segunda tiene más transacciones (6 contra 4) — indica que la
--    Primera quincena tuvo ventas de mayor valor promedio por operación.
--
-- 3. En la vista consolidada de la Consulta 1, la categoría
--    "Computación" aparece en 4 de las 10 ventas (Laptop Pro 15 y
--    Monitor 4K), y son las de mayor monto individual — la misma
--    concentración que ya se había visto en el hallazgo de M4 sobre
--    el producto 1.