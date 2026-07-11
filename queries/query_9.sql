-- Se cada dólar gasto equivale a 10 pontos e o sushi tem um multiplicador de pontos de 
-- 2x, quantos pontos cada cliente teria?

SELECT
    t1.customer_id,
    SUM(CASE
        WHEN product_name = 'sushi' THEN (price * 10) * 2
    ELSE price * 10 END) AS pontos
FROM sales AS t1
LEFT JOIN menu AS t2
    ON t1.product_id = t2.product_id
GROUP BY 1