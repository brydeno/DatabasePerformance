SET STATISTICS IO ON;

SELECT Id, Location, DownVotes FROM dbo.Users WHERE location = 'USA' OR DownVotes > 5
-- This first query does 50 scans and 2000 logical reads

SELECT Id, Location, DownVotes FROM dbo.Users WHERE location = 'USA'
UNION 
SELECT Id, Location, DownVotes FROM dbo.Users WHERE DownVotes > 5

-- The second query does 2 scans and only 500 logical reads. So we get the same data but with 4 times less work
-- Often you will get significantly better results than this. There is also a memory benefit to this too.