-- Qual item foi comprado imediatamente antes do cliente se tornar membro?

WITH qry_combinacao_datas AS (
    SELECT
        t1.customer_id,
        DATE(t1.order_date) AS order_date,
        t1.product_id,
        DATE(t2.join_date) AS join_date
    FROM sales AS t1
    LEFT JOIN member AS t2
        ON t1.customer_id = t2.customer_id
    WHERE t2.join_date IS NOT NULL
),
qry_dia_anterior AS (
    SELECT
        customer_id,
        product_id,
        order_date,
        LAG(order_date, 1) OVER (PARTITION BY customer_id ORDER BY order_date ASC) AS dia_anterior,
        join_date
    FROM qry_combinacao_datas
    WHERE order_date < join_date
),
qry_ranking AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date DESC) AS ranking
    FROM qry_dia_anterior
    WHERE dia_anterior IS NOT NULL
)
SELECT
    customer_id,
    product_id,
    order_date
FROM qry_ranking
WHERE ranking = 1