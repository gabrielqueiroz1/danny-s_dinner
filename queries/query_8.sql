-- Qual o total de itens e o valor gasto por cada membro antes de se tornar membro?

WITH qry_total_itens AS (
    SELECT
        t1.customer_id,
        t1.product_id,
        t1.order_date,
        t3.price,
        SUM(t3.price) AS total_gasto
    FROM sales AS t1
    LEFT JOIN member AS t2
        ON t1.customer_id = t2.customer_id
        AND t2.customer_id IS NOT NULL
    LEFT JOIN menu AS t3
        ON t1.product_id = t3.product_id
    WHERE t1.order_date < t2.join_date
    GROUP BY 1, 2, 3
)
SELECT
    customer_id,
    product_id,
    order_date,
    total_gasto,
    SUM(price) OVER (PARTITION BY customer_id ORDER BY order_date ASC, product_id) AS total_gasto_acm,
    LAG(price) OVER (PARTITION BY customer_id ORDER BY order_date) AS lag_total_gasto,
    COUNT(product_id) OVER (PARTITION BY customer_id ORDER BY order_date ASC, product_id) AS total_itens_acm
FROM qry_total_itens