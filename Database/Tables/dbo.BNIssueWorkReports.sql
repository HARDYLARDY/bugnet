CREATE TABLE [dbo].[BNIssueWorkReports]
(
[IssueWorkReportId] [int] NOT NULL IDENTITY(1, 1),
[IssueId] [int] NOT NULL,
[WorkDate] [datetime] NOT NULL,
[Duration] [decimal] (4, 2) NOT NULL,
[IssueCommentId] [int] NOT NULL,
[UserId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueWorkReports] ADD CONSTRAINT [PK_BugNet_IssueWorkReports] PRIMARY KEY CLUSTERED  ([IssueWorkReportId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueWorkReports] ADD CONSTRAINT [FK_BugNet_IssueWorkReports_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BNIssues] ([IssueId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNIssueWorkReports] ADD CONSTRAINT [FK_BugNet_IssueWorkReports_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
