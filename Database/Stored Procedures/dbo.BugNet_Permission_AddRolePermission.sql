SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Permission_AddRolePermission]
	@PermissionId INT,
	@RoleId INT
AS
	IF NOT EXISTS
	 (
		 SELECT
			 PermissionId
		 FROM
			 [BNRolePermissions]
		 WHERE
			 PermissionId = @PermissionId
			 AND RoleId = @RoleId
	 )
	BEGIN
		INSERT [BNRolePermissions] ( PermissionId, RoleId ) VALUES ( @PermissionId, @RoleId );
	END;
GO
