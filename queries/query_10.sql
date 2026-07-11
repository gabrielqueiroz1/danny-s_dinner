-- Na primeira semana após a adesão ao programa (incluindo a data de adesão),
-- o cliente ganha o dobro de pontos em todos os itens, não apenas em sushi.
-- Quantos pontos os clientes A e B têm no final de janeiro?

WITH qry_diff_data AS (
    SELECT
        t1.customer_id,
        t1.product_id,
        t3.price,
        t1.order_date,
        t2.join_date,
        JULIANDAY(t1.order_date) - JULIANDAY(t2.join_date) AS diff_data,
        t3.price * 2 AS pontos_dobro
    FROM sales AS t1
    LEFT JOIN member AS t2
        ON t1.customer_id = t2.customer_id
    LEFT JOIN menu AS t3
        ON t1.product_id = t3.product_id
    WHERE t1.order_date >= t2.join_date
)
SELECT
    customer_id,
    SUM(pontos_dobro) AS total_pontos
FROM qry_diff_data
WHERE diff_data < 8
GROUP BY 1