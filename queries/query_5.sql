-- Qual foi o item mais popular entre cada cliente?

WITH qry_qtd_compra AS (
    SELECT
        customer_id,
        product_id,
        COUNT(product_id) qtd_compra
    FROM sales
    GROUP BY 1, 2
),
qry_rank AS (
    SELECT
        *,
        RANK() OVER (PARTITION BY customer_id ORDER BY qtd_compra DESC) AS ranking
    FROM qry_qtd_compra
)

SELECT
    *
FROM qry_rank
WHERE ranking = 1