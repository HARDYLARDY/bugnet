CREATE TABLE [dbo].[BNRolePermissions]
(
[PermissionId] [int] NOT NULL,
[RoleId] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNRolePermissions] ADD CONSTRAINT [PK_BugNet_RolePermissions] PRIMARY KEY CLUSTERED  ([RoleId], [PermissionId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNRolePermissions] WITH NOCHECK ADD CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Permissions] FOREIGN KEY ([PermissionId]) REFERENCES [dbo].[BNPermissions] ([PermissionId])
GO
ALTER TABLE [dbo].[BNRolePermissions] ADD CONSTRAINT [FK_BugNet_RolePermissions_BugNet_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[BNRoles] ([RoleId]) ON DELETE CASCADE
GO
