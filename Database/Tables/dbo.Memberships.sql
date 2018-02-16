CREATE TABLE [dbo].[Memberships]
(
[ApplicationId] [uniqueidentifier] NOT NULL,
[UserId] [uniqueidentifier] NOT NULL,
[Password] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PasswordFormat] [int] NOT NULL,
[PasswordSalt] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Email] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PasswordQuestion] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PasswordAnswer] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsApproved] [bit] NOT NULL,
[IsLockedOut] [bit] NOT NULL,
[CreateDate] [datetime] NOT NULL,
[LastLoginDate] [datetime] NOT NULL,
[LastPasswordChangedDate] [datetime] NOT NULL,
[LastLockoutDate] [datetime] NOT NULL,
[FailedPasswordAttemptCount] [int] NOT NULL,
[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
[FailedPasswordAnswerAttemptWindowsStart] [datetime] NOT NULL,
[Comment] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Memberships] ADD CONSTRAINT [PK__Membersh__1788CC4C75E3BE36] PRIMARY KEY CLUSTERED  ([UserId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Memberships] ADD CONSTRAINT [MembershipApplication] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[Memberships] ADD CONSTRAINT [MembershipUser] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
