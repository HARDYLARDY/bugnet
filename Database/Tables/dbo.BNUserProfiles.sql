CREATE TABLE [dbo].[BNUserProfiles]
(
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IssuesPageSize] [int] NULL,
[PreferredLocale] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastUpdate] [datetime] NOT NULL,
[SelectedIssueColumns] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReceiveEmailNotifications] [bit] NULL CONSTRAINT [DF_BugNet_UserProfiles_RecieveEmailNotifications] DEFAULT ((1)),
[PasswordVerificationToken] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PasswordVerificationTokenExpirationDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNUserProfiles] ADD CONSTRAINT [PK_BugNet_UserProfiles] PRIMARY KEY CLUSTERED  ([UserName]) ON [PRIMARY]
GO
