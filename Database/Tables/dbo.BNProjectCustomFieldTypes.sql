CREATE TABLE [dbo].[BNProjectCustomFieldTypes]
(
[CustomFieldTypeId] [int] NOT NULL IDENTITY(1, 1),
[CustomFieldTypeName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectCustomFieldTypes] ADD CONSTRAINT [PK_BugNet_ProjectCustomFieldTypes] PRIMARY KEY CLUSTERED  ([CustomFieldTypeId]) ON [PRIMARY]
GO
