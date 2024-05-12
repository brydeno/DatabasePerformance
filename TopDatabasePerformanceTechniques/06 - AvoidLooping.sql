-- Note optimising to avoid looping generally simplifies the SQL too
-- That's especially true for this example
-- The first example takes a long time, so I've capped it at 1000 rows. Read the code then investigate :)
-- Even the 1000 rows takes the same time as the non looping. But it's 3 logical reads per row.
-- The second solution does 1 logical read for every 4 rows. So it's doing 12 times less reads, and also doing it superefficiently.
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

-- We'll cap this loop at 1000 to avoid SSMS crashing with the stats turned on.
WHILE (@@FETCH_STATUS = 0) AND (@TotalPosts < 1000)
BEGIN
    SET @TotalPosts = @TotalPosts + 1
    SET @TotalAnswerCount = @TotalAnswerCount + @CurrentAnswerCount

    FETCH NEXT FROM PostsCursor INTO @CurrentPostId, @CurrentAnswerCount
END

CLOSE PostsCursor
DEALLOCATE PostsCursor

SELECT @TotalAnswerCount,@TotalPosts,@TotalAnswerCount / @TotalPosts


-- And here's the simplified version

SELECT Count(AnswerCount),AVG(Convert(Decimal,AnswerCount)),MAX(AnswerCount) AS AverageAnswerCount
FROM dbo.Posts


