CREATE TABLE [dbo].[BNProjectIssueTypes]
(
[IssueTypeId] [int] NOT NULL IDENTITY(1, 1),
[ProjectId] [int] NOT NULL,
[IssueTypeName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IssueTypeImageUrl] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectIssueTypes] ADD CONSTRAINT [PK_BugNet_ProjectIssueTypes] PRIMARY KEY CLUSTERED  ([IssueTypeId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectIssueTypes] ADD CONSTRAINT [FK_BugNet_ProjectIssueTypes_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
