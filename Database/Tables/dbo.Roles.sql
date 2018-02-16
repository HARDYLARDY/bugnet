CREATE TABLE [dbo].[Roles]
(
[ApplicationId] [uniqueidentifier] NOT NULL,
[RoleId] [uniqueidentifier] NOT NULL,
[RoleName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Roles] ADD CONSTRAINT [PK__Roles__8AFACE1ABC89B8E3] PRIMARY KEY CLUSTERED  ([RoleId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Roles] ADD CONSTRAINT [RoleApplication] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[Applications] ([ApplicationId])
GO
