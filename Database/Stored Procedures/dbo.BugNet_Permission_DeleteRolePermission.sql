SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Permission_DeleteRolePermission]
	@PermissionId INT,
	@RoleId INT
AS
	DELETE [BNRolePermissions] WHERE PermissionId = @PermissionId AND RoleId = @RoleId;
GO
