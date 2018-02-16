CREATE TABLE [dbo].[BNIssueHistory]
(
[IssueHistoryId] [int] NOT NULL IDENTITY(1, 1),
[IssueId] [int] NOT NULL,
[FieldChanged] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[OldValue] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NewValue] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateCreated] [datetime] NOT NULL CONSTRAINT [DF_BugNet_IssueHistory_DateCreated] DEFAULT (getdate()),
[UserId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueHistory] ADD CONSTRAINT [PK_BugNet_IssueHistory] PRIMARY KEY CLUSTERED  ([IssueHistoryId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueHistory] ADD CONSTRAINT [FK_BugNet_IssueHistory_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BNIssues] ([IssueId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNIssueHistory] ADD CONSTRAINT [FK_BugNet_IssueHistory_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE
GO
