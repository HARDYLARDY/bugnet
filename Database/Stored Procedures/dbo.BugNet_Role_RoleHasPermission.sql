SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Role_RoleHasPermission]
	@ProjectID INT,
	@Role NVARCHAR(256),
	@PermissionKey NVARCHAR(50)
AS
	SELECT
		COUNT(*)
	FROM
		[dbo].[BNRolePermissions]
		INNER JOIN [dbo].[BNRoles] ON [BNRoles].[RoleId] = [BNRolePermissions].[RoleId]
		INNER JOIN [BNPermissions] ON [BNRolePermissions].[PermissionId] = [BNPermissions].[PermissionId]
	WHERE
		[BNRoles].[ProjectId] = @ProjectID
		AND PermissionKey = @PermissionKey
		AND [BNRoles].[RoleName] = @Role;
GO
