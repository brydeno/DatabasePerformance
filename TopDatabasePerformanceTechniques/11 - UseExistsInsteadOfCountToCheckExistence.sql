SET STATISTICS IO ON;

-- This is an optimization where you want to know if there are any records.
-- Often people will just do a simple count and then write an if statement in their code

SELECT COUNT(*) FROM dbo.Posts WHERE Title LIKE 'Why%'


-- But you can use the Exists clause like this. The server will short circuit and stop looking
-- as soon as 1 row matches. That ends up 500 times faster here, also super fast even with no match :)

SELECT 1 WHERE EXISTS ( SELECT title FROM dbo.Posts WHERE Title LIKE 'Why%')


-- But wait you say, what about where nothing matches, do we get the same effect
SELECT COUNT(*) FROM dbo.Posts where Title like 'rewjtkl%'
SELECT 1 WHERE EXISTS ( SELECT title FROM dbo.Posts WHERE Title LIKE 'rewjtkl%')

-- nowehere near the improvement, but the positive case makes this well worth while.