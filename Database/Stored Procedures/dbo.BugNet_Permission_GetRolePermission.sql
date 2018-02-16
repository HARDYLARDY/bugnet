SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Permission_GetRolePermission]
AS
	SELECT
		[R].[RoleId],
		[R].[ProjectId],
		P.PermissionId,
		P.PermissionKey,
		[R].[RoleName],
		P.PermissionName
	FROM
		[dbo].[BNRolePermissions] RP
		JOIN [BNPermissions] P ON [RP].[PermissionId] = P.PermissionId
		JOIN [dbo].[BNRoles] R ON [RP].[RoleId] = [R].[RoleId];
GO
