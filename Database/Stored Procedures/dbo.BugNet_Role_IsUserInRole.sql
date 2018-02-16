SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Role_IsUserInRole]
	@UserName NVARCHAR(256),
	@RoleId INT,
	@ProjectId INT
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	SELECT
		[UR].[UserId],
		[UR].[RoleId]
	FROM
		[dbo].[BNUserRoles] UR
		INNER JOIN [BNRoles] R ON [UR].[RoleId] = R.RoleId
	WHERE
		[UR].[UserId] = @UserId
		AND [UR].[RoleId] = @RoleId
		AND R.ProjectId = @ProjectId;
GO
