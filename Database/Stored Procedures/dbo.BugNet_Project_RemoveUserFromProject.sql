SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Project_RemoveUserFromProject]
	@UserName NVARCHAR(255),
	@ProjectId INT
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	DELETE [BNUserProjects] WHERE UserId = @UserId AND ProjectId = @ProjectId;
GO
