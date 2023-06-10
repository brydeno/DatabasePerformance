-- So there are 2 tables in this example
-- Votes contains all the votes
-- Votes1000 contains only 1000 votes
-- This illustrates the improvement you can get by 
-- archiving out old data. Maybe to separate archive tables,
-- or out to data warehouses / data lakes

SET STATISTICS IO ON;

SELECT * FROM dbo.votes1000
SELECT * FROM dbo.votes

-- So that first query came back in under 1 second. We're 
-- still waiting on the second query. Ok, so that kind of proves
-- the point. We won't wait for this, so take my word for it,
-- the stats are 7 reads for the small table and
-- a quarter of a million reads for the large and 
-- almost 4 minutes for the large one.
-- Other advantages are that we haven't trashed the buffer cache
-- when we selected 1000 rows, but the other query, our buffer
-- cache pretty much has just votes data now :(