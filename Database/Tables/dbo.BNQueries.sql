CREATE TABLE [dbo].[BNQueries]
(
[QueryId] [int] NOT NULL IDENTITY(1, 1),
[UserId] [uniqueidentifier] NOT NULL,
[ProjectId] [int] NOT NULL,
[QueryName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsPublic] [bit] NOT NULL CONSTRAINT [DF_BugNet_Queries_IsPublic] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNQueries] ADD CONSTRAINT [PK_BugNet_Queries] PRIMARY KEY CLUSTERED  ([QueryId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNQueries] ADD CONSTRAINT [FK_BugNet_Queries_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNQueries] ADD CONSTRAINT [FK_BugNet_Queries_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
