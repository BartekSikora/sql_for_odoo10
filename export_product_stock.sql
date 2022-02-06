-- Executing the query will return a CSV file containing a list of stock quants (full name of stock location, product, quantity, price, unit of measure).
-- Resulting CSV file is almost ready to be imported into Odoo13 database.  

SELECT
null AS "picking_type_id",
null AS "location_id",
REPLACE(stock_location.complete_name, 'Physical locations/', '') AS "location_dest_id",
CONCAT('[', stock.product_sku, '] ' , product_template.name) AS "move_lines/product_id",
stock.product_quantity AS "move_lines/product_uom_qty",
stock.product_cost AS "move_lines/price_unit",
product_template.uom_id AS "move_lines/product_uom",
'Stock import' AS "move_lines/name"
FROM
(
SELECT
stock_quant.location_id AS "location_id",
product_product.product_tmpl_id AS "template_id",
product_product.default_code as "product_sku",
stock_quant.qty AS "product_quantity",
stock_quant.cost AS "product_cost"
FROM stock_quant

LEFT JOIN stock_location ON stock_location.id = stock_quant.location_id
LEFT JOIN product_product ON product_product.id = stock_quant.product_id

--- W wierszu poniżej wpisać kod magazynu, z którego pobierać stany
WHERE stock_location.complete_name LIKE '%MG/%'
) AS "stock"

LEFT JOIN product_template ON stock.template_id = product_template.id
LEFT JOIN stock_location ON stock_location.id = stock.location_id

ORDER BY stock_location.complete_name ASC
