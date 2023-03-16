-- Let's take a typical join query

SELECT 
	u.DisplayName,
	c.CreationDate,
	c.Text
FROM
	dbo.Users u
	INNER JOIN dbo.Comments c ON u.Id = c.UserId
Where
	u.DisplayName = 'Jernej Kavka'

-- Jernej (JK) is a friend of mine, he talks widely on AI and Entity Framework.
-- We run a workshop version of this presentation along with Entity Framework and more advanced DB topics.
-- Keep an eye out for that.

-- First of all, Users seemed to be cheap to find what we wanted, but remember we already fixed that in the previous demos :)

-- SQL Server selected an index for us again, lets evaluate that suggestion.
-- Hmmm Text is a giant column, we normally choose indexes to be small and efficient.
-- Anyway, this will be a good test of that.

-- So it's suggesting,
-- CREATE INDEX IX_UserId_INCLUDES_CreationDate_Text on dbo.Comments (UserId) INCLUDE (CreationDate, Text)

-- To save index space we could try
-- CREATE INDEX IX_UserId_INCLUDES_CreationDate on dbo.Comments (UserId) INCLUDE (CreationDate)

SET STATISTICS IO ON;

--SELECT 
--	u.DisplayName,
--	c.CreationDate,
--	c.Text
--FROM
--	dbo.Users u
--	INNER JOIN dbo.Comments c WITH (INDEX = 1) ON u.Id = c.UserId 
--Where
--	u.DisplayName = 'Jernej Kavka'

--SELECT 
--	u.DisplayName,
--	c.CreationDate,
--	c.Text
--FROM
--	dbo.Users u
--	INNER JOIN dbo.Comments c WITH (INDEX = IX_UserId_INCLUDES_CreationDate_Text) ON u.Id = c.UserId
--Where
--	u.DisplayName = 'Jernej Kavka'

--SELECT 
--	u.DisplayName,
--	c.CreationDate,
--	c.Text
--FROM
--	dbo.Users u
--	INNER JOIN dbo.Comments c WITH (INDEX = IX_UserId_INCLUDES_CreationDate) ON u.Id = c.UserId
--Where
--	u.DisplayName = 'Jernej Kavka'


-- So very similar performance, let's look at index size
-- Right click on the index in the tree, go to Fragmentation
-- Pages is the figure we care about

-- The index with text is almost 15 times bigger and only provides marginally better performance
-- I'd normally choose the smaller index in this situation, but if you often run this query
-- where you expect a large number of results, it might be better overall.

