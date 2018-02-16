CREATE TABLE [dbo].[BNLanguages]
(
[LanguageId] [int] NOT NULL IDENTITY(1, 1),
[CultureCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CultureName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FallbackCulture] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNLanguages] ADD CONSTRAINT [PK_BugNet_Languages] PRIMARY KEY CLUSTERED  ([LanguageId]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_BugNet_Languages] ON [dbo].[BNLanguages] ([CultureCode]) ON [PRIMARY]
GO
