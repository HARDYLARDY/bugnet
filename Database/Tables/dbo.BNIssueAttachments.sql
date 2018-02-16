CREATE TABLE [dbo].[BNIssueAttachments]
(
[IssueAttachmentId] [int] NOT NULL IDENTITY(1, 1),
[IssueId] [int] NOT NULL,
[FileName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FileSize] [int] NOT NULL,
[ContentType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateCreated] [datetime] NOT NULL CONSTRAINT [DF_BugNet_IssueAttachments_DateCreated] DEFAULT (getdate()),
[UserId] [uniqueidentifier] NOT NULL,
[Attachment] [varbinary] (max) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueAttachments] ADD CONSTRAINT [PK_BugNet_IssueAttachments] PRIMARY KEY CLUSTERED  ([IssueAttachmentId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueAttachments] ADD CONSTRAINT [FK_BugNet_IssueAttachments_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BNIssues] ([IssueId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNIssueAttachments] ADD CONSTRAINT [FK_BugNet_IssueAttachments_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
