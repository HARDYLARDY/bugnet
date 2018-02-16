CREATE TABLE [dbo].[BNQueryClauses]
(
[QueryClauseId] [int] NOT NULL IDENTITY(1, 1),
[QueryId] [int] NOT NULL,
[BooleanOperator] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FieldName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ComparisonOperator] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FieldValue] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DataType] [int] NOT NULL,
[CustomFieldId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNQueryClauses] ADD CONSTRAINT [PK_BugNet_QueryClauses] PRIMARY KEY CLUSTERED  ([QueryClauseId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNQueryClauses] ADD CONSTRAINT [FK_BugNet_QueryClauses_BugNet_Queries] FOREIGN KEY ([QueryId]) REFERENCES [dbo].[BNQueries] ([QueryId]) ON DELETE CASCADE
GO
