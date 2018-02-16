CREATE TABLE [dbo].[BNUserProjects]
(
[UserId] [uniqueidentifier] NOT NULL,
[ProjectId] [int] NOT NULL,
[UserProjectId] [int] NOT NULL IDENTITY(1, 1),
[DateCreated] [datetime] NOT NULL,
[SelectedIssueColumns] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__BugNet_Us__Selec__7E42ABEE] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNUserProjects] ADD CONSTRAINT [PK_BugNet_UserProjects] PRIMARY KEY CLUSTERED  ([UserId], [ProjectId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNUserProjects] ADD CONSTRAINT [FK_BugNet_UserProjects_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNUserProjects] ADD CONSTRAINT [FK_BugNet_UserProjects_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE
GO
