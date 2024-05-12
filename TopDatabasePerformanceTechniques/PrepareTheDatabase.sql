USE [StackOverflow2013]
GO
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] like 'Votes1000') 
BEGIN
   DROP TABLE Votes1000;
END;
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] like 'VotesString') 
BEGIN
   DROP TABLE VotesString;
END;
DROP INDEX IF Exists [IX_DisplayName_Location] ON [dbo].[Users]
DROP INDEX IF Exists [IX_DownVotes] ON [dbo].[Users]
GO
DROP INDEX IF Exists [idxReverseTitle] ON [dbo].[Posts]
DROP INDEX IF Exists [idxTitle] ON [dbo].[Posts]
GO
CREATE TABLE [dbo].[Votes1000](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PostId] [int] NOT NULL,
	[UserId] [int] NULL,
	[BountyAmount] [int] NULL,
	[VoteTypeId] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Votes_Id1000] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO
INSERT INTO [dbo].[Votes1000]
           ([PostId]
           ,[UserId]
           ,[BountyAmount]
           ,[VoteTypeId]
           ,[CreationDate])
SELECT TOP (1000)[PostId]
      ,[UserId]
      ,[BountyAmount]
      ,[VoteTypeId]
      ,[CreationDate]
  FROM [StackOverflow2013].[dbo].[Votes]
GO

IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[Posts]') 
         AND name = 'ReverseTitle'
)
ALTER TABLE dbo.Posts Add ReverseTitle nvarchar(250)

UPDATE dbo.Posts SET ReverseTitle = Reverse(Title)

GO
CREATE NONCLUSTERED INDEX [idxTitle] ON [dbo].[Posts]
(
	[Title] ASC
)
GO
CREATE NONCLUSTERED INDEX [idxReverseTitle] ON [dbo].[Posts]
(
	[ReverseTitle] ASC
)
GO
CREATE INDEX IX_DownVotes ON dbo.Users (DownVotes)
GO
CREATE TABLE [dbo].[VotesString](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PostId] NVarChar(20) NOT NULL,
	[UserId] [int] NULL,
	[BountyAmount] [int] NULL,
	[VoteTypeId] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_VotesString_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

CREATE NONCLUSTERED INDEX [idxVotesStringPostId] ON [dbo].[VotesString]
(
	[PostId] ASC
)
INSERT INTO [dbo].[VotesString]
           ([PostId]
           ,[UserId]
           ,[BountyAmount]
           ,[VoteTypeId]
           ,[CreationDate])
SELECT [PostId]
      ,[UserId]
      ,[BountyAmount]
      ,[VoteTypeId]
      ,[CreationDate]
  FROM [StackOverflow2013].[dbo].[Votes]

Create NONCLUSTERED INDEX [LOCDOWNV] ON [dbo].[users]
( 
Location ASC,
DownVotes ASC
)
Create NONCLUSTERED INDEX [DOWNVLOC] ON [dbo].[users]
( 
DownVotes ASC,
Location ASC
)



