SET STATISTICS IO ON;

SELECT Title FROM dbo.Posts WHERE Title LIKE 'Why%'

SELECT Title FROM dbo.Posts WHERE Title LIKE '%statement'

-- If you must do this regularly and you know the % will be at the start
-- Create a column with the reverse of the string and index that.
-- I've created a column called ReverseTitle to demonstrate








SELECT reverse(ReverseTitle) FROM dbo.Posts WHERE ReverseTitle LIKE reverse('%statement')

-- As we can see looking for the same data we almost 1000 times less work. 
-- Wow, now that's worth the effort