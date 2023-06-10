-- Note optimising to avoid looping generally simplifies the SQL too
-- That's especially true for this example
-- The first example takes a long time, so I ran it earlier, let's read the code then investigate :)
SET STATISTICS IO ON;

DECLARE @TotalPosts INT
DECLARE @TotalAnswerCount DECIMAL(10, 2)
DECLARE @CurrentPostID INT
DECLARE @CurrentAnswerCount DECIMAL(10, 2)
DECLARE @MaxAnswerCount INT
SET @TotalPosts = 0
SET @TotalAnswerCount = 0
SET @MaxAnswerCount = 0

DECLARE PostsCursor CURSOR FOR
SELECT Id, AnswerCount
FROM dbo.Posts

OPEN PostsCursor
FETCH NEXT FROM PostsCursor INTO @CurrentPostId, @CurrentAnswerCount

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @TotalPosts = @TotalPosts + 1
    SET @TotalAnswerCount = @TotalAnswerCount + @CurrentAnswerCount

    FETCH NEXT FROM PostsCursor INTO @CurrentPostId, @CurrentAnswerCount
END

CLOSE PostsCursor
DEALLOCATE PostsCursor

SELECT @TotalAnswerCount / @TotalPosts


-- And here's the simplified version

SELECT AVG(AnswerCount),MAX(AnswerCount) AS AverageAnswerCount
FROM dbo.Posts


