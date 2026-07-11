WITH qry_classificacao_membro AS (
    SELECT
        t1.customer_id,
        t1.order_date,
        t2.product_name,
        t2.price,
        CASE
            WHEN t1.customer_id = t3.customer_id AND t1.order_date >= t3.join_date THEN 'Y'
        ELSE 'N'
        END AS 'membro'
    FROM sales AS t1
    LEFT JOIN menu AS t2
        ON t1.product_id = t2.product_id
    LEFT JOIN member AS t3
        ON t1.customer_id = t3.customer_id
),
qry_classificao_geral AS (
    SELECT
        *,
        RANK() OVER (PARTITION BY customer_id, membro ORDER BY order_date) AS classificacao_geral
    FROM qry_classificacao_membro
)

SELECT
    customer_id,
    order_date,
    product_name,
    price,
    membro,
    CASE
        WHEN membro = 'Y' THEN classificacao_geral
        ELSE NULL
    END AS 'classificacao'
FROM qry_classificao_geral