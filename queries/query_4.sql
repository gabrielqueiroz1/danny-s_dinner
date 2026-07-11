-- Qual é o item mais pedido do cardápio e quantas vezes ele foi comprado por todos os clientes?
WITH qry_itens_comprados AS(
    SELECT
        t2.product_name,
        t1.product_id,
        COUNT(t1.product_id) AS qtd_pedido
    FROM sales AS t1
    LEFT JOIN menu AS t2
        ON t1.product_id = t2.product_id
    GROUP BY 1
    ORDER BY 2 DESC
),
qry_mais_comprado AS (
    SELECT
        product_id,
        MAX(qtd_pedido) AS qtd_pedido
    FROM qry_itens_comprados
)

SELECT
    t2.customer_id,
    t1.product_id,
    COUNT(t2.product_id) AS qtd_compra
FROM qry_mais_comprado AS t1
LEFT JOIN sales AS t2
    ON t1.product_id = t2.product_id
GROUP BY 1
