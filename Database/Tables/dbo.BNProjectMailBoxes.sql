CREATE TABLE [dbo].[BNProjectMailBoxes]
(
[ProjectMailboxId] [int] NOT NULL IDENTITY(1, 1),
[MailBox] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProjectId] [int] NOT NULL,
[AssignToUserId] [uniqueidentifier] NULL,
[IssueTypeId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectMailBoxes] ADD CONSTRAINT [PK_BugNet_ProjectMailBoxes] PRIMARY KEY CLUSTERED  ([ProjectMailboxId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectMailBoxes] ADD CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_ProjectIssueTypes] FOREIGN KEY ([IssueTypeId]) REFERENCES [dbo].[BNProjectIssueTypes] ([IssueTypeId])
GO
ALTER TABLE [dbo].[BNProjectMailBoxes] WITH NOCHECK ADD CONSTRAINT [FK_BugNet_ProjectMailBoxes_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNProjectMailBoxes] ADD CONSTRAINT [FK_BugNet_ProjectMailBoxes_Users] FOREIGN KEY ([AssignToUserId]) REFERENCES [dbo].[Users] ([UserId])
GO
