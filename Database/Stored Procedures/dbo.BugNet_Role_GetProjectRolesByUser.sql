SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Role_GetProjectRolesByUser]
	@UserName NVARCHAR(256),
	@ProjectId INT
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	SELECT
		R.RoleName,
		R.ProjectId,
		R.RoleDescription,
		R.RoleId,
		R.AutoAssign
	FROM
		[dbo].[BNUserRoles]
		INNER JOIN [dbo].[Users] ON [BNUserRoles].[UserId] = [Users].[UserId]
		INNER JOIN [BNRoles] R ON [BNUserRoles].[RoleId] = R.RoleId
	WHERE
		[Users].[UserId] = @UserId
		AND (
				R.ProjectId IS NULL
				OR R.ProjectId = @ProjectId
			);
GO
