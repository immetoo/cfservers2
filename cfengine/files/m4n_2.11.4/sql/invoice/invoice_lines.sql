--Dineke, Nov 16, TODO: check whether we really need vat_due column. If so, the default for article should be true. Or we should work with null values or something!!!

--NOTE: the query get_invoice_lines_realtime.xpql in the m4n_main project is a copy of this query. When this one is updated, so should that one!!!
INSERT INTO history.invoice_line (
	payment_period_id,
	user_id,
	article_description_key,
	price
)
SELECT
	(SELECT max(id) FROM payment_period_id WHERE processed = true) AS payment_period_id
	invoice_line.merchant_id,
	CASE WHEN country != 'NL' THEN 'en_' ELSE '' END || article_description_key,
	price

FROM
	(
		SELECT 
			user_id AS merchant_id, 
			COALESCE(contact_info.country, company.country, 'NL') AS country 
		FROM 
			company
				LEFT JOIN
			contact_info ON(contact_info.company_id = company.id)
	) AS country,

	(SELECT
	user_id AS merchant_id,
	description_key AS article_description_key,
	price
FROM
	invoice_line,
	article
WHERE
	article_id = article.id

UNION ALL

SELECT
	merchant_id,
	'm4n' AS article_description_key,
	ROUND((SUM(views_cost + click_cost + lead_cost)::float )::numeric, 2) AS price
FROM
	statistics_per_day
WHERE
	status = 'ACCEPTED' AND
	payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = true)
GROUP BY
	merchant_id
HAVING
	SUM(views_cost + click_cost + lead_cost) > 0
) AS invoice_line

WHERE country.merchant_id = invoice_line.merchant_id;