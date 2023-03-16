-- Here's our query

SELECT 
	Id, DisplayName, Location
FROM
	dbo.Users
WHERE 
	DisplayName = 'Frank'
	AND Location = 'United States'


-- Now let's rerun with an execution plan
-- At first it seems optimal

-- Let's visualise why it might not be.
SELECT 
	Id, DisplayName, Location
FROM
	dbo.Users
WHERE 
	DisplayName = 'Frank'
--	AND Location = 'United States'

-- If it were optimal all the United States records would be all together. 
-- Ok, so it's not really perfect for that we really want it to have a second ordering by Location

-- CREATE INDEX IX_DisplayName_Location ON dbo.Users (DisplayName,Location)

-- Let's try that (we want stats for this so)

--SET STATISTICS IO ON
--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users
--WHERE 
--	DisplayName = 'Frank'
--	AND Location = 'United States'

--do we think we could do better (maybe)
-- What's another option

-- Right now we find all the Franks, then all the ones in the United States
-- Would it be better to find all the users in the United States and then find the Frank's from them

-- So let's talk Selectivity now. (back to some slides for a few minutes)

-- CREATE INDEX IX_Location_DisplayName ON dbo.Users (Location,DisplayName)

-- Any guesses based on what you think the selectivity might be

-- I think User will have higher selectivity

-- Ok, so we've all guessed what we thought it might be, time to find out

--SET STATISTICS IO ON;
--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users WITH (Index = 1)
--WHERE 
--	DisplayName = 'Frank'
--	AND Location = 'United States'

--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users WITH (Index = IX_DisplayName_Location)
--WHERE 
--	DisplayName = 'Frank'
--	AND Location = 'United States'

--SELECT 
--	Id, DisplayName, Location
--FROM
--	dbo.Users WITH (Index = IX_Location_DisplayName)
--WHERE 
--	DisplayName = 'Frank'
--	AND Location = 'United States'


-- So our first index was the winner.
-- That's because it had lower selectivity on the first column in the index

-- Time to do housekeeping - It's super important after a tuning session to remember to do this :)

-- So the unused index is just causing extra overhead every time we modify a row in the table
-- So we should keep our db tidy

-- DROP INDEX IX_DisplayName_Location ON dbo.Users

-- Remember the index we made in the first demo
-- That's now of low value, it's just the same as our new index but with a random location order
-- That's not better for any query than the one we have, so 'You are the weakest link, goodbye'

-- DROP INDEX IX_DisplayName_Includes ON dbo.Users

