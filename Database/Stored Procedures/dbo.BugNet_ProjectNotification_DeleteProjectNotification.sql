SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_DeleteProjectNotification]
	@ProjectId INT,
	@UserName NVARCHAR(255)
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	DELETE [BNProjectNotifications] WHERE ProjectId = @ProjectId AND UserId = @UserId;
GO
