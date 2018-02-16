SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Role_CreateNewRole]
	@ProjectId INT,
	@RoleName NVARCHAR(256),
	@RoleDescription NVARCHAR(256),
	@AutoAssign BIT
AS
	INSERT
		[BNRoles]
		 (
			 ProjectId,
			 RoleName,
			 RoleDescription,
			 AutoAssign
		 )
	VALUES
		 (
			 @ProjectId, @RoleName, @RoleDescription, @AutoAssign
		 );

	RETURN SCOPE_IDENTITY();
GO
