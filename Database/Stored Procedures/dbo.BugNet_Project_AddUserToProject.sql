SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Project_AddUserToProject]
	@UserName NVARCHAR(255),
	@ProjectId INT
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	IF NOT EXISTS
	 (
		 SELECT UserId FROM [BNUserProjects] WHERE UserId = @UserId AND ProjectId = @ProjectId
	 )
	BEGIN
		INSERT [BNUserProjects] ( UserId, ProjectId, DateCreated ) VALUES ( @UserId, @ProjectId, GETDATE());
	END;
GO
