CREATE TABLE [dbo].[BNRoles]
(
[RoleId] [int] NOT NULL IDENTITY(1, 1),
[ProjectId] [int] NULL,
[RoleName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RoleDescription] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AutoAssign] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNRoles] ADD CONSTRAINT [PK_BugNet_Roles] PRIMARY KEY CLUSTERED  ([RoleId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNRoles] ADD CONSTRAINT [FK_BugNet_Roles_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
