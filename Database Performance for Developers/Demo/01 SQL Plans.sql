-- Turn on Include Execution Plan to get back a query plan
SET STATISTICS IO ON;

SELECT
	Count(v.Id),u.DisplayName
FROM
	dbo.Users u
	JOIN dbo.Votes v ON v.UserId = u.Id
GROUP BY
	u.DisplayName