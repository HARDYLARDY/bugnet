CREATE TABLE [dbo].[BNPermissions]
(
[PermissionId] [int] NOT NULL,
[PermissionKey] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PermissionName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNPermissions] ADD CONSTRAINT [PK_BugNet_Permissions] PRIMARY KEY CLUSTERED  ([PermissionId]) ON [PRIMARY]
GO
