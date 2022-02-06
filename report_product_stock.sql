-- Wykonanie zapytania pobierze plik CSV z listą produktów z sumą stanów magazynowych ze wskazanych stref.
-- Do otwarcia pliku sugerujemy OpenOffice Calc z zestawem znaków UTF-8. W Excel przy domyślnych ustawieniach mogą wystąpić problemy z formatowaniem liczb i polskich znaków.

SELECT 
product_template.name AS "Produkt", 
product_product.default_code AS "SKU", 
SUM(stock_quant.qty) AS "Ilość"
FROM stock_quant 

LEFT JOIN product_product ON product_product.id = stock_quant.product_id 
LEFT JOIN product_template ON product_product.product_tmpl_id = product_template.id 

WHERE stock_quant.location_id IN (31, 37, 15, 43, 23, 42, 22)  

GROUP BY product_template.name, product_product.default_code

ORDER BY product_template.name
