-- So here we are showing what happens with a string column,
-- where we use an integer as the where clause in the second instance.
-- The second instance needs to scan the whole table and convert postid 
-- to an integer. Then it compares it to the value.
-- So in this example we do 10,000 times less work.


-- The plan tells us why. The first query just does an index seek 
-- straight to the data, the second one scans the whole index
-- to find the relevant rows.

SET STATISTICS IO ON;
SELECT * FROM dbo.VotesString WHERE PostId = '9999997'
SELECT * FROM dbo.VotesString WHERE PostId = 9999997
