-- Wykonanie zapytania pobierze plik CSV z listą produktów oraz ich podstawowymi i meta- danymi.
-- Do otwarcia pliku sugerujemy OpenOffice Calc z zestawem znaków UTF-8. W Excel przy domyślnych ustawieniach mogą wystąpić problemy z formatowaniem liczb i polskich znaków.

SELECT
CASE WHEN product_template.active = 't' THEN 'Tak'
WHEN product_template.active = 'f' THEN 'Nie'
ELSE 'BŁĄD'
END AS "Aktywny",

CASE WHEN product_template.type = 'product' THEN 'Rejestrowany'
WHEN product_template.type = 'service' THEN 'Usługa'
WHEN product_template.type = 'consu' THEN 'Pomocniczy'
ELSE 'BŁĄD'
END AS "Typ",

product_template.name AS "Produkt",
product_product.default_code AS "SKU",
product_product.barcode AS "Kod kreskowy",
product_product.gtu AS "GTU",
product_template.list_price AS "Cena sprzedaży",

CASE WHEN product_uom.name = 'Unit(s)' THEN 'Sztuki'
ELSE product_uom.name
END AS "Jednostka miary",

product_category.name AS "Kategoria",
product_product.weight AS "Waga",
product_template.length AS "Długość",
product_template.width AS "Szerokość",
product_template.height AS "Wysokość",

CASE WHEN product_template.sale_ok = 't' THEN 'Tak'
WHEN product_template.sale_ok = 'f' THEN 'Nie'
ELSE 'BŁĄD'
END AS "Może być sprzedawany",

CASE WHEN product_template.purchase_ok = 't' THEN 'Tak'
WHEN product_template.purchase_ok = 'f' THEN 'Nie'
ELSE 'BŁĄD'
END AS "Może być kupowany"

FROM product_template

LEFT JOIN product_product ON product_product.product_tmpl_id = product_template.id
LEFT JOIN product_uom ON product_uom.id = product_template.uom_id
LEFT JOIN product_category ON product_category.id = product_template.categ_id

ORDER BY product_template.name
