SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Role_GetRolesByProject]
	@ProjectId INT
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
		ProjectId = @ProjectId;
GO
