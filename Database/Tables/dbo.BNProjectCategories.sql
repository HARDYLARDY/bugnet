CREATE TABLE [dbo].[BNProjectCategories]
(
[CategoryId] [int] NOT NULL IDENTITY(1, 1),
[CategoryName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProjectId] [int] NOT NULL,
[ParentCategoryId] [int] NOT NULL CONSTRAINT [DF_BugNet_ProjectCategories_ParentCategoryId] DEFAULT ((0)),
[Disabled] [bit] NOT NULL CONSTRAINT [DF_BugNet_ProjectCategories_Disabled] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectCategories] ADD CONSTRAINT [PK_BugNet_ProjectCategories] PRIMARY KEY CLUSTERED  ([CategoryId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectCategories] ADD CONSTRAINT [FK_BugNet_ProjectCategories_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
