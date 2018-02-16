CREATE TABLE [dbo].[BNProjectCustomFieldSelections]
(
[CustomFieldSelectionId] [int] NOT NULL IDENTITY(1, 1),
[CustomFieldId] [int] NOT NULL,
[CustomFieldSelectionValue] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomFieldSelectionName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomFieldSelectionSortOrder] [int] NOT NULL CONSTRAINT [DF_BugNet_ProjectCustomFieldSelections_CustomFieldSelectionSortOrder] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectCustomFieldSelections] ADD CONSTRAINT [PK_BugNet_ProjectCustomFieldSelections] PRIMARY KEY CLUSTERED  ([CustomFieldSelectionId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectCustomFieldSelections] ADD CONSTRAINT [FK_BugNet_ProjectCustomFieldSelections_BugNet_ProjectCustomFields] FOREIGN KEY ([CustomFieldId]) REFERENCES [dbo].[BNProjectCustomFields] ([CustomFieldId]) ON DELETE CASCADE
GO
