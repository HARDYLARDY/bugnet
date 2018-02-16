CREATE TABLE [dbo].[UsersOpenAuthData]
(
[ApplicationName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MembershipUserName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[HasLocalPassword] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UsersOpenAuthData] ADD CONSTRAINT [PK__UsersOpe__0B1BEB718C013385] PRIMARY KEY CLUSTERED  ([ApplicationName], [MembershipUserName]) ON [PRIMARY]
GO
