SET STATISTICS IO ON;

SELECT DISTINCT OwnerUserId 
FROM dbo.Posts
WHERE AnswerCount > 5

SELECT OwnerUserId 
FROM dbo.Posts
WHERE AnswerCount > 5
GROUP BY OwnerUserId

-- Not a huge improvement here, just 0.1%. But the improvement should rise with more complicated queries.
-- The other advantage is any aggregates can get calculated at the same time, adding significant
-- performance gains.