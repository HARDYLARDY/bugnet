CREATE TABLE [dbo].[UsersOpenAuthAccounts]
(
[ApplicationName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProviderName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProviderUserId] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProviderUserName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MembershipUserName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUsedUtc] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UsersOpenAuthAccounts] ADD CONSTRAINT [PK__UsersOpe__1186EEE06CF1EEFE] PRIMARY KEY CLUSTERED  ([ApplicationName], [ProviderName], [ProviderUserId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UsersOpenAuthAccounts] ADD CONSTRAINT [OpenAuthUserData_Accounts] FOREIGN KEY ([ApplicationName], [MembershipUserName]) REFERENCES [dbo].[UsersOpenAuthData] ([ApplicationName], [MembershipUserName]) ON DELETE CASCADE
GO
