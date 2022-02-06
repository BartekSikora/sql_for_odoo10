-- Wykonanie zapytania pobierze plik CSV zawierający listę ilości i ceny jednostkowe produktów przesuniętych przez dokumenty danego typu w danym okresie. 
-- W Excelu może występować problem z formatem dat. W takim przypadku plik należy otworzyć przy użyciu darmowego OpenOffice Calc. 

SELECT 
stock_picking.name AS "Numer przesunięcia", 
stock_move.name AS "Opis pozycji", 
stock_move.product_uom_qty AS "Ilość", 
stock_move.price_unit AS "Cena jednostkowa",
ROUND(stock_move.product_uom_qty * stock_move.price_unit, 2) AS "Suma"
FROM stock_picking 

LEFT JOIN stock_move ON stock_move.picking_id = stock_picking.id 

-- W wierszu poniżej należy wprowadzić numerację przesunięć oraz zakres dat ich wykonania.
WHERE stock_picking.name LIKE 'MG/WZ/%' AND stock_picking.date_done BETWEEN '2021-01-01 00:00:00' AND '2021-01-31 23:59:59'
