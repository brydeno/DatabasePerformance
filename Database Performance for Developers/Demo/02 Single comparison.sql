-- Here's our query

SELECT 
	Id, DisplayName, Location
FROM
	dbo.Users
WHERE 
	DisplayName = 'Frank'

-- Now let's rerun with an execution plan

-- Ooh wow it suggested an index

-- CREATE INDEX IX_DisplayName ON dbo.Users (DisplayName)

-- Let's try that (we want stats for this so)

-- SET STATISTICS IO ON
--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users
--WHERE 
--	DisplayName = 'Frank'

--do we think we could do better (maybe)







-- CREATE INDEX IX_DisplayName_Includes ON dbo.Users (DisplayName) INCLUDE (Location)
-- Before we go on, naming conventions (some people name like that). 
-- I use Brent Ozar's convention. He's a great resource (more on resources later)

-- Ok, so time to test again 

--SET STATISTICS IO ON;
--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users
--WHERE 
--	DisplayName = 'Frank'

-- So let's look at the Execution plan, did it use our index.

-- Ok, so which option is best, it's testing time

--SET STATISTICS IO ON;
--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users WITH (Index = 1) -- use the primary key for a baseline
--WHERE 
--	DisplayName = 'Frank'

--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users WITH (Index = IX_DisplayName)
--WHERE 
--	DisplayName = 'Frank'

--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users WITH (Index = IX_DisplayName_Includes)
--WHERE 
--	DisplayName = 'Frank'

-- So our index was the winner and was nearly 10,000 times better than without any index.
-- So the unused index is just causing extra overhead every time we modify a row in the table
-- So we should keep our db tidy

-- DROP INDEX IX_DisplayName ON dbo.Users




