SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Role_GetRoleById]
	@RoleId INT
AS
	SELECT
		RoleId,
		ProjectId,
		RoleName,
		RoleDescription,
		AutoAssign
	FROM
		[BNRoles]
	WHERE
		RoleId = @RoleId;
GO
