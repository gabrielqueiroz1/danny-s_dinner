-- Há quantos dias cada cliente visita o restaurante?
-- Resposta dias visitados: A -> 6 / B -> 6 / C -> 3
-- Resposta média de dias para visitar o restaurante: A -> 2 / B -> 6.2 / C -> 3

WITH qry_geral  AS (
    SELECT
        customer_id,
        DATE(order_date) AS order_date
    FROM sales

),
qry_dias_frequentados AS (
    SELECT
        customer_id,
        COUNT(*) AS qtd_dias_frequentados
    FROM qry_geral
    GROUP BY 1
),
qry_dia_anterior AS (
    SELECT
        customer_id,
        order_date,
        LAG(order_date, 1) OVER (PARTITION BY customer_id ORDER BY order_date) AS dia_anterior
    FROM sales
),
qry_recorrencia AS (
    SELECT
        *,
        JULIANDAY(order_date) - JULIANDAY(dia_anterior) AS diff_date
    FROM qry_dia_anterior
    WHERE dia_anterior IS NOT NULL
),
qry_media_dia AS (
    SELECT
        customer_id,
        AVG(diff_date) AS media_visita
    FROM qry_recorrencia
    GROUP BY 1
    ORDER BY 2 DESC
)

SELECT
    *
FROM qry_dias_frequentados