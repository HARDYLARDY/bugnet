SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Permission_GetPermissionsByRole]
	@RoleId INT
AS
	SELECT
		[BNPermissions].[PermissionId],
		PermissionKey,
		PermissionName
	FROM
		[BNPermissions]
		INNER JOIN [dbo].[BNRolePermissions] ON [BNRolePermissions].[PermissionId] = [BNPermissions].[PermissionId]
	WHERE
		[BNRolePermissions].[RoleId] = @RoleId;
GO
