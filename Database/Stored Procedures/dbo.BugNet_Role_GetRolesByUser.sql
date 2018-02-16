SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Role_GetRolesByUser]
	@UserName NVARCHAR(256)
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	SELECT
		[BNRoles].[RoleName],
		[BNRoles].[ProjectId],
		[BNRoles].[RoleDescription],
		[BNRoles].[RoleId],
		[BNRoles].[AutoAssign]
	FROM
		[dbo].[BNUserRoles]
		INNER JOIN [dbo].[Users] ON [BNUserRoles].[UserId] = [Users].[UserId]
		INNER JOIN [BNRoles] ON [BNUserRoles].[RoleId] = [BNRoles].[RoleId]
	WHERE
		[Users].[UserId] = @UserId;
GO
