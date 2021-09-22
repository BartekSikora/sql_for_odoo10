-- Wykonanie zapytania pobierze plik CSV z listą produktów z informacjami gdzie się znajdują oraz w jakich ilościach.
-- Do otwarcia pliku sugerujemy OpenOffice Calc z zestawem znaków UTF-8. W Excel przy domyślnych ustawieniach mogą wystąpić problemy z formatowaniem liczb i polskich znaków.

SELECT 
product_template.name AS "Nazwa produktu", 
product_data.default_code AS "Kod produktu", 
product_data.barcode AS "Kod kreskowy", 
product_data.location_name AS "Strefa", 
product_data.quantity AS "Ilość" 
FROM 
( 
SELECT  
product_product.product_tmpl_id AS "id", 
product_product.default_code AS "default_code", 
product_product.barcode AS "barcode", 
stock_location.name AS "location_name", 
stock_quant.qty AS "quantity" 
FROM stock_quant
LEFT JOIN product_product ON product_product.id = stock_quant.product_id 
LEFT JOIN stock_location ON stock_location.id = stock_quant.location_id) AS product_data

LEFT JOIN product_template ON product_data.id = product_template.id

WHERE product_data.location_name NOT SIMILAR TO '%(Customers|Vendors|adjustment|Przyjęcia|Input)%'

ORDER BY product_template.name ASC
