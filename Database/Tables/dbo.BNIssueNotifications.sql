CREATE TABLE [dbo].[BNIssueNotifications]
(
[IssueNotificationId] [int] NOT NULL IDENTITY(1, 1),
[IssueId] [int] NOT NULL,
[UserId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueNotifications] ADD CONSTRAINT [PK_BugNet_IssueNotifications] PRIMARY KEY CLUSTERED  ([IssueNotificationId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueNotifications] ADD CONSTRAINT [FK_BugNet_IssueNotifications_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BNIssues] ([IssueId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNIssueNotifications] ADD CONSTRAINT [FK_BugNet_IssueNotifications_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE
GO
