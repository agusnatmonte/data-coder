RetailPro — Análisis de Ventas de Tecnología

Proyecto final del curso de Data Analytics (CoderHouse). RetailPro es un caso de negocio simulado de una distribuidora de tecnología, sobre el cual se modela una base de datos relacional, se construyen consultas de análisis y se diseña un dashboard ejecutivo para entender la evolución de las ventas, identificar qué categorías y segmentos de clientes explican los resultados, y detectar dónde reforzar la acción comercial.

📌 Descripción del proyecto

El proyecto parte de un problema de negocio (caída/evolución de ventas en la categoría Tecnología) y recorre todo el flujo de un análisis de datos:

Definición del problema y KPIs — brief inicial con preguntas de negocio, fuentes de datos y boceto de dashboard.
Modelado de datos — diagrama entidad-relación normalizado (3NF).
Implementación de la base de datos — creación del esquema y carga de datos en SQL Server.
Consultas de negocio — agregaciones, rankings, clientes recurrentes y comparación contra promedios.
Consultas con JOINs — vista consolidada, detección de clientes/productos sin actividad y consolidados por período.
Dashboard — visualización ejecutiva de los KPIs y hallazgos.
🗂️ Estructura de la base de datos

La base Ventas_Tech_DB tiene 4 tablas:

Tabla	Descripción
Categorias	Categorías de producto (Computación, Accesorios, Audio, Almacenamiento)
Clientes	Datos de clientes (nombre, email, ciudad, fecha de registro)
Productos	Catálogo de productos, con id_Categoria como FK
Ventas	Tabla de hechos, con id_Cliente e id_Producto como FK
📁 Archivos del repositorio
Archivo	Descripción
Ventas_Tech_DB.sql	Script de creación de la base: DROP/CREATE de las 4 tablas y carga de datos de ejemplo (categorías, clientes, productos y ventas de marzo 2024)
m4_consultas_negocio.sql	Consultas de negocio: resumen ejecutivo mensual, ranking de productos, clientes recurrentes y comparación de meses contra el promedio
m5_consultas_joins.sql	Consultas con JOINs: vista base consolidada (INNER JOIN), clientes sin ventas y productos sin ventas (LEFT JOIN), y consolidado por período (UNION ALL)
boceto_dashboard_retailpro__Montenegro.png	Boceto/diseño del dashboard ejecutivo de RetailPro
🛠️ Herramientas utilizadas
SQL Server (T-SQL) vía SQL Server Management Studio (SSMS) — modelado, carga y consultas.
draw.io — diagrama entidad-relación del modelo de datos.
GitHub — versionado y entrega de los checkpoints del proyecto.
Power BI 
▶️ Cómo ejecutar los scripts
Crear y poblar la base de datos
Abrir Ventas_Tech_DB.sql en SSMS (o cualquier cliente compatible con T-SQL / SQL Server).
Ejecutar el script completo. Esto va a:
Crear la base Ventas_Tech_DB.
Eliminar las tablas si ya existen (en el orden correcto para respetar las foreign keys: Ventas → Productos → Clientes → Categorias).
Crear las 4 tablas con sus relaciones.
Insertar los datos de ejemplo (categorías, clientes, productos y ventas).
Correr SELECT * FROM sobre cada tabla para verificar la carga.
Ejecutar las consultas de negocio
Con la base ya creada, abrir m4_consultas_negocio.sql.
Ejecutar cada consulta (o el script completo) para obtener:
Resumen ejecutivo mensual (facturación, pedidos, ticket promedio).
Top 5 productos por facturación.
Clientes recurrentes (más de un pedido).
Meses por encima/por debajo del promedio de facturación.
Al final del script hay una sección de Hallazgos con la interpretación de los resultados.
Ejecutar las consultas con JOINs
Con la base ya creada (y sobre la misma conexión/base activa vía USE Ventas_Tech_DB;), abrir m5_consultas_joins.sql.
Ejecutar cada consulta para obtener:
Vista base consolidada del proyecto (ventas + cliente + producto + categoría).
Clientes sin ventas registradas.
Productos sin ventas registradas.
Consolidado de ventas por período (primera vs. segunda mitad de marzo).
También incluye una sección de Hallazgos al final.

⚠️ Los scripts están escritos en T-SQL (sintaxis de SQL Server), por lo que funciones como TOP no son directamente compatibles con MySQL/PostgreSQL sin adaptación (equivalente a LIMIT).

📊 Dashboard

El boceto (boceto_dashboard_retailpro__Montenegro.png) muestra el diseño del dashboard ejecutivo de RetailPro, con:

KPIs principales: Total de Ventas, Ticket Promedio, Crecimiento vs. período anterior, Clientes Activos.
Evolución de ventas diarias (gráfico de línea).
Facturación por ciudad de cliente (gráfico de barras).
Detalle transaccional filtrable, basado en la vista consolidada de m5_consultas_joins.sql (Consulta 1).

La lógica de diseño prioriza una lectura ejecutiva rápida en la parte superior (KPIs + gráficos) y deja el detalle transaccional disponible "bajo demanda" para auditar ventas puntuales.

📌 Hallazgos clave
La categoría Computación concentra el 76,8% de la facturación total ($4.950 de $6.444) — muy por encima de Accesorios, Almacenamiento y Audio combinados. Es la dependencia más fuerte que muestra el análisis, y el eje del gráfico comparativo del dashboard.
La facturación entre la primera y segunda mitad de marzo 2024 es similar en monto total ($3.230 vs. $3.214), pero el ticket promedio cuenta la historia real: $807,50 en la primera mitad contra $535,67 en la segunda — menos ventas, pero de mayor valor cada una.
De los 6 clientes registrados, 5 ya compraron más de una vez y solo 1 (Pablo Treyer) nunca convirtió — un caso concreto de cliente captado pero no activado, detectado con el LEFT JOIN de la Consulta 2 de M5.
Todas las ventas cargadas caen en marzo de 2024, por lo que el análisis mensual (M4) devuelve una única fila.

Proyecto desarrollado como entrega final del curso de Data Analytics en CoderHouse.
