-- So this one is a bit of a contrived example but it gives you the idea
-- First we'll create an index, this multiplies the effect of only selecting the columns we want

CREATE NONCLUSTERED INDEX [IX_DisplayName_Location] ON [dbo].[Users]
(
	[DisplayName] ASC,
	[Location] ASC
)
GO
--DROP INDEX [IX_DisplayName_Location] ON [dbo].[Users]
SET STATISTICS IO ON;

SELECT * FROM dbo.Users

SELECT DisplayName,Location FROM dbo.Users

-- So when we compare the performance, we see there are just over 3 times as many reads
-- required because it was able to read from the index only.
-- But there are advantages even with no indexes.
-- First of all the network transmission back to the caller is reduced.
-- Memory usage on both sides will be reduced