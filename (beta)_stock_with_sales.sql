SELECT 
DISTINCT(product_stock.default_code) AS "SKU", 
product_stock.qty AS "Stan magazynowy", 
ROUND(SUM(account_invoice_line.quantity), 2) AS "Sprzedana ilość" 
FROM 
( 
SELECT 
product_product.id AS product_id, 
product_product.default_code AS default_code, 
SUM(qty) AS qty
FROM stock_quant

LEFT JOIN product_product ON product_product.id = stock_quant.product_id 

WHERE stock_quant.location_id IN (15, 22, 23, 31, 37, 42, 43)

GROUP BY product_product.id, product_product.default_code) AS product_stock

LEFT JOIN account_invoice_line ON account_invoice_line.product_id = product_stock.product_id 

GROUP BY product_stock.default_code, product_stock.qty
