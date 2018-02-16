SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_CreateNewProjectNotification]
	@ProjectId INT,
	@NotificationUserName NVARCHAR(255)
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT
		@UserId = [Users].[UserId]
	FROM
		[dbo].[Users]
	WHERE
		[Users].[UserName] = @NotificationUserName;

	IF NOT EXISTS
	 (
		 SELECT
			 ProjectNotificationId
		 FROM
			 [BNProjectNotifications]
		 WHERE
			 UserId = @UserId
			 AND ProjectId = @ProjectId
	 )
	BEGIN
		INSERT [BNProjectNotifications] ( ProjectId, UserId ) VALUES ( @ProjectId, @UserId );

		RETURN SCOPE_IDENTITY();
	END;
GO
