CREATE TABLE [dbo].[BNProjectIssueFields]
(
[ProjectIssueFieldId] [int] NOT NULL IDENTITY(1, 1),
[ProjectId] [int] NOT NULL,
[IssueFieldId] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IssueFieldRequired] [bit] NOT NULL,
[IssueFieldShowOnNewIssue] [bit] NOT NULL,
[IssueFieldShowOnEditIssue] [bit] NOT NULL,
[SortOrder] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectIssueFields] ADD CONSTRAINT [PK_BugNet_ProjectIssueFields] PRIMARY KEY CLUSTERED  ([ProjectIssueFieldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectIssueFields] ADD CONSTRAINT [FK_BugNet_ProjectIssueFields_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId])
GO
