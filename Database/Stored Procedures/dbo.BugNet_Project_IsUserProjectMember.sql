SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Project_IsUserProjectMember]
	@UserName NVARCHAR(255),
	@ProjectId INT
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	IF EXISTS ( SELECT UserId FROM [BNUserProjects] WHERE UserId = @UserId AND ProjectId = @ProjectId )
		RETURN 0;
	ELSE
		RETURN -1;
GO
