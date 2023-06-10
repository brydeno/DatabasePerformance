-- So what about inequality comparisons
-- They typically have much higher selectivity

-- First let's remove the previous indexes to get a baseline

-- DROP INDEX IX_DisplayName_Location ON dbo.Users
-- DROP INDEX IX_Location_DisplayName ON dbo.Users

-- Here's our query

SELECT 
	Id, DisplayName, Location
FROM
	dbo.Users
WHERE 
	DisplayName = 'Frank'
	AND Location <> 'United States'

-- so we evaluated 2 indexes last time let's see whether the inequality affects the outcome.

-- CREATE INDEX IX_DisplayName_Location ON dbo.Users (DisplayName,Location)
-- CREATE INDEX IX_Location_DisplayName ON dbo.Users (Location,DisplayName)

-- Let's try that (we want stats for this so)

-- SET STATISTICS IO ON
--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users
--WHERE 
--	DisplayName = 'Frank'
--	AND Location <> 'United States'

-- So which of the 2 indexes do you think will be better.
-- Location now has high selectivity, and displayname is still low.
-- So I think it'll be Displayname then Location but let's find out

--SET STATISTICS IO ON;
--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users WITH (Index = 1)
--WHERE 
--	DisplayName = 'Frank'
--	AND Location <> 'United States'

--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users WITH (Index = IX_DisplayName_Location)
--WHERE 
--	DisplayName = 'Frank'
--	AND Location <> 'United States'

--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users WITH (Index = IX_Location_DisplayName)
--WHERE 
--	DisplayName = 'Frank'
--	AND Location <> 'United States'

-- So our first index (Displayname then location) was the winner.
-- That's because it had lower selectivity on the first column in the index

-- Time to do housekeeping - It's super important after a tuning session to remember to do this :)

-- So the unused index is just causing extra overhead every time we modify a row in the table
-- So we should keep our db tidy

-- DROP INDEX IX_Location_DisplayName ON dbo.Users