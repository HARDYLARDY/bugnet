SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Role_RemoveUserFromRole]
	@UserName NVARCHAR(256),
	@RoleId INT
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	DELETE [BNUserRoles] WHERE UserId = @UserId AND RoleId = @RoleId;
GO
