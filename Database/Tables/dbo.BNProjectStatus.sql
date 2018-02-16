CREATE TABLE [dbo].[BNProjectStatus]
(
[StatusId] [int] NOT NULL IDENTITY(1, 1),
[ProjectId] [int] NOT NULL,
[StatusName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StatusImageUrl] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL,
[IsClosedState] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectStatus] ADD CONSTRAINT [PK_BugNet_ProjectStatus] PRIMARY KEY CLUSTERED  ([StatusId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectStatus] ADD CONSTRAINT [FK_BugNet_ProjectStatus_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
