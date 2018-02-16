CREATE TABLE [dbo].[BNProjectResolutions]
(
[ResolutionId] [int] NOT NULL IDENTITY(1, 1),
[ProjectId] [int] NOT NULL,
[ResolutionName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ResolutionImageUrl] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectResolutions] ADD CONSTRAINT [PK_BugNet_ProjectResolutions] PRIMARY KEY CLUSTERED  ([ResolutionId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectResolutions] ADD CONSTRAINT [FK_BugNet_ProjectResolutions_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
