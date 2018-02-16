SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Role_AddUserToRole]
	@UserName NVARCHAR(256),
	@RoleId INT
AS
	DECLARE @ProjectId INT;
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	SELECT @ProjectId = ProjectId FROM [BNRoles] WHERE RoleId = @RoleId;

	IF NOT EXISTS
	 (
		 SELECT
			 [BNUserProjects].[UserId]
		 FROM
			 [dbo].[BNUserProjects]
		 WHERE
			 [BNUserProjects].[UserId] = @UserId
			 AND [BNUserProjects].[ProjectId] = @ProjectId
	 )
	   AND @RoleId <> 1
	BEGIN
		EXEC [dbo].[BugNet_Project_AddUserToProject] @UserName, @ProjectId;
	END;

	IF NOT EXISTS
	 (
		 SELECT
			 [BNUserRoles].[UserId]
		 FROM
			 [dbo].[BNUserRoles]
		 WHERE
			 [BNUserRoles].[UserId] = @UserId
			 AND [BNUserRoles].[RoleId] = @RoleId
	 )
	BEGIN
		INSERT [dbo].[BNUserRoles] ( UserId, RoleId ) VALUES ( @UserId, @RoleId );
	END;
GO
