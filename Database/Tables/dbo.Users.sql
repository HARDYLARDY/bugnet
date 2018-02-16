CREATE TABLE [dbo].[Users]
(
[ApplicationId] [uniqueidentifier] NOT NULL,
[UserId] [uniqueidentifier] NOT NULL,
[UserName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsAnonymous] [bit] NOT NULL,
[LastActivityDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [PK__Users__1788CC4C4C7BBB03] PRIMARY KEY CLUSTERED  ([UserId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_UserName] ON [dbo].[Users] ([UserName]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [UserApplication] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[Applications] ([ApplicationId])
GO
