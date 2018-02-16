CREATE TABLE [dbo].[BNIssueComments]
(
[IssueCommentId] [int] NOT NULL IDENTITY(1, 1),
[IssueId] [int] NOT NULL,
[DateCreated] [datetime] NOT NULL CONSTRAINT [DF_BugNet_IssueComments_DateCreated] DEFAULT (getdate()),
[Comment] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueComments] ADD CONSTRAINT [PK_BugNet_IssueComments] PRIMARY KEY CLUSTERED  ([IssueCommentId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueComments] ADD CONSTRAINT [FK_BugNet_IssueComments_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BNIssues] ([IssueId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNIssueComments] ADD CONSTRAINT [FK_BugNet_IssueComments_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE
GO
