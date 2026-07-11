-- Qual foi o primeiro item comprado pelo cliente após ele se tornar membro?

WITH qry_combinacao_datas AS (
    SELECT
        t1.customer_id,
        DATE(t1.order_date) AS order_date,
        t1.product_id,
        DATE(t2.join_date) AS join_date
    FROM sales AS t1
    LEFT JOIN member AS t2
        ON t1.customer_id = t2.customer_id
),
qry_ranking AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date ASC) AS ranking
    FROM qry_combinacao_datas
    WHERE join_date IS NOT NULL
    AND order_date >= join_date
)
SELECT
    *
FROM qry_ranking
WHERE ranking = 1
