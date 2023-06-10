SET STATISTICS IO ON;

SELECT p.CommentCount, p.CreationDate, u.DisplayName
FROM dbo.Users AS u, dbo.Posts AS p
WHERE p.OwnerUserId = u.Id
AND u.Location = 'USA';

SELECT p.CommentCount, p.CreationDate, u.DisplayName
FROM dbo.Users AS u
JOIN dbo.Posts AS p ON p.OwnerUserId = u.Id
WHERE u.Location = 'USA';

-- Notice the statistics are almost identical. However we do get to choose what type of join to do.
-- Also the optimizer won't always convert the WHERE to a JOIN. This means the execution won't 
-- always be the same (particularly for multiple JOINS).
