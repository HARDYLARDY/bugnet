SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

CREATE PROCEDURE [dbo].[BugNet_Permission_GetAllPermissions]
AS
	SELECT PermissionId, PermissionKey, PermissionName FROM [BNPermissions];
GO
