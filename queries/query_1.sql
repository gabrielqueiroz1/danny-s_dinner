-- Total gasto por cada cliente no restaurante

SELECT
    t1.customer_id,
    SUM(t2.price) AS total_gasto
FROM sales AS t1
LEFT JOIN menu AS t2
    ON t1.product_id = t2.product_id
GROUP BY 1
ORDER BY 2 DESC
