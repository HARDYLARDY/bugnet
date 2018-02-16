CREATE TABLE [dbo].[BNUserRoles]
(
[UserId] [uniqueidentifier] NOT NULL,
[RoleId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNUserRoles] ADD CONSTRAINT [PK_BugNet_UserRoles] PRIMARY KEY CLUSTERED  ([UserId], [RoleId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNUserRoles] ADD CONSTRAINT [FK_BugNet_UserRoles_BugNet_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[BNRoles] ([RoleId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNUserRoles] ADD CONSTRAINT [FK_BugNet_UserRoles_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE
GO
