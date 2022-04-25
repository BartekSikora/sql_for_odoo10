-- This querry helps with migration of contacts from Odoo10 to Odoo13.

SELECT
CASE WHEN res_partner.type = 'contact' THEN 'Kontakt'
WHEN res_partner.type = 'invoice' THEN 'Adres do faktury'
WHEN res_partner.type = 'delivery' THEN 'Adres dostawy'
ELSE 'Other Address'
END AS "type",

CASE WHEN res_partner.is_company = 't' THEN 'Firma'
WHEN res_partner.is_company = 'f' THEN 'Indywidualne'
ELSE 'BŁĄD'
END AS "company_type",

CASE WHEN res_partner.customer = 't' THEN '1'
WHEN res_partner.customer = 'f' THEN '0'
ELSE '0'
END AS "customer_rank",

CASE WHEN res_partner.supplier = 't' THEN '1'
WHEN res_partner.supplier = 'f' THEN '0'
ELSE '0'
END AS "supplier_rank",

res_partner.name AS "name",
res_partner.street AS "street",
res_partner.zip AS "zip",
res_partner.city AS "city",
res_country.name AS "country_id",
res_partner.email AS "email",
res_partner.phone AS "phone",
res_partner.mobile AS "mobile",
res_partner.website AS "website",
res_partner.vat AS "vat",
res_partner.regon AS "regon",
res_partner.krs AS "krs",
res_partner.lang AS "lang"
FROM res_partner

LEFT JOIN res_country ON res_country.id = res_partner.country_id

WHERE res_partner.vat IS NOT NULL
