CREATE TABLE [dbo].[BNProjectCustomFields]
(
[CustomFieldId] [int] NOT NULL IDENTITY(1, 1),
[ProjectId] [int] NOT NULL,
[CustomFieldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomFieldRequired] [bit] NOT NULL,
[CustomFieldDataType] [int] NOT NULL,
[CustomFieldTypeId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectCustomFields] ADD CONSTRAINT [PK_BugNet_ProjectCustomFields] PRIMARY KEY CLUSTERED  ([CustomFieldId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectCustomFields] ADD CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_ProjectCustomFieldType] FOREIGN KEY ([CustomFieldTypeId]) REFERENCES [dbo].[BNProjectCustomFieldTypes] ([CustomFieldTypeId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNProjectCustomFields] ADD CONSTRAINT [FK_BugNet_ProjectCustomFields_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
