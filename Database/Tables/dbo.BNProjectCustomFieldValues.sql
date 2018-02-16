CREATE TABLE [dbo].[BNProjectCustomFieldValues]
(
[CustomFieldValueId] [int] NOT NULL IDENTITY(1, 1),
[IssueId] [int] NOT NULL,
[CustomFieldId] [int] NOT NULL,
[CustomFieldValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectCustomFieldValues] ADD CONSTRAINT [PK_BugNet_ProjectCustomFieldValues] PRIMARY KEY CLUSTERED  ([CustomFieldValueId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectCustomFieldValues] ADD CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BNIssues] ([IssueId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNProjectCustomFieldValues] ADD CONSTRAINT [FK_BugNet_ProjectCustomFieldValues_BugNet_ProjectCustomFields] FOREIGN KEY ([CustomFieldId]) REFERENCES [dbo].[BNProjectCustomFields] ([CustomFieldId])
GO
