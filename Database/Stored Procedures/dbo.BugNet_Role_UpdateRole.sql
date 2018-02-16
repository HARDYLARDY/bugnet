SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Role_UpdateRole]
	@RoleId INT,
	@RoleName NVARCHAR(256),
	@RoleDescription NVARCHAR(256),
	@AutoAssign BIT,
	@ProjectId INT
AS
	UPDATE
		[BNRoles]
	SET
		RoleName = @RoleName,
		RoleDescription = @RoleDescription,
		AutoAssign = @AutoAssign,
		ProjectId = @ProjectId
	WHERE
		RoleId = @RoleId;
GO
