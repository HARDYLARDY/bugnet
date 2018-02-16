CREATE TABLE [dbo].[BNRequiredFieldList]
(
[RequiredFieldId] [int] NOT NULL,
[FieldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FieldValue] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNRequiredFieldList] ADD CONSTRAINT [PK_BugNet_RequiredFieldList] PRIMARY KEY CLUSTERED  ([RequiredFieldId]) ON [PRIMARY]
GO
