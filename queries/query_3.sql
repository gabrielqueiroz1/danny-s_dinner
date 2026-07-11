-- Qual foi o primeiro item do menu comprado por cada cliente?

WITH qry_rn AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date ASC) AS rn
    FROM sales
)
SELECT
    t1.customer_id,
    t2.product_id,
    t2.product_name
FROM qry_rn AS t1
LEFT JOIN menu AS t2
    ON t1.product_id = t2.product_id
WHERE t1.rn = 1
GROUP BY 1

