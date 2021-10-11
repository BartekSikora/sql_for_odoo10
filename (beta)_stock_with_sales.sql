-- Wykonanie zapytania pobierze plik CSV z listą produktów, ich stanem magazynowym z wybranych stref oraz sprzedażą na podstawie faktur
-- Do otwarcia pliku sugerujemy OpenOffice Calc z zestawem znaków UTF-8. W Excel przy domyślnych ustawieniach mogą wystąpić problemy z formatowaniem liczb i polskich znaków.

SELECT 
DISTINCT(product_stock.default_code) AS "SKU", 
product_template.name AS "Produkt",
product_stock.qty AS "Stan magazynowy", 

CASE WHEN ROUND(SUM(account_invoice_line.quantity)) > 0 THEN ROUND(SUM(account_invoice_line.quantity))
ELSE '0'
END AS "Sprzedana ilość" 

FROM 
( 
SELECT 
product_product.id AS product_id, 
product_product.default_code AS default_code, 
product_product.product_tmpl_id AS template_id,
SUM(qty) AS qty
FROM stock_quant

LEFT JOIN product_product ON product_product.id = stock_quant.product_id 

WHERE stock_quant.location_id IN (15, 22, 23, 31, 37, 42, 43)

GROUP BY product_product.id, product_product.default_code) AS product_stock

LEFT JOIN account_invoice_line ON account_invoice_line.product_id = product_stock.product_id 
LEFT JOIN product_template ON product_template.id = product_stock.template_id

GROUP BY product_stock.default_code, product_template.name, product_stock.qty

ORDER BY "Sprzedana ilość" DESC
