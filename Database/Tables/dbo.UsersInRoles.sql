CREATE TABLE [dbo].[UsersInRoles]
(
[UserId] [uniqueidentifier] NOT NULL,
[RoleId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UsersInRoles] ADD CONSTRAINT [PK__UsersInR__AF2760ADEEAD056D] PRIMARY KEY CLUSTERED  ([UserId], [RoleId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UsersInRoles] ADD CONSTRAINT [UsersInRoleRole] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[UsersInRoles] ADD CONSTRAINT [UsersInRoleUser] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
