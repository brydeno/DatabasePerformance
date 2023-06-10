USE [StackOverflow2013]
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
DROP INDEX [IX_DisplayName_Location] ON [dbo].[Users]
GO

ALTER TABLE dbo.Posts Add ReverseTitle nvarchar(250)

UPDATE dbo.Posts SET ReverseTitle = Reverse(Title)

GO

CREATE NONCLUSTERED INDEX [idxReverseTitle] ON [dbo].[Posts]
(
	[ReverseTitle] ASC
)
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



