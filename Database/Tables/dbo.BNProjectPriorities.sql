CREATE TABLE [dbo].[BNProjectPriorities]
(
[PriorityId] [int] NOT NULL IDENTITY(1, 1),
[ProjectId] [int] NOT NULL,
[PriorityName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PriorityImageUrl] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectPriorities] ADD CONSTRAINT [PK_BugNet_ProjectPriorities] PRIMARY KEY CLUSTERED  ([PriorityId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectPriorities] ADD CONSTRAINT [FK_BugNet_ProjectPriorities_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
