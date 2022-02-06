-- Wykonanie zapytania pobierze plik CSV zawierający listę użytkowników oraz ilości produktów, które zafakturowali.
-- Do otwarcia pliku sugerujemy OpenOffice Calc z zestawem znaków UTF-8. W Excel przy domyślnych ustawieniach mogą wystąpić problemy z formatowaniem liczb i polskich znaków.

SELECT
res_users.user_mail_name AS "Sprzedawca",
ROUND(SUM(account_invoice_line.quantity), 0) AS "Suma sprzedanych produktów"
FROM account_invoice

LEFT JOIN res_users ON res_users.id = account_invoice.user_id
LEFT JOIN account_invoice_line ON account_invoice.id = account_invoice_line.invoice_id

WHERE account_invoice.type = 'out_invoice'
AND  account_invoice.state <> 'draft'
AND  account_invoice.state <> 'cancel'
AND res_users.user_mail_name <> 'Administrator IDEAerp'
-- W wierszu poniżej należy zdefiniować zakres dat wystawienia dokumentów sprzedaży
AND account_invoice.date_invoice BETWEEN '2021-02-01' AND '2021-02-28'
-- W wierszach poniżej należy wypisać produkty, które mają być pomijane w raporcie.
AND account_invoice_line.name NOT ILIKE '%SHIP%'  

GROUP BY res_users.user_mail_name

ORDER BY res_users.user_mail_name
